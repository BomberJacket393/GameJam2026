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
var rotationSpeed = 0.2
var homingDelay = 0.6

func _ready() -> void:
	direction = Vector2(cos(rotation),sin(rotation))

func _physics_process(delta: float) -> void:
	if homingDelay < 0:
		var potentialTargetPos = _find_target()
		if potentialTargetPos != null:
			targetPosition = potentialTargetPos.position
			_aim_at_target(potentialTargetPos.position,delta)
		origin = global_position
		position += direction * SPEED * delta
		if (targetPosition - position).length() < 30:
			explode()
	else:
		homingDelay-=delta
		
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

func _aim_at_target(target : Vector2, delta : float):
	var targetAngle = get_angle_to(target)
	var _direction = global_position.direction_to(target)
	var target_angle = _direction.angle()
	rotation = lerp_angle(rotation, target_angle, rad_to_deg(rotationSpeed) * delta)
	direction = Vector2(cos(rotation),sin(rotation))
	direction = direction.normalized()

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
	SoundManager.playSfx(preload("res://assets/EXPLOSION_SOUND_PLACEHOLDER.mp3"),position,-20)
	queue_free()

func setTargetPos(_targetPosition):
	targetPosition = _targetPosition
