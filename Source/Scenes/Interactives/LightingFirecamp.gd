extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var burning = false
export(bool) var immediate = false
export(bool) var interactible = true
export(int) var id = 0
# Called when the node enters the scene tree for the first time.
func allumer():
	burning = true
	$Sprite.visible = true
	$AnimationPlayer.play("Burning")
	if get_parent().has_method("ground_fired_callback"):
		get_parent().ground_fired_callback(id)

func eteindre():
	burning = false
	$Sprite.visible = false
	$AnimationPlayer.stop()
func _ready():
	if immediate:
		allumer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_LightingFirecamp_body_entered(body):
	if "igniter_ground" in body.get_groups() and interactible:
		allumer()
		body.free()
