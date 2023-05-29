extends KinematicBody2D

export(float) var speed = 0.16
export(float) var visible_at = 0.5
export(float) var lifetime = 5

onready var Fireball = load("res://Entities/Power/fire/Fireball/Fireball.tscn")

var pet = null
var target_location = null

var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var elapsed = 0

onready var ray = $RayCast2D


func _ready():
	velocity = direction * speed
	$AnimationPlayer.play("Burning")
	visible = false
	pass

func _process(delta):
	elapsed += delta
	
	if elapsed > visible_at:
		visible = true
		var o = move_and_collide(velocity * delta * 1000)
		on_collide(o)
		if o != null and not ("spell_transparent" in o.collider.get_groups()):
			get_parent().remove_child(self)
	
	
	if elapsed > lifetime:
		get_parent().remove_child(self)

func update_transform():
	transform = transform.rotated(pet.orientation.angle())		

func on_collide(collided):
	if collided == null:
		return
	for children in get_parent().get_children():
		if children is TileMap:
			if children.name != "Dynamique":
				continue
			var cell = (children as TileMap).world_to_map(collided.position)
			if children.get_cellv(cell) == 2: #Firecamp
				var fireball_instance = Fireball.instance() 
				fireball_instance.pet = pet
				fireball_instance.position = children.map_to_world((cell)) + Vector2(16, 8)
				fireball_instance.target_position = fireball_instance.position
				fireball_instance.lifetime = -1
				
				get_parent().add_child(fireball_instance)
		
