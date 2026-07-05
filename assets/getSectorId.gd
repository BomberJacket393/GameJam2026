extends RichTextLabel



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = get_parent().sectorId

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
