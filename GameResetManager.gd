extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		quitGame()
		
func resetGame():
	get_tree().reload_current_scene()
	Economy.roundReset()
		
func quitGame():
	get_tree().quit()
