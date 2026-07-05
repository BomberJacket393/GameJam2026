extends turret_base

@export var bulletsPerBurst : int
@export var burstLengthTime : float
var bulletsLeftInBurst : int
var burstDelay : float
var burstTimer : float
var inBurst : bool
var doFireLeft : bool = true
@export var leftTurret : AnimatedSprite2D
@export var rightTurret : AnimatedSprite2D
@export var TURRET_PRICE : int
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

##---This code relates only to the gun turret, the contents of this script
##are not a template, but can be used as an example for how it extends turrent_base

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	burstDelay = burstLengthTime/bulletsPerBurst

func _process(delta: float) -> void:
	super._process(delta)
	if burstTimer <= 0 and bulletsLeftInBurst > 0:
		bulletsLeftInBurst -= 1
		fireGun()
		burstTimer = burstDelay
		print(bulletsLeftInBurst)
	if bulletsLeftInBurst <= 0:
		inBurst = false
		leftTurret.stop()
		rightTurret.stop()
	burstTimer-=delta

func doAction():
	super.doAction()
	inBurst = true
	audio_stream_player_2d.play()
	#print("PLAYED_FIRE_SFX")
	bulletsLeftInBurst = bulletsPerBurst
	burstTimer = 0
	
func fireGun():
	#print(str(name).to_upper() + "FIRED_GUN")
	if doFireLeft:
		leftTurret.stop()
		leftTurret.play("firing")
	else:
		rightTurret.stop()
		rightTurret.play("firing")
	doFireLeft = not doFireLeft
	if _current_target != null:
		_current_target.takeDamage(damagePerHit)
	else:
		setTarget()
