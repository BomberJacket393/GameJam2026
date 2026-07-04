extends Node2D

@onready var timer: Timer = $Timer
@export var enemy : PackedScene
##Shared round handler accross all spawners
@export var roundHandler : round_handler
var enemySpeed : float
@export var isIntermission : bool
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(spawnEnemy)
	
func spawnEnemy():
	if not isIntermission and roundHandler.getEnemiesInRound()>0:
		roundHandler.decrementEnemy()
		var enemyInstance = enemy.instantiate()
		enemyInstance.position = position
		enemyInstance.target = roundHandler.enemyTarget
		enemyInstance.speed = enemySpeed
		get_tree().current_scene.add_child(enemyInstance)
	
func roundStart(_enemySpeed, spawnDelay):
	enemySpeed = _enemySpeed
	timer.wait_time = spawnDelay
	isIntermission = false
	
func roundOver():
	isIntermission = true
		
