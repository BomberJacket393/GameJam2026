extends Node2D

var sectorManager
var cursor : Area2D

@export var halLight : Sprite2D
@export var poweredDownColor : Color
@export var poweredOnColor : Color
var isBeingHovered : bool

@onready var hitbox: Area2D = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sectorManager = PD
	cursor = get_tree().get_nodes_in_group("cursor")[0].get_node("Area2D")
	halLight.self_modulate = poweredDownColor

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if sectorManager.isGridCollapsed():
		halLight.self_modulate = poweredOnColor
		isBeingHovered = checkCursorContact()
		if isBeingHovered:
			if Input.is_action_just_pressed("lmb"):
				resetPower()
	else:
		halLight.self_modulate = poweredDownColor

func checkCursorContact():
	var touchedAreas = hitbox.get_overlapping_areas()
	for area in touchedAreas:
		if area.is_in_group("cursor"):
			return true
	return false
	
func resetPower():
	sectorManager.reboot()
