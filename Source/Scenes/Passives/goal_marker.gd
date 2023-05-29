extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(bool) var active = false
export(bool) var displayed = false
export(int) var id = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	if not displayed : visible = false
	else: visible = true
	pass # Replace with function body.

func show():
	visible = true
func hide():
	visible = false

func activate():
	active = true
	if get_parent().has_method("goal_marker_reached"):
		get_parent().goal_marker_reached(id)
func deactivate():
	active = false
	if get_parent().has_method("goal_marker_unreached"):
		get_parent().goal_marker_unreached(id)


func _on_GoalMarker_body_entered(body):
	if "goalmarker_triggerer" in body.get_groups():
		activate()


func _on_GoalMarker_body_exited(body):
	if "goalmarker_triggerer" in body.get_groups():
		deactivate()
