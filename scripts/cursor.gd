extends Node2D

@export var mousePos : Vector2
@export var mousePosGridSnap : Vector2

@export var gridSize : int
@onready var ghost_turret_box: Sprite2D = $ghostTurretBox

@export var turrets : Array[PackedScene]
##Which turret will i next place?
@export var currentTurretIndex : int = 0
@export var cursorArea : Area2D
var numberOfTurrets : int
var _touchingTurret : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	numberOfTurrets = turrets.size()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mousePos = get_global_mouse_position()
	position = mousePos
	mousePosGridSnap.x = round(mousePos.x/gridSize) * gridSize ##- gridSize/2
	mousePosGridSnap.y = round(mousePos.y/gridSize) * gridSize ##- gridSize/2
	
	ghost_turret_box.global_position = mousePosGridSnap
	_touchingTurret = _isTouchingTurret()
		
	if Input.is_action_just_pressed("cycle_left"): 
		if currentTurretIndex == 0:
			currentTurretIndex = numberOfTurrets - 1
		else:
			currentTurretIndex -= 1
	if Input.is_action_just_pressed("cycle_right"): 
		if currentTurretIndex == numberOfTurrets - 1:
			currentTurretIndex = 0
		else:
			currentTurretIndex += 1
		
	if Input.is_action_just_pressed("lmb") and mousePos != Vector2.ZERO and not _touchingTurret:
		placeTurret()	

func placeTurret():
	var turretInstance = turrets[currentTurretIndex].instantiate()
	turretInstance.position = mousePosGridSnap
	get_tree().current_scene.add_child(turretInstance)
	var area = turretInstance.get_node("TurretArea")
	
func _isTouchingTurret():
	_touchingTurret = false
	var touchedAreas = cursorArea.get_overlapping_areas()
	for area in touchedAreas:
		if area.is_in_group("turret_base_group"):
			_touchingTurret = true
			##print("IS_TOUCHING_TURRET")
		break
	return _touchingTurret
			
