extends turret_base

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@export var raycastDistance : int


func doAction():
	super.doAction()
	audio_stream_player_2d.play()
	_current_target.takeDamage(damagePerHit)

func _physics_process(delta: float) -> void:
	var direction = Vector2(cos(pivot.rotation), sin(pivot.rotation))
	direction = direction.normalized()
