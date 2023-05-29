extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var piment_feu = load("res://Assets/HUD/Piments/Selection_piment_fire.png")
var piment_projection = load("res://Assets/HUD/Piments/Selection_piment_fire.png")
var piment_vent = load("res://Assets/HUD/Piments/Selection_piment_wind.png")
var piment_inversion = load("res://Assets/HUD/Piments/Selection_piment_wind.png")
var piment_glace = load("res://Assets/HUD/Piments/Selection_piment_ice.png")
var piment_propagation = load("res://Assets/HUD/Piments/Selection_piment_wind.png")
var piment_unkwn = load("res://Assets/HUD/Piments/Selection_piment_unknwn.png")
# Called when the node enters the scene tree for the first time.
var piments_list = [piment_feu,piment_projection,piment_vent,piment_inversion,
piment_glace,piment_propagation]
var ind_act = 0
var unlocked = true
func _ready():
	 
	pass # Replace with function body.

func update_unlocked():
	if ind_act == 0 :
		unlocked = true
	if ind_act == 1 :
		if UnlockedThings.projection_unlocked :
			unlocked = true
		else:
			unlocked = false
	if ind_act == 2 :
		if UnlockedThings.wind_unlocked :
			unlocked = true
		else:
			unlocked = false
	if ind_act == 3 :
		if UnlockedThings.inversion_unlocked :
			unlocked = true
		else:
			unlocked = false
	if ind_act == 4 :
		if UnlockedThings.ice_unlocked :
			unlocked = true
		else:
			unlocked = false
	if ind_act == 5 :
		if UnlockedThings.propagation_unlocked :
			unlocked = true
		else:
			unlocked = false
func update_img():
	if unlocked :
		texture = piments_list[ind_act]
	else:
		texture = piment_unkwn
func next_ind():
	ind_act = (ind_act + 1) % len(piments_list)
	print(ind_act)
	update_unlocked()
	update_img()
func prev_ind():
	ind_act = (ind_act - 1 + len(piments_list)) % len(piments_list)
	print(ind_act)
	update_unlocked()
	update_img()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
