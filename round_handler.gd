extends Node

class_name round_handler

@export var enemiesPerRound : Array[int]
@export var currentEnemiesInRound : int
@export var currentRound : int
@export var enemyTarget : Node2D
@export var spawners : Array[Node]
var inIntermission : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collectSpawners()
	startRound()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if currentEnemiesInRound <= 0 and not inIntermission:
		roundOver()
		inIntermission = true
	
func getEnemiesInRound():
	return currentEnemiesInRound

func decrementEnemy():
	currentEnemiesInRound -= 1

func roundOver():
	print("ROUND OVER")
	for spawner in spawners:
		spawner.roundOver()
	currentRound += 1
	
func startRound():
	currentEnemiesInRound = enemiesPerRound[currentRound]
	
func collectSpawners():
	spawners = get_tree().get_nodes_in_group("spawners")
