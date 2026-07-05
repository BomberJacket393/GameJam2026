extends Node2D

@export var maxPower : float = 100.0
@export var availablePower : float = 50.0
@export var powerPerSecond : float = 10.0
var idlePower : float = 0
var sectors = []
##Idle turret consumption greater than power production
var gridCollapseImminent = false
var gridCollapse : bool = false

@export var currentTurret : int
@export var cursor : Node2D

var baseReactorProduction = 10
var reactorLevel : int = 0
var threadsPerLevel : int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	##print("START_"+name+"_DIAGNOSTICS")
	##print(powerPerSecond)
	for child in get_tree().get_nodes_in_group("sector"):
		if child is TileMapLayer:
			sectors.append(child)
			
	var nodes = get_tree().get_nodes_in_group("cursor")
	if nodes.size() != 0:
		cursor = nodes[0]
	##print(str(maxPower)+" "+str(availablePower))
	##print("START_"+name+"_DIAGNOSTICS")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	powerPerSecond = getThreadsPerSecond()
	if sectors.size() == 0:
		for child in get_tree().get_nodes_in_group("sector"):
			if child is TileMapLayer:
				sectors.append(child)
	if cursor != null:
		currentTurret = cursor.currentTurretIndex
	else:
		var nodes = get_tree().get_nodes_in_group("cursor")
		if nodes.size() != 0:
			cursor = nodes[0]		
	idlePower = getIdlePowerDrain()
	print(idlePower)
	if not gridCollapse:
		availablePower -= idlePower * delta
		if availablePower<0:
			doGridCollapse()
		##print("idle power drain: "+str(idlePower))
		##print(str(maxPower)+" "+str(availablePower))
	if maxPower > availablePower:
		availablePower+=powerPerSecond*delta
		if availablePower>maxPower:
			availablePower = maxPower
			
func reboot():
	gridCollapse = false
	SoundManager.playSfx(preload("res://assets/GRID_ONLINE.mp3"), Vector2.ZERO, -20)	
	
func doGridCollapse():
	gridCollapse = true
	SoundManager.playSfx(preload("res://assets/GRID_COLLAPSE.mp3"), Vector2.ZERO, 0)
	availablePower = 0	

func getThreadsPerSecond():
	return baseReactorProduction + (reactorLevel * threadsPerLevel)

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

func upgradeReactor():
	reactorLevel += 1

func roundReset():
	sectors = []
	reactorLevel = 0
