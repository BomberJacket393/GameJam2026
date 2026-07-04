extends turret_base

@onready var mortar_turret_weapon: Node2D = $"."
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var mortarShell : PackedScene

func doAction():
	super.doAction()
	var shellInstance = mortarShell.instantiate()
	shellInstance.setTargetPos(_current_target.position)
	shellInstance.damage = damagePerHit
	shellInstance.global_position = global_position
	get_tree().current_scene.add_child(shellInstance)
	audio_stream_player_2d.play()
