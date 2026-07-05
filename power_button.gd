extends Node2D

var associatedSector
var cursor : Area2D

#@export var halLight : Sprite2D
@export var button : AnimatedSprite2D
@export var gridCollapsePoweredOnColor : Color
@export var gridCollapsePoweredOffColor : Color
@export var poweredDownColor : Color
@export var poweredOnColor : Color
var isBeingHovered : bool
var powerOn : bool = true
var tempPower

@onready var hitbox: Area2D = $Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	associatedSector = get_parent()
	button.animation_finished.connect(endOfTween)
	cursor = get_tree().get_nodes_in_group("cursor")[0].get_node("Area2D")
	button.play("on")
	##halLight.self_modulate = poweredOnColor


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	isBeingHovered = checkCursorContact()
	if isBeingHovered:
		if Input.is_action_just_pressed("lmb"):
			togglePower()
	if not associatedSector.powerManager.isGridCollapsed():
		button.self_modulate = Color(1,1,1)
	else:
		if powerOn:
			button.self_modulate = gridCollapsePoweredOnColor
		else:
			button.self_modulate = gridCollapsePoweredOffColor

func checkCursorContact():
	var touchedAreas = hitbox.get_overlapping_areas()
	for area in touchedAreas:
		if area.is_in_group("cursor"):
			return true
	return false
	
func togglePower():
	powerOn = not powerOn
	playTween()
	associatedSector.isPowered = powerOn
	
func playTween():
	button.play("tween")
	SoundManager.playSfx(preload("res://assets/POWER_BUTTON_PRESS.mp3"),Vector2.ZERO, -20)
	button.self_modulate = Color(0.3,0.3,0.3)
	
func endOfTween():
	button.self_modulate = Color(1,1,1)
	if powerOn:
		button.play("on")
	else: 
		button.play("off")
