extends Node2D

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
@export var idlePowerDrain : int
@export var powerPerShot : int
var associatedSector : Node2D
var POWER_OUTAGE_DIM_MODULATE = Color(0.3, 0.3, 0.3)

signal fired(power)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func setAssociatedSector(sector):
	associatedSector = sector

func _process(delta: float) -> void:
	pivot.canTurn = canSelfTurn()
	if canSelfTurn():
		if modulate != Color(1,1,1):
			modulate = Color(1,1,1)
		setTarget()
		if canDoAction():
			doAction()
			actionTimer = actionDelay
		if actionTimer > 0:
			actionTimer -= delta	
	else:
		if modulate != POWER_OUTAGE_DIM_MODULATE:
			modulate = POWER_OUTAGE_DIM_MODULATE
			

	
func canDoAction():
	var gunReady = _current_target != null and actionTimer <= 0
	var sectorPerm = associatedSector.getAvailablePower() > powerPerShot and associatedSector.isPowered
	return gunReady and sectorPerm

func setTarget():
	if pivot.get_target() != null:
		_current_target = pivot.get_target()

##Handling fire in subclass allows for projectiles and raycast while reusing main code
func doAction():
	fired.emit(powerPerShot)
	
func canSelfTurn():
	return associatedSector.isPowered and not associatedSector.powerManager.isGridCollapsed()
	
	
