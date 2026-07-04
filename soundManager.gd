extends Node

func playSfx(stream: AudioStream, position: Vector2 = Vector2.ZERO):
	var player = AudioStreamPlayer2D.new()
	player.stream = stream
	player.global_position = position
	get_tree().current_scene.add_child(player)
	##Create and then detroy a player
	player.play()
	player.finished.connect(player.queue_free)
