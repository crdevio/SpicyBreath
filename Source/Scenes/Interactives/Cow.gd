extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(bool) var infinite = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.	


func _on_Area2D_body_entered(body):
	if "spell" in body.get_groups():
		var p = get_tree().get_nodes_in_group("player")[0]
		UnlockedThings.actived = [false,false,false,false,false,false]
		p.update_hud()
		body.queue_free()
		if not infinite :
			queue_free()
