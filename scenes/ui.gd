extends Control
func _ready():
	Engine.time_scale = 0
	$CanvasLayer/TutorialHint.show()
	$CanvasLayer/TutorialHint2.hide()
	$CanvasLayer/TutorialHint3.hide()
	$AudioStreamPlayer2D.play()
func _process(delta):
	$CanvasLayer/Attention/TextureRect/ProgressBar.value = PD.availablePower
	$CanvasLayer/Attention/TextureRect/ProgressBar.max_value = PD.maxPower
	$CanvasLayer/Attention/Label.text = str(round(PD.availablePower)) + " Threads available"
	
func _on_texture_button_button_down():
	$CanvasLayer/TutorialHint.hide()
	$CanvasLayer/TutorialHint2.show()
	$CanvasLayer/TutorialHint3.hide()
	$AudioStreamPlayer2D.play()

func _on_texture2_button_button_down():
	$CanvasLayer/TutorialHint.hide()
	$CanvasLayer/TutorialHint2.hide()
	$CanvasLayer/TutorialHint3.show()
	$AudioStreamPlayer2D.play()

func _on_textur3e_button_button_down():
	Engine.time_scale = 1
	$CanvasLayer/TutorialHint3.hide()
	$CanvasLayer/TutorialHint2.hide()
	$CanvasLayer/TutorialHint.hide()
