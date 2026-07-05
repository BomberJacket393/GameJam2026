extends Node

class_name round_handler

##Whole round system could do with rework, batch system was a mistep

@export var enemiesPerRound : Array[int]
@export var enemiesLeftToSpawn : int
@export var currentRound : int
@export var enemyTarget : Node2D
@export var spawners : Array[Node]
@export var intermissionTime : int
@export var enemySpeedFactor : float
@export var flatEnemySpeed : float
var inIntermission : bool = false
var intermissionTimer : float
@export var activeSpawners : Array = []
##When there are no enemies, Wait a few seconds
##If still no enemies, persist to next round 
@export var timeBeforeEndingRound : float
var timeWithNoLivingEnemies : float
@export var enemiesConfirmedDead : bool = false
var rng = RandomNumberGenerator.new()
var hasEnemyDiesThisRound : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collectSpawners()
	startRound(rollSpawners(1))

func rollSpawners(spawnerCount):
	if spawnerCount >= spawners.size():
		return spawners
	var spawnerPool = spawners
	var chosenSpawners = []
	for i in range(spawnerCount):
		var numOfSpawners = spawnerPool.size()
		var chosenSpawnerIndex = rng.randi_range(0,numOfSpawners-1)
		chosenSpawners.append(spawnerPool[chosenSpawnerIndex])
		spawnerPool.remove_at(chosenSpawnerIndex)
	return chosenSpawners

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var livingEnemyCount = get_tree().get_nodes_in_group("enemies").size()
	RoundInformation.livingEnemies = livingEnemyCount
	RoundInformation.currentRound = currentRound
	if livingEnemyCount == 0 and not inIntermission:
		timeWithNoLivingEnemies += delta
		if timeWithNoLivingEnemies > timeBeforeEndingRound:
			enemiesConfirmedDead = true
	else:
		timeWithNoLivingEnemies = 0 
		
	if enemiesLeftToSpawn <= 0 and enemiesConfirmedDead and not inIntermission and hasEnemyDiesThisRound:
		roundOver()
	if inIntermission:
		intermissionTimer -= delta
		if intermissionTimer <= 0:
			activeSpawners = rollSpawners(currentRound+1)		
			startRound(activeSpawners) 
	
func getEnemiesInRound():
	return enemiesLeftToSpawn

func decrementEnemy():
	enemiesLeftToSpawn -= 1
	hasEnemyDiesThisRound = true

func roundOver():
	collectSpawners()
	print("ROUND OVER")
	for spawner in spawners:
		spawner.roundOver()
	currentRound += 1
	inIntermission = true
	enemiesConfirmedDead = false
	hasEnemyDiesThisRound = false
	intermissionTimer = intermissionTime	
	
func startRound(activeSpawners):
	print("BEGINNING_ROUND_"+str(currentRound))
	inIntermission = false
	enemiesLeftToSpawn = enemiesPerRound[currentRound]
	for spawner in activeSpawners:
		spawner.roundStart(currentRound * enemySpeedFactor + flatEnemySpeed, 0.8 ** currentRound)
	
func collectSpawners():
	spawners = get_tree().get_nodes_in_group("spawners")
