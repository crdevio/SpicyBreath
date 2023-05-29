extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var b = false
# Called when the node enters the scene tree for the first time.
func open():
	visible = false
	b = true
	$CollisionShape2D.set_deferred("disabled",true)

func close():
	visible = true
	$CollisionShape2D.set_deferred("disabled",false)
