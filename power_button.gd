extends Node2D

var associatedSector
var cursor : Area2D

@export var halLight : Sprite2D
@export var gridCollapsePoweredOnColor : Color
@export var gridCollapsePoweredOffColor : Color
@export var poweredDownColor : Color
@export var poweredOnColor : Color
var isBeingHovered : bool
var powerOn : bool = true

@onready var hitbox: Area2D = $Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	associatedSector = get_parent()
	cursor = get_tree().get_nodes_in_group("cursor")[0].get_node("Area2D")
	halLight.self_modulate = poweredOnColor


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	isBeingHovered = checkCursorContact()
	if isBeingHovered:
		if Input.is_action_just_pressed("lmb"):
			togglePower()
	if not associatedSector.powerManager.isGridCollapsed():
		if powerOn:
			halLight.self_modulate = poweredOnColor
		else:
			halLight.self_modulate = poweredDownColor
	else:
		if powerOn:
			halLight.self_modulate = gridCollapsePoweredOnColor
		else:
			halLight.self_modulate = gridCollapsePoweredOffColor

func checkCursorContact():
	var touchedAreas = hitbox.get_overlapping_areas()
	for area in touchedAreas:
		if area.is_in_group("cursor"):
			return true
	return false
	
func togglePower():
	powerOn = not powerOn
	associatedSector.isPowered = powerOn
	
