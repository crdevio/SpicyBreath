extends KinematicBody2D

export(float) var snapping_duration = 0.1
export(float) var lifetime = 5

var pet = null
var target_position = null

var direction = Vector2.ZERO
var elapsed = 0


func _ready():
	
	direction = direction * 32/snapping_duration
	
	$AnimationPlayer.play("Burning")
	pass

func _process(delta):
	
	if elapsed < snapping_duration :
		position += direction * delta
	
	elapsed += delta
	
	if elapsed > lifetime and lifetime > 0:
		get_parent().remove_child(self)
