extends Node2D

@export var amplitude : float
@export var frequency : float
var originPos : Vector2 = position
var elapsedTime : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsedTime += delta
	position = Vector2(0,originPos.y + (amplitude * sin(elapsedTime*frequency)))
