extends turret_base

@export var pullFactor : float = 1
@export var isPulling : bool = false 
@export var distanceBeforeCrush : float 
@export var distanceBeforeAnimation : float
var isAnimating : bool 
@export var waterFromEnemy : float = 35
@export var animator : AnimatedSprite2D
@export var crushTarget : Node2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	super._ready()
	animator.animation_finished.connect(settle)

func _process(delta):
	super._process(delta)
	if crushTarget != null:
		pivot._aim_at_target(crushTarget.global_position, delta)
		if distanceFromTarget(crushTarget) < distanceBeforeAnimation:
			isAnimating = true
			animator.play("crush")
		if distanceFromTarget(crushTarget) < distanceBeforeCrush:
			crushTarget.pullVelocity = Vector2.ZERO
		if isPulling and distanceFromTarget(crushTarget) < distanceBeforeCrush:
			print("crush")
			crushEnemy()
			isPulling = false

func doAction():
	if crushTarget == null:
		crushTarget = _current_target
		_current_target.remove_from_group("enemies")
		isPulling = true	
		_current_target.beingPulled = true
		_current_target.pullVelocity = (global_position-_current_target.global_position)*pullFactor
		
func distanceFromTarget(target):
	return Vector2(global_position - target.global_position).length()

func crushEnemy():
	crushTarget.waterOnDeath = waterFromEnemy
	audio_stream_player_2d.play()
	crushTarget.enemyDeath()
	crushTarget = null

func settle():
	animator.play("default")
	isAnimating = false
