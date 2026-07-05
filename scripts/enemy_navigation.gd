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

@export var waterOnDeath : int = 10
@export var deathBubble : PackedScene
@export var animator : AnimatedSprite2D

var isBeingPushed : bool
var aboutToDie
var beingPulled : bool
var pullVelocity : Vector2

func _ready():
	animator.animation_finished.connect(enemyDeath)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not beingPulled:
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
			
		if is_touching_reactor() and not aboutToDie:
			attackReactor()
		
	##Destroy when less than 0 health
	if health <= 0:
		enemyDeath()

func enemyDeath():
	SoundManager.playSfx(preload("res://assets/DEATH_PLACEHOLDER.mp3"),position,-20)
	Economy.addWater(waterOnDeath)
	var deathBubbleInstance = deathBubble.instantiate() as Node2D
	deathBubbleInstance.global_position = global_position
	deathBubbleInstance.amount = waterOnDeath
	get_tree().current_scene.add_child(deathBubbleInstance)
	queue_free()

func attackReactor():
	remove_from_group("enemies")
	animator.play("destroy")
	target.takeDamage(10)
	aboutToDie = true
	
func is_touching_reactor():
	var areas = hitbox.get_overlapping_areas()
	for area in areas:
		if area.is_in_group("reactorHitbox"):
			return true
	return false

func _physics_process(delta: float) -> void:
	
	if not isBeingPushed and not beingPulled:
		position += velocity * delta
	elif beingPulled:
		print("being pulled")
		position += pullVelocity*0.03
		##pullVelocity += pushVelocity.normalized()
	elif isBeingPushed:
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
	
	
