extends Node

##THIS CLASS ACTS AS AN ABSTRACT CLASS, DONT ATTACH DIRECTLY
##CREATE A SUBCLASS
##SEE "gun_turret" FOR EXAMPLE
class_name turret_base

@export var pivot : aim_at_enemy
var _current_target : Node2D
@export var actionDelay : float
var actionTimer : float
@export var damagePerHit : int
var selfCanFire : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	setTarget()
	if canDoAction():
		doAction()
		actionTimer = actionDelay
	if actionTimer > 0:
		actionTimer -= delta
	
func canDoAction():
	return _current_target != null and actionTimer <= 0

func setTarget():
	_current_target = pivot.get_target()

##Handling fire in subclass allows for projectiles and raycast while reusing main code
func doAction():
	push_error("doAction() must be overridden in subclass")
