extends Node

class_name round_handler

##Whole round system could do with rework, batch system was a mistep

@export var enemiesPerRound : Array[int]
@export var enemiesLeftToSpawn : int
@export var currentRound : int
@export var enemyTarget : Node2D
@export var spawners : Array[Node]
@export var timeBetweenBatchesFactor : float
@export var intermissionTime : int
@export var enemySpeedFactor : float
@export var batchReleaseDelayFactor : float
var inIntermission : bool = false
var intermissionTimer : float
var timeBetweenBatches : float
##When there are no enemies, Wait a few seconds
##If still no enemies, persist to next round 
@export var timeBeforeEndingRound : float
var timeWithNoLivingEnemies : float
var enemiesConfirmedDead : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collectSpawners()
	startRound()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var livingEnemyCount = get_tree().get_nodes_in_group("enemies").size()
	if livingEnemyCount == 0 and not inIntermission:
		timeWithNoLivingEnemies += delta
		if timeWithNoLivingEnemies > timeBeforeEndingRound:
			enemiesConfirmedDead = true
	else:
		timeWithNoLivingEnemies = 0 
		
	if enemiesLeftToSpawn <= 0 and enemiesConfirmedDead and not inIntermission:
		roundOver()
	if inIntermission:
		intermissionTimer -= delta
		if intermissionTimer <= 0:
			startRound() 
	
func getEnemiesInRound():
	return enemiesLeftToSpawn

func decrementEnemy():
	enemiesLeftToSpawn -= 1

func roundOver():
	collectSpawners()
	print("ROUND OVER")
	for spawner in spawners:
		spawner.roundOver()
	currentRound += 1
	inIntermission = true
	enemiesConfirmedDead = false
	intermissionTimer = intermissionTime	
	
func startRound():
	print("BEGINNING_ROUND_"+str(currentRound))
	collectSpawners()
	inIntermission = false
	enemiesLeftToSpawn = enemiesPerRound[currentRound]

	for spawner in spawners:
		spawner.roundStart(enemiesLeftToSpawn * enemySpeedFactor, 1/(1+currentRound))
	
func collectSpawners():
	spawners = get_tree().get_nodes_in_group("spawners")
