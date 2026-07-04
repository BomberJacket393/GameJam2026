extends Node

var water = 500 
var cursor

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if PD.cursor != null:
		cursor = PD.cursor
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
