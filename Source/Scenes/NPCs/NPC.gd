extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String) var nom = "NPC"
export(String) var text = "Not set"
export(bool) var interactible = false
export(Texture) var img = load("res://Assets/Characters/NPC/MotherIdle.png")
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
		$AnimationPlayer.play("TextVisible")
		$RichTextLabel.visible = true
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
