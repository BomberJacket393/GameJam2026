extends Label

@export var letterDelay : float
var letterTimer : float = 0
var hexDigits : Array[String] = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"]
var hexPairs = 2
var digitsTyped = 1
var speed = randf_range(1,3)

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_theme_font_size_override("font_size", randi_range(25,30))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position.y += speed
	if self.position.y > 1500:
		queue_free()
		
	if letterTimer < 0 and digitsTyped < 500:
		text += hexDigits[rng.randi_range(0,15)]
		digitsTyped += 1
		if digitsTyped%2 == 0:
			text+=" "
		if digitsTyped%4 == 0:
			text+="\n"
		letterTimer = letterDelay
	letterTimer -= delta
	
	
#func _writeLine():
	#var line = ""
	#for pair in range(hexPairs):
		#for digit in range(2):
			#line+=hexDigits[rng.randi_range(0,15)]
		#line+=" "
	#line+="\n"
