extends Control

@export var label : Label
var alphaVal : float = 1
@export var timeBeforeFade : float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = "ROUND "+str(RoundInformation.currentRound)	
	add_theme_color_override("font_outline_color", Color.BLACK)
	add_theme_constant_override("outline_size", 20)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timeBeforeFade < 0:
		modulate = Color(1,1,1,alphaVal)
		alphaVal -= delta
		if alphaVal < 0:
			queue_free()
	else:
		timeBeforeFade -= delta
	offset_transform_position.y -= delta*30
