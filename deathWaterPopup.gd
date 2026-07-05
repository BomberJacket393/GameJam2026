extends Node2D

var amount : int
@export var text : RichTextLabel
var currentAlpha = 1
var upwardsVelocity = 50 * Vector2.UP

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text.text = str(amount)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	modulate = Color(1,1,1,currentAlpha)
	currentAlpha -= delta
	position += upwardsVelocity * delta
