extends Control

@export var swiftTyper : PackedScene
@export var spawnDelay : float
var spawnTimer : float
var screenSize = get_viewport_rect().size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_initialLine()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _initialLine():
	for i in range(50):
		print("instantiate")
		var typer = swiftTyper.instantiate()
		typer.position = Vector2(i*(-1920/50.0),randi_range(-100,-130))
		add_child(typer)
		print(typer.position)
