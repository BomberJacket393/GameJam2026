extends Node2D

@onready var nav_brain : NavigationAgent2D = $navBrain
@export var nav_nodes : Array[Node2D]
@export var hitbox : Area2D
var current_node : int = 0

var SPEED = 100
var target : Vector2
var nextLoc : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	nav_brain.ta
