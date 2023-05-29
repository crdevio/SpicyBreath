extends StaticBody2D


export(int) var id = 1
export(Texture) var NotActived = load("res://Assets/Characters/NPC/MotherIdle.png")
export(Texture) var Actived = load("res://Assets/Characters/NPC/Roi_Idle.png")
export(bool) var OneShot = true
var is_active = false
func _ready():
	$Sprite.texture = NotActived

func Active():
	is_active = true
	$Sprite.texture = Actived
	get_parent().button_actived(id)
func Deactive():
	is_active = false
	$Sprite.texture = NotActived
	get_parent().button_deactived(id)

func Switch():
	if is_active : Deactive()
	else : Active()
func Interact():
	if not is_active : Active()
	if is_active and not OneShot : Deactive()

