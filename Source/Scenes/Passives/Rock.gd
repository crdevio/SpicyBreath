extends KinematicBody2D

export(float) var snapping_duration = 0.1
export(float) var lifetime = 5


var pet = null
var target_position = null

var elapsed = 0
var speed = 0
var velocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.

onready var tile = get_parent().get_node("TileMap")

func _ready():
	speed = 32/snapping_duration
	pass # Replace with function body.

func _physics_process(delta):
	
	if target_position != null:
		elapsed += delta
		
		if elapsed < snapping_duration:
			position += velocity * delta
		else:
			position = Vector2(target_position.x, target_position.y)
			elapsed = 0
			target_position = null
			
	


func _on_Area2D_body_entered(body):
	if(target_position != null):
		return
	if "spell_wind" in body.get_groups():
		var center = tile.world_to_map(body.position)
		var pos = center + body.direction
		var r = get_world_2d().direct_space_state.intersect_point(tile.map_to_world(pos) + Vector2(16, 16), 32, [], layers)
		if(r.size() == 0):
			target_position = tile.map_to_world(pos) + Vector2(16, 16)
			velocity = body.direction * speed
		
	pass # Replace with function body.
