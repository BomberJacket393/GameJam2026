extends Node

class_name round_handler

@export var enemiesPerRound : Array[int]
@export var currentEnemiesInRound : int
@export var currentRound : int
@export var enemyTarget : Node2D
@export var spawners : Array[Node]
@export var timeBetweenBatchesFactor : float
@export var intermissionTime : int
@export var enemySpeedFactor : float
@export var batchReleaseDelayFactor : float
var inIntermission : bool = false
var intermissionTimer : float
var timeBetweenBatches

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collectSpawners()
	startRound()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if currentEnemiesInRound <= 0 and not inIntermission:
		roundOver()
		inIntermission = true
	if inIntermission:
		intermissionTimer -= delta
		if intermissionTimer <= 0:
			startRound() 
	
func getEnemiesInRound():
	return currentEnemiesInRound

func decrementEnemy():
	currentEnemiesInRound -= 1

func roundOver():
	collectSpawners()
	print("ROUND OVER")
	for spawner in spawners:
		spawner.roundOver()
	currentRound += 1
	inIntermission = true
	intermissionTimer = intermissionTime	
	
func startRound():
	collectSpawners()
	inIntermission = false
	currentEnemiesInRound = enemiesPerRound[currentRound]
	timeBetweenBatches = timeBetweenBatchesFactor * (1 / currentEnemiesInRound)
	for spawner in spawners:
		spawner.roundStart(timeBetweenBatches, currentEnemiesInRound * enemySpeedFactor, batchReleaseDelayFactor * 1 / currentEnemiesInRound)
	
func collectSpawners():
	spawners = get_tree().get_nodes_in_group("spawners")
