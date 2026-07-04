extends Node2D

@export var maxPower = 100
@export var availablePower = 100
@export var powerPerSecond = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if maxPower > availablePower:
		availablePower+=powerPerSecond*delta
		availablePower = round(availablePower)
		if availablePower>maxPower:
			availablePower = maxPower
