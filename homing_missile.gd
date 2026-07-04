extends Node2D

@export var explosionDamageRadius : float
@export var explosionPushRadius : float
##Will be set by mortar
var damage : float
@export var pushForce : float
@export var SPEED : float
var origin : Vector2
var direction : Vector2
var targetPosition : Vector2 
var trackingRange : float = 500

func _physics_process(delta: float) -> void:
	var potentialTargetPos = _find_target()
	if potentialTargetPos != null:
		targetPosition = potentialTargetPos
	origin = global_position
	direction = targetPosition - origin
	direction = direction.normalized()
	rotation = direction.angle()
	position += direction * SPEED * delta
	if (targetPosition - position).length() < 30:
		explode()
		
func _find_target():
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.size() == 0:
		return null
	var nearest_enemy = enemies[0]
	for enemy in enemies:
		if enemy.global_position.distance_to(self.global_position) < nearest_enemy.global_position.distance_to(self.global_position):
			nearest_enemy = enemy
	if nearest_enemy.global_position.distance_to(self.global_position) <= trackingRange:
		return nearest_enemy
	else:
		return null

func explode():
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.size() != 0:
		for enemy in enemies:
			var distance = enemy.global_position.distance_to(self.global_position)
			if distance < explosionDamageRadius:
				enemy.takeDamage(damage)
			if distance < explosionPushRadius:
				enemy.push(pushForce, global_position)

	direction = Vector2.ZERO
	SoundManager.playSfx(preload("res://assets/EXPLOSION_SOUND_PLACEHOLDER.mp3"),position)
	queue_free()

func setTargetPos(_targetPosition):
	targetPosition = _targetPosition
