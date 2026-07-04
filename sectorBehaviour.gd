extends Node2D

@export var sectorId = "A1"
var sectorSquares : Array[Node2D]
var turretsInSector : Array[Node2D]
@onready var powerManager : Node2D = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child.is_in_group("sector_section"):
			sectorSquares.append(child)

func assignTurret(turret : Node2D):
	print(turret.name)
	var _turret = turret.get_node("Pivot").get_child(0) as turret_base
	_turret.fired.connect(shotFired)
	turretsInSector.append(turret)
	
func getIdlePowerDrain():
	var idlePower = 0
	for turret in turretsInSector:
		var _turret = turret.get_node("Pivot").get_child(0) as turret_base
		idlePower += _turret.idlePowerDrain
	return idlePower
	
func shotFired(power):
	powerManager.drainPower(power)
