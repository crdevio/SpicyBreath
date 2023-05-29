extends KinematicBody2D

export(float) var snapping_duration = 0.2

onready var animation_tree = get_node("AnimationTree")

var elapsed = 0

var _snapping_direction = Vector2.ZERO
var _snapping_final = null

var orientation = Vector2(1, 0)

func _physics_process(delta):
	elapsed += delta

	if(elapsed < snapping_duration && _snapping_final != null):
		position += _snapping_direction * delta
		$AnimationTree.get("parameters/playback").travel("Walking")
		$AnimationTree.set("parameters/Idle/blend_position",_snapping_direction)
		$AnimationTree.set("parameters/Walking/blend_position",_snapping_direction)
	elif _snapping_final != null:
		position = _snapping_final

		_snapping_final = null
		_snapping_direction = Vector2.ZERO

func move_on_tilemap(direction:Vector2):
	orientation = direction
	_snapping_direction = direction * 32 / snapping_duration
	_snapping_final = position + direction * 32
	elapsed = 0
	
