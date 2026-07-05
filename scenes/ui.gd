extends Control

var array = ["gunTurret", "sniperTurret", "mortarTurret", "rocketTurret"]

@export var inGameUI : Control
@export var gameOverUI : Control

func _ready():
	Engine.time_scale = 0
	$CanvasLayer/GameUI/TutorialHint.show()
	$CanvasLayer/GameUI/TutorialHint2.hide()
	$CanvasLayer/GameUI/TutorialHint3.hide()
	$AudioStreamPlayer2D.play()
	
func _process(delta):
	$CanvasLayer/GameUI/Attention/TextureRect/ProgressBar.value = PD.availablePower
	$CanvasLayer/GameUI/Attention/TextureRect/ProgressBar.max_value = PD.maxPower
	$CanvasLayer/GameUI/Attention/Label.text = str(round(PD.availablePower)) + " Threads available"
	if PD.currentTurret != null:
		$CanvasLayer/GameUI/Control/Label.text = array[PD.currentTurret]
	else:
		$CanvasLayer/GameUI/Control/Label.text = "ERROR"
func _on_texture_button_button_down():
	$CanvasLayer/GameUI/TutorialHint.hide()
	$CanvasLayer/GameUI/TutorialHint2.show()
	$CanvasLayer/GameUI/TutorialHint3.hide()
	$AudioStreamPlayer2D.play()

func _on_texture2_button_button_down():
	$CanvasLayer/GameUI/TutorialHint.hide()
	$CanvasLayer/GameUI/TutorialHint2.hide()
	$CanvasLayer/GameUI/TutorialHint3.show()
	$AudioStreamPlayer2D.play()

func _on_textur3e_button_button_down():
	Engine.time_scale = 1
	$CanvasLayer/GameUI/TutorialHint3.hide()
	$CanvasLayer/GameUI/TutorialHint2.hide()
	$CanvasLayer/GameUI/TutorialHint.hide()

func game_over():
	inGameUI.hide()
	gameOverUI.show()
