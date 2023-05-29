extends TextureButton
export(Texture) var NotActive = load("res://Assets/HUD/Piments/Selection_piment_unknwn.png")
export(Texture) var Active = load("res://Assets/HUD/Piments/Selection_piment_unknwn.png")
export(Texture) var NotDiscovered = load("res://Assets/HUD/Piments/Selection_piment_unknwn.png")
var Discoverd = false
export(int) var  piments_id = 0
var active = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func update_affichage():
	if not UnlockedThings.is_piment_unlocked(piments_id):
		update_texture(NotDiscovered)
	else :
		if UnlockedThings.actived[piments_id]:
			update_texture(Active)
		else:
			update_texture(NotActive)

func update_texture(tx):
	texture_normal = tx
	texture_hover = tx
	texture_disabled = tx
	texture_focused = tx
	texture_pressed = tx


func _on_TextureButton_pressed():
	
	update_affichage()
	pass # Replace with function body.
