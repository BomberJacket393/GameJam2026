extends Node2D

@onready var agent : NavigationAgent2D = $navBrain
@export var hitbox : Area2D
var current_node : int = 0
var health : int = 10
var velocity : Vector2
var audioStreamPlayer : AudioStreamPlayer
var deathAudio : FileAccess

var speed = 100
@export var target : Node2D
var nextLoc : Vector2 = Vector2.ZERO

@export var pushDragFactor : float
@export var pushVelocity : Vector2

var isBeingPushed : bool

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	updateTargetPosition(target)
	nextLoc = agent.get_next_path_position()
	if position.distance_to(target.position) > 10:
		var curLoc = global_transform.origin
		nextLoc = agent.get_next_path_position()
		var newVel = (nextLoc - curLoc).normalized()  * speed
		if newVel.x > 0:
			scale.x = 1
		else: scale.x = -1
		velocity = newVel
	else:
		velocity = Vector2.ZERO
	##Destroy when less than 0 health
	if health <= 0:
		enemyDeath()

func enemyDeath():
	SoundManager.playSfx(preload("res://assets/DEATH_PLACEHOLDER.mp3"),position)
	queue_free()

func _physics_process(delta: float) -> void:
	if not isBeingPushed:
		position += velocity * delta
	if isBeingPushed:
		position += pushVelocity * delta
		pushVelocity -= pushVelocity.normalized() * pushDragFactor
		if pushVelocity.length() < 5:
			isBeingPushed = false
			pushVelocity = Vector2.ZERO
	
func updateTargetPosition(target):
	agent.set_target_position(target.position)
	
func push(pushForce, pushForceOrigin):
	isBeingPushed = true
	var pushDirection = position - pushForceOrigin
	pushVelocity = pushDirection * pushForce
	
func takeDamage(damage):
	health -= damage
	
	
