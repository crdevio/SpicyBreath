extends KinematicBody2D

export(float) var speed = 0.16
export(float) var visible_at = 0.5
export(float) var lifetime = 5

onready var Fireball = load("res://Entities/Power/fire/BigFireball/BigFireball.tscn")

var pet = null
var target_location = null

var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var elapsed = 0

onready var ray = $RayCast2D


func _ready():
	velocity = direction * speed
	$AnimationPlayer.play("Burning")
	#visible = false
	pass

func _process(delta):
	elapsed += delta
	
	if elapsed > visible_at:
		visible = true
		var o = move_and_collide(velocity * delta * 1000)
		if o != null:
			on_collide(o.position - 32 * direction)
			get_parent().remove_child(self)
		
	if elapsed > lifetime and get_parent() != null:
		on_collide(position)
		get_parent().remove_child(self)

func update_transform():
	transform = transform.rotated(pet.orientation.angle())
		
func on_collide(pos):
	if pos == null:
		return

	var tile = get_parent().get_node("TileMap")
	
	var center = tile.world_to_map(pos+Vector2(16, 16))
	
	for y in [-1, 0, 1]:
		for x in [-1, 0, 1]:
			if x * y != 0:
				continue
			pos = center + Vector2(x, y)
			var r = get_world_2d().direct_space_state.intersect_point(tile.map_to_world(pos) + Vector2(16, 16), 32, [], layers)
			print(pos, " ", center, " ", r)
			if r.size() == 0:
				var fireball = Fireball.instance()
				fireball.position = tile.map_to_world(pos) + Vector2(16, 16)
				fireball.scale *= 0.5
				fireball.lifetime = 5 - fireball.position.distance_to(position) / 32
				get_parent().add_child(fireball)
