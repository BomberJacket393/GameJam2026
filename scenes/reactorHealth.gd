extends Sprite2D

@export var reactorHealth : int
@export var ui : Control
@export var gameOverErrorCascade : PackedScene
@export var biosTimer : float
var gameOver = false
var calledBios = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#if Input.is_action_just_pressed("cycle_left"):
		#reactorHealth = -1
	
	if reactorHealth <= 0 and not gameOver:
		gameOver = true
		var gameOverInstance = gameOverErrorCascade.instantiate() as Node2D
		gameOverInstance.global_position = Vector2.ZERO
		get_tree().current_scene.add_child(gameOverInstance)
		ui.game_over_stage_1()
	if gameOver and not calledBios:
		biosTimer -= delta
		if biosTimer < 0:
			calledBios = true
			ui.game_over_stage_2()
	if gameOver and calledBios:
		if Input.is_action_just_pressed("n"):
			GameResetManager.quitGame()
		if Input.is_action_just_pressed("y"):
			GameResetManager.resetGame()
	
func takeDamage(damage):
	reactorHealth -= damage
