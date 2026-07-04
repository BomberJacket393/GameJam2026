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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audioStreamPlayer = get_tree().current_scene.get_node("AudioStreamPlayer")


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
	position += velocity * delta
	
func updateTargetPosition(target):
	agent.set_target_position(target.position)
	
func takeDamage(damage):
	health -= damage
	
	
