extends Node2D

@export var radius : float
@export var cloudCount : int

var clouds  = [
	preload("res://assets/clouds/cloud_1.png"),
	preload("res://assets/clouds/cloud_2.png")
]
@export var smokeUnit : PackedScene

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(cloudCount):
		var point = _getRandomPointInCircle()
		createSmokeUnit(point)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func createSmokeUnit(position):
	var smokeUnitInstance = smokeUnit.instantiate() as Sprite2D
	var texture = clouds[rng.randi_range(0,clouds.size()-1)]
	smokeUnitInstance.position = position
	smokeUnitInstance.texture = texture
	
func _getRandomPointInCircle():
	var angle = rng.randf_range(0,2*PI)
	var direction = Vector2(cos(angle),sin(angle))
	var distanceFromCentre = rng.randi_range(0,radius)
	return direction * distanceFromCentre
