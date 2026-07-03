extends Node2D

@onready var timer: Timer = $Timer
@export var enemy : PackedScene
##Shared round handler accross all spawners
@export var roundHandler : round_handler
@export var enemiesInBatchRange : Array[int]
@export var currentBatchSize : int
@export var batchReleaseDelay : float
var batchReleaseTimer : float
var releasingBatch : bool
@export var isIntermission : bool

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(processBatch)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer.paused = releasingBatch or isIntermission
	if not isIntermission:
		if releasingBatch and batchReleaseTimer <= 0:
			spawnEnemy()
			currentBatchSize -= 1
			roundHandler.decrementEnemy()
			batchReleaseTimer = batchReleaseDelay
		if releasingBatch:
			batchReleaseTimer -= delta
			
		if currentBatchSize <= 0 and releasingBatch:
			releasingBatch = false
			currentBatchSize = 0
	
func processBatch():
	releasingBatch = true
	currentBatchSize = rng.randi_range(enemiesInBatchRange[0],enemiesInBatchRange[1])
	print(str(name).to_upper()+" BEGINNING BATCH RELEASE OF SIZE "+str(currentBatchSize))
	batchReleaseTimer = 0
	
func spawnEnemy():
	var enemyInstance = enemy.instantiate()
	enemyInstance.position = position
	enemyInstance.target = roundHandler.enemyTarget
	get_tree().current_scene.add_child(enemyInstance)
	releasingBatch = true
	
func roundOver():
	isIntermission = true
	currentBatchSize = 0
		
		
