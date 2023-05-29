extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String) var nom = "NPC"
export(String) var text = "Not set"
export(bool) var interactible = false
var gived = false
export(Texture) var img = load("res://Assets/Characters/NPC/mother.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = img
	$RichTextLabel.text = text
	pass # Replace with function body.

func Interact():
	if $RichTextLabel.visible:
		$AnimationPlayer.stop()
		$RichTextLabel.visible = false
	else:
		if not gived:
			var p = get_parent().get_node("Player")
			get_parent().open_door1()
			p.receive_pepper(1)
			gived = true
		$AnimationPlayer.play("TextVisible")
		$RichTextLabel.visible = true
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
