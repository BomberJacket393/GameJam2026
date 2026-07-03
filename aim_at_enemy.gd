extends Node2D

@export var rotationSpeed : float
@export var testTarget : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target = _find_target()
	_aim_at_target(target)

func _find_target():
	print("NEED TO CHANGE METHOD")
	return testTarget

func _aim_at_target(target : Vector2):
	var targetAngle = get_angle_to(target)
	rotate_toward(rotation,targetAngle,rotationSpeed)
