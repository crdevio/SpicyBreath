extends KinematicBody2D

export(float) var snapping_duration = 0.1
export(float) var lifetime = 5

var pet = null
var target_position = null

var speed = 0
var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var elapsed = 0

onready var water = get_tree().get_root().get_node("Map/Eau")

func _ready():
	
	speed = 32/snapping_duration
	velocity = direction*speed
	
	$AnimationPlayer.play("Burning")
	pass

func _process(delta):
		
	if elapsed < snapping_duration:
		var o = move_and_collide(velocity * delta)
		on_collide(o)
		if o != null:
			get_parent().remove_child(self)
	else:
		if(water.froze_ground(self, position, true)):
			get_parent().remove_child(self)
			
	if elapsed > lifetime  and lifetime > 0:
		get_parent().remove_child(self)
		
func on_collide(collided):
	if collided == null:
		return
