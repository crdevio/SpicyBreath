extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(String) var level_string = ""
export(bool) var active = false
export(Texture) var img = load("res://Assets/Objects/escalier_pierre.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = img 
	if not active : visible = false


func activate():
	active = true
	visible = true

func _on_Stairs_body_entered(body):
	if active and "player" in body.get_groups():
		get_tree().change_scene(level_string)
