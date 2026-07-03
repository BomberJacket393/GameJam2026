extends Node2D

@onready var timer: Timer = $Timer
@export var enemy : PackedScene
##Shared round handler accross all spawners
@export var roundHandler : round_handler
@export var enemiesInBatchRange : Array[int]
@export var currentBatchSize : int
var currentBatchReleaseDelay : float = 0.3
var batchReleaseTimer : float
var releasingBatch : bool
var enemySpeed : float
@export var isIntermission : bool
var timeBetweenBatches : float
@export var batchSizeRoundIncrement : int

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
			batchReleaseTimer = currentBatchReleaseDelay
		if releasingBatch:
			batchReleaseTimer -= delta
			
		if currentBatchSize <= 0 and releasingBatch:
			releasingBatch = false
			currentBatchSize = 0
	
func processBatch():
	releasingBatch = true
	currentBatchSize = rng.randi_range(enemiesInBatchRange[0],enemiesInBatchRange[1])
	#print(str(name).to_upper()+" BEGINNING BATCH RELEASE OF SIZE "+str(currentBatchSize))
	batchReleaseTimer = 0
	
func spawnEnemy():
	var enemyInstance = enemy.instantiate()
	enemyInstance.position = position
	enemyInstance.target = roundHandler.enemyTarget
	enemyInstance.speed = enemySpeed
	get_tree().current_scene.add_child(enemyInstance)
	releasingBatch = true
	
func roundStart(_timeBetweenBatches, _enemySpeed, _batchReleaseDelay):
	enemySpeed = _enemySpeed
	timeBetweenBatches = _timeBetweenBatches
	timer.wait_time = timeBetweenBatches
	currentBatchReleaseDelay = _batchReleaseDelay
	isIntermission = false
	
func roundOver():
	isIntermission = true
	currentBatchSize = 0
	enemiesInBatchRange[0] += batchSizeRoundIncrement
	enemiesInBatchRange[1] += batchSizeRoundIncrement
		
