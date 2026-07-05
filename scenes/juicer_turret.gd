extends turret_base

@export var pullFactor : float = 1
@export var isPulling : bool = false 
@export var distanceBeforeCrush : float = 1
@export var waterFromEnemy : float = 30
@export var animator : AnimatedSprite2D

func _process(delta):
	super._process(delta)
	animator.animation_finished.connect(settle)
	if isPulling and distanceFromTarget(_current_target) < distanceBeforeCrush:
		print("crush")
		crushEnemy()

func doAction():
	_current_target.remove_from_group("enemies")
	isPulling = true	
	_current_target.beingPulled = true
	_current_target.pullVelocity = (global_position*_current_target.global_position)*pullFactor
	
func distanceFromTarget(target):
	return Vector2(global_position - target.global_position).length()

func crushEnemy():
	Economy.availableWater += 30
	animator.play("crush")

func settle():
	animator.play("default")
