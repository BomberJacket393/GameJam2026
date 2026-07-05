extends Node

var water = 150
var cursor
@export var gunTurretCost = 125
@export var sniperTurretCost = 75
@export var mortarTurretCost = 200
@export var rocketTurretCost = 325
@export var turretStartGameDelay = 2.0
var gameStarted

var turretCosts : Array[int] = [gunTurretCost, sniperTurretCost, mortarTurretCost, rocketTurretCost]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#turretCosts = [gunTurretCost, sniperTurretCost, mortarTurretCost, rocketTurretCost]
	if PD.cursor != null:
		cursor = PD.cursor
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.time_scale == 1 and turretStartGameDelay > 0:
		turretStartGameDelay -= delta
	if turretStartGameDelay < 0:
		gameStarted = true
	
func tryTransaction(waterCost):
	if waterCost > water or Engine.time_scale == 0 or not gameStarted:
		return false
	else:
		water -= waterCost
		return true

func addWater(_water):
	water += _water
