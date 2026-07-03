extends Node2D

@export var mousePos : Vector2
@export var mousePosGridSnap : Vector2

@export var gridSize : int

@export var currentTurret : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mousePos = get_global_mouse_position()
	mousePosGridSnap.x = (int(mousePos.x)/gridSize) * gridSize	
	mousePosGridSnap.y = (int(mousePos.y)/gridSize) * gridSize	
		
	if Input.is_action_just_pressed("lmb") and mousePos != Vector2.ZERO:

		var turretInstance = currentTurret.instantiate()
		turretInstance.position = mousePosGridSnap
		get_tree().current_scene.add_child(turretInstance)
