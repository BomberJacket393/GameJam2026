extends Node2D


func _on_timer_timeout():
	global_position = Vector2(randi_range(-1500,1500),randi_range(-1500,1500))
