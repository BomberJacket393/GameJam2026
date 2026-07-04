extends Node2D

@export var mousePos : Vector2
@export var mousePosGridSnap : Vector2

@export var gridSize : int
@onready var ghost_turret_box: Sprite2D = $ghostTurretBox

@export var turrets : Array[PackedScene]
##Which turret will i next place?
@export var currentTurretIndex : int = 0
@export var cursorArea : Area2D
@export var cursorGridArea : Area2D
var numberOfTurrets : int
var _touchingTurret : bool
var _inSector : bool

##The ghost is the transparent image of a turret before its placed
##Follows cursor and lets player decide where to place it
var showPlacementGhost : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	numberOfTurrets = turrets.size()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mouseHandling()
	ghost_turret_box.global_position = mousePosGridSnap
	_touchingTurret = _isTouchingTurret()
	_inSector = _isInSector()
	showPlacementGhost = _inSector and not _touchingTurret		
	ghost_turret_box.visible = showPlacementGhost
		
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
		
	if Input.is_action_just_pressed("lmb") and canPlaceTurret():
		placeTurret()	

func mouseHandling():
	mousePos = get_global_mouse_position()
	position = mousePos
	mousePosGridSnap.x = floor(mousePos.x/gridSize) * gridSize + gridSize/2
	mousePosGridSnap.y = floor(mousePos.y/gridSize) * gridSize + gridSize/2

func canPlaceTurret():
	return _inSector and mousePos != Vector2.ZERO and not _touchingTurret

func placeTurret():
	var turretInstance = turrets[currentTurretIndex].instantiate()
	turretInstance.position = mousePosGridSnap
	get_tree().current_scene.add_child(turretInstance)
	
func _isTouchingTurret():
	_touchingTurret = false
	var touchedAreas = cursorArea.get_overlapping_areas()
	touchedAreas.append_array(cursorGridArea.get_overlapping_areas())
	for area in touchedAreas:
		if area.is_in_group("turret_base_group"):
			_touchingTurret = true
			##print("IS_TOUCHING_TURRET")
			break
	return _touchingTurret
			
func _isInSector():
	_inSector = false
	##Not an area 2d so have to use different method
	var touchedAreas = cursorArea.get_overlapping_bodies()
	for area in touchedAreas:
		if area.is_in_group("sector"):
			print("TOUCHING_SECTOR")
			_inSector = true
			break
	return _inSector
			
