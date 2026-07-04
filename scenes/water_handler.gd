extends Node2D

@export var water : int
@export var waterLabel : RichTextLabel
@export var roundHandler : round_handler

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	##print(water, waterLabel)
	waterLabel.text = "WATER : "+str(water)
