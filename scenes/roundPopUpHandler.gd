extends Control

var prevRoundVal : int = -1
@export var roundNotif : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	_playRoundNotif()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.time_scale != 0:
		if RoundInformation.currentRound != prevRoundVal:
			prevRoundVal = RoundInformation.currentRound
			_playRoundNotif()
		
func _playRoundNotif():
	print("PLAYED_ROUND_NOTIF")
	var notifInstance = roundNotif.instantiate()
	add_child(notifInstance) 
