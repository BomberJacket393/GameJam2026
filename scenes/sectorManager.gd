extends Node2D

@export var maxPower : float = 100.0
@export var availablePower : float = 50.0
@export var powerPerSecond : float = 3.0
var sectors = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(name)
	for child in get_children():
		if child is TileMapLayer:
			sectors.append(child)
	print(str(maxPower)+" "+str(availablePower))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if maxPower > availablePower:
		availablePower+=powerPerSecond*delta
		if availablePower>maxPower:
			availablePower = maxPower
	if availablePower<0:
		availablePower = 0
	var idlePower = 0
	for sector in sectors:
		if sector.isPowered:
			idlePower += sector.getIdlePowerDrain()
	print("idle power drain: "+str(idlePower))
	print(str(maxPower)+" "+str(availablePower))
	availablePower -= idlePower * delta

func drainPower(power):
	availablePower -= power
	
func getAvailablePower():
	return availablePower
