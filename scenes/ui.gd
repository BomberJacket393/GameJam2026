extends Control

var array = ["Gun Turret", "Sniper Turret", "Mortar Turret", "Rocket Turret", "Juicer Turret"]
var description = [
	"Costs 125 Water. Fires high \n damage bursts. Short range.",
	"Costs 75 Water. Slow, high \n damage and cheap.",
	"Costs 200 Water. powerful long \n range AOE. heavy knockback.",
	"Costs 325 Water. Homing, \n AOE missiles. expensive.",
	"Costs 250 Water. Slow to kill, \n produces extra water on kill."
	]
var sprites = [
	preload("res://assets/weaponDisplay1.png"),
	preload("res://assets/weaponDisplay2.png"),
	preload("res://assets/weaponDisplay3.png"),
	preload("res://assets/weaponDisplay4.png"),
	preload("res://assets/weaponDisplay5.png")
]
@export var inGameUI : Control
@export var gameOverUI : Control

func _ready():
	Engine.time_scale = 0
	$CanvasLayer/GameUI/TutorialHint.show()
	$CanvasLayer/GameUI/TutorialHint2.hide()
	$CanvasLayer/GameUI/TutorialHint3.hide()
	$AudioStreamPlayer2D.play()
	
	gameOverUI.hide()
	
func _process(delta):
	$CanvasLayer/GameUI/Attention/TextureRect/ProgressBar.value = PD.availablePower
	$CanvasLayer/GameUI/Attention/TextureRect/ProgressBar.max_value = PD.maxPower
	$CanvasLayer/GameUI/Water/TextureRect/ProgressBar.value = Economy.water
	$CanvasLayer/GameUI/Attention/Label2.text = str(PD.powerPerSecond - PD.idlePower) + "/s Net Threads"
	$CanvasLayer/GameUI/Attention/Label3.text = str(PD.idlePower) + "/s Sector Power Drain"
	if Economy.water < 300:
		$CanvasLayer/GameUI/Water/TextureRect/ProgressBar.max_value = 300
	elif Economy.water < 1000:
		$CanvasLayer/GameUI/Water/TextureRect/ProgressBar.max_value = 1000
	else:
		$CanvasLayer/GameUI/Water/TextureRect/ProgressBar.max_value = 3000
		
	$CanvasLayer/GameUI/Water/Label.text = str(round(Economy.water)) + " Gallons available"
	$CanvasLayer/GameUI/Attention/Label.text = str(round(PD.availablePower)) + " Threads available"
	$CanvasLayer/GameUI/HP/TextureRect/ProgressBar.value = Economy.coreHealth
	$CanvasLayer/GameUI/Reactor/Label.text = "Current Server Level: " + str(round(Economy.currentReactorLevel)) + "\nCoolant to Upgrade: " + str(round(Economy.currentReactorUpgradePrice)) + " Gallons" 
	if PD.currentTurret != null:
		$CanvasLayer/GameUI/WeaponSelect/TextureRect/Label3.text = description[PD.currentTurret]
		$CanvasLayer/GameUI/WeaponSelect/TextureRect.texture = sprites[PD.currentTurret]
		$CanvasLayer/GameUI/WeaponSelect/TextureRect/Label2.text = array[PD.currentTurret]
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

func game_over_stage_1():
	inGameUI.hide()

func game_over_stage_2():
	Engine.time_scale = 0.0
	SoundManager.playSfx(preload("res://erro.mp3"))
	gameOverUI.show()


func _on_goblin_button_button_down():
	Economy.tryUpgradeReactor()
