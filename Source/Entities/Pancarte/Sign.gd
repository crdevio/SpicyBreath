extends StaticBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String) var txt = "Not filled"

# Called when the node enters the scene tree for the first time.
func _ready():
	$SignBackground/Label.text = txt
	pass # Replace with function body.

func Interact():
	$SignBackground.visible = not $SignBackground.visible 
