extends Sprite2D

@onready var pivot: aim_at_enemy = $"../.."
var flipped : bool

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pivot.rotation > PI and not flipped:
		scale.y*=-1
		flipped = true
	if pivot.rotation <= PI and flipped:
		scale*=-1
		flipped = false
