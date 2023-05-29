extends KinematicBody2D

export(float) var speed = 0.16
export(float) var visible_at = 0.5
export(float) var lifetime = 5

onready var Iceball = load("res://Entities/Power/ice/BigIceball/BigIceball.tscn")

var pet = null
var target_location = null

var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var elapsed = 0

onready var ray = $RayCast2D

onready var water = get_tree().get_root().get_node("Map/Eau")

func _ready():
	velocity = direction * speed
	$AnimationPlayer.play("Burning")
	visible = false
	pass
	
func update_transform():
	transform = transform.rotated(pet.orientation.angle())		

func _process(delta):
	elapsed += delta
	
	if elapsed > visible_at:
		visible = true
		var o = move_and_collide(velocity * delta * 1000)
		on_collide(o)
		if o != null:
			get_parent().remove_child(self)
		elif(water.froze_ground(self, position, true)):
			get_parent().remove_child(self)
	
	
	if elapsed > lifetime:
		get_parent().remove_child(self)

func on_collide(collided):
	if collided == null:
		return
