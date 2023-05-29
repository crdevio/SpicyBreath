extends KinematicBody2D

onready var ray = $RayCast2D

var pet = null
var direction = Vector2.ZERO

var canCollide = false

func _ready():
	position = position + direction * 32
	$AnimationPlayer.play("blowing")
	ray.cast_to = Vector2(12,0)

func _process(delta):
	if canCollide:
		if ray.is_colliding():
			canCollide = false
			var obj = ray.get_collider()
			for g in obj.get_groups():
				if g == "wind_sensible":
					g.interact_with_wind()
					
func update_transform():
	transform = transform.rotated(pet.orientation.angle())


func _on_Warmup_timeout():
	canCollide = true


func _on_Death_timeout():
	get_parent().remove_child(self) # Replace with function body.
