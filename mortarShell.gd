extends Node2D

@export var explosionDamageRadius : float
@export var explosionSecondaryDamageRadius : float
@export var explosionPushRadius : float
##Will be set by mortar
var damage : float
@export var pushForce : float
@export var SPEED : float
var targetPosition : Vector2
var origin : Vector2
var direction : Vector2


func _ready() -> void:
	origin = global_position
	direction = targetPosition - origin
	direction = direction.normalized()
	rotation = direction.angle()

func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta
	if (targetPosition - position).length() < 30:
		explode()
		
func explode():
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.size() != 0:
		for enemy in enemies:
			var distance = enemy.global_position.distance_to(self.global_position)
			if distance < explosionDamageRadius:
				enemy.takeDamage(damage)
			elif distance < explosionSecondaryDamageRadius:
				enemy.takeDamage(damage/5)
			if distance < explosionPushRadius:
				enemy.push(pushForce, global_position)

	direction = Vector2.ZERO
	SoundManager.playSfx(preload("res://assets/EXPLOSION_SOUND_PLACEHOLDER.mp3"),position)
	queue_free()

func setTargetPos(_targetPosition):
	targetPosition = _targetPosition
