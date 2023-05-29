extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var id = 0
export(Texture) var NotActived = load("res://Assets/Characters/NPC/MotherIdle.png")
export(Texture) var Actived = load("res://Assets/Characters/NPC/Roi_Idle.png")
var is_active = false
var compteur = 0
func _ready():
	$Sprite.texture = NotActived
func _on_PressurePlate_body_entered(body):
	if "pressure_plate_activator" in body.get_groups():
		compteur+=1
		switch_state()
func switch_state():
	if compteur>0:
		is_active = true
		$Sprite.texture = Actived
		get_parent().pressure_down(id)
	else:
		is_active = false
		$Sprite.texture = NotActived
		get_parent().pressure_up(id)

func _on_PressurePlate_body_exited(body):
	if "pressure_plate_activator" in body.get_groups():
		compteur-=1
		switch_state()
