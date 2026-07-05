extends turret_base

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@export var raycastDistance : int

@export var animator : AnimatedSprite2D

func _ready():
	super._ready()
	animator.animation_finished.connect(endAnim)

func doAction():
	super.doAction()
	animator.play("firing")
	audio_stream_player_2d.play()
	if _current_target != null:
		_current_target.takeDamage(damagePerHit)
	else:
		var _new_target = pivot.get_target()
		if _new_target != null:
			_new_target.takeDamage(damagePerHit)

func _physics_process(delta: float) -> void:
	var direction = Vector2(cos(pivot.rotation), sin(pivot.rotation))
	direction = direction.normalized()

func endAnim():
	animator.play("default")
