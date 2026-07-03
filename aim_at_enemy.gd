extends Node2D

@export var rotationSpeed : float
@export var range = 500
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target = _find_target()
	if target != null:
		_aim_at_target(target.position, delta)

func _find_target():
	var enemies = get_tree().get_nodes_in_group("enemies")
	var nearest_enemy = enemies[0]
	for enemy in enemies:
		if enemy.global_position.distance_to(self.global_position) < nearest_enemy.global_position.distance_to(self.global_position):
			nearest_enemy = enemy
	if nearest_enemy.global_position.distance_to(self.global_position) <= range:
		return nearest_enemy
	else:
		return null

func _aim_at_target(target : Vector2, delta : float):
	var targetAngle = get_angle_to(target)
	var direction = global_position.direction_to(target)
	var target_angle = direction.angle()
	rotation = lerp_angle(rotation, target_angle, 0.1)
