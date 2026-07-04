extends Node2D

@export var maxPower : float = 100.0
@export var availablePower : float = 50.0
@export var powerPerSecond : float = 3.0
var sectors = []
##Idle turret consumption greater than power production
var gridCollapseImminent = false
var gridCollapse : bool = false
var gridCollapseSfx : FileAccess

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(name)
	for child in get_children():
		if child is TileMapLayer:
			sectors.append(child)
	print(str(maxPower)+" "+str(availablePower))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var idlePower = getIdlePowerDrain()
	if not gridCollapse:
		availablePower -= idlePower * delta
		if availablePower<0:
			doGridCollapse()
		print("idle power drain: "+str(idlePower))
		print(str(maxPower)+" "+str(availablePower))
	if maxPower > availablePower:
		availablePower+=powerPerSecond*delta
		if availablePower>maxPower:
			availablePower = maxPower
			
func reboot():
	gridCollapse = false
	SoundManager.playSfx(preload("res://assets/GRID_ONLINE.mp3"), Vector2.ZERO, 0)	


func doGridCollapse():
	gridCollapse = true
	SoundManager.playSfx(preload("res://assets/GRID_COLLAPSE.mp3"), Vector2.ZERO, 20)
	availablePower = 0	

func getIdlePowerDrain():
	var idlePower = 0
	for sector in sectors:
		if sector.isPowered:
			idlePower += sector.getIdlePowerDrain()
	return idlePower

func drainPower(power):
	availablePower -= power
	
func getAvailablePower():
	return availablePower

func isGridCollapsed():
	return gridCollapse
