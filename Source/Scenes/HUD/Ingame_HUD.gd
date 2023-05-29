extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var fire_active = false
var ice_active  = false
var wind_active = false
var inversion_active = false
var propagation_active = false
var projection_active = false 

func _ready():
	pass # Replace with function body.

func draw_tutorial(id):
	if id == 1:
		get_parent().get_parent().get_parent().can_move = false
		$AnimationPlayer.stop()
		$Tutorial/RichTextLabel.text ="Press E to interact with the world (speak with NPC & activate objects)"
		$AnimationPlayer.playback_speed = 2
		$AnimationPlayer.play("TutorialShow")
	elif id == 2 :
		get_parent().get_parent().get_parent().can_move = false
		$AnimationPlayer.stop()
		$Tutorial/RichTextLabel.text = "Press CTRL to let Sirus (the pet) at a place, and then press CTRL near him to take him back."
		$AnimationPlayer.playback_speed = 2
		$AnimationPlayer.play("TutorialShow")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func received_pepper(id):
	
	$ObjectReceived/Label.text = UnlockedThings.name_dict[id] +  " pepper received"
	$AnimationPlayer.play("ItemReceived")
	update_affichage()
	

func update_affichage():
	$HBoxContainer/Feu.update_affichage()
	$HBoxContainer/Vent.update_affichage()
	$HBoxContainer/Inverse.update_affichage()
	$HBoxContainer/Glace.update_affichage()
	$HBoxContainer/Propagation.update_affichage()
func _on_btn_upselection_pressed():
	$ItemSlotContainer/TextureRect.next_ind()


func _on_btn_downselection_pressed():
	$ItemSlotContainer/TextureRect.prev_ind()


func _on_AnimationPlayer_animation_finished(anim_name):
	get_parent().get_parent().get_parent().can_move = true
	pass # Replace with function body.
