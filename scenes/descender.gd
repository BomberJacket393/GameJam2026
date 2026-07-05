extends Label
var speed = randf_range(1,3)
func _process(delta):
	self.position.y += speed
	if self.position.y > 1500:
		self.position = Vector2(randi_range(1,1920),-100)
		speed = randf_range(1,3)
		self.text = text_gen()
func text_gen():
	if randi_range(1,30) != 30:
		return str(randi_range(0,1)) + "\n" + str(randi_range(0,1)) + "\n" + str(randi_range(0,1)) + "\n" + str(randi_range(0,1)) + "\n" + str(randi_range(0,1)) + "\n"
	else:
		if randi_range(1,2) == 1:
			return "One\nZero\nOne\nOne"
		else:
			return "G\nA\nM\nI\nN\nG"
