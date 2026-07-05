extends Node2D

@export var errorPanel : PackedScene

var currentSpawnPosition
@export var yIncrement : int
@export var xIncrement : int
@export var panelsPerBatch : int
@export var panelDelayMax : float
var panelTimer : float
var batchesDone : int

@export var sequentialPanelFactor : float

@export var doSound : bool = false

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panelTimer = 0
	currentSpawnPosition = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	panelTimer -= delta
	if panelTimer <= 0 and panelsPerBatch > batchesDone:
		var panelInstance = errorPanel.instantiate() as Node2D
		panelInstance.global_position = currentSpawnPosition
		currentSpawnPosition += Vector2(xIncrement, yIncrement)
		panelTimer = rng.randf_range(panelDelayMax/2,panelDelayMax)
		panelDelayMax *= sequentialPanelFactor
		if not doSound:
			panelInstance.get_node("AudioStreamPlayer2D").process_mode = Node.PROCESS_MODE_DISABLED
		get_tree().current_scene.add_child(panelInstance)
		batchesDone += 1
