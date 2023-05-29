extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var tuto2_shown = false
var cavedoor_engime_1_2_free = false
var code = []
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.seed = hash("RedaMadeThisGame")
	rng.randomize()
	reset_code()
	$Player/Camera2D/CanvasLayer/HUD.draw_tutorial(1)
	pass # Replace with function body.
func reset_code():
	var n = rng.randi_range(2,3)
	code = []
	while len(code) < n:
		var choix = rng.randi_range(1,4)
		if not choix in code :
			code.append(choix)
	
func open_door1():
	$CavernDoor_King.free()

func button_actived(id):
	if id == 1 :
		$CavernDoor_Enigme1_1.free()
	if id == 3:
		cavedoor_engime_1_2_free = true
		$CavernDoor_Enginme1_2.free()
		$CavernDoor_Enigme2_1.free()
	pass


func button_deactived(id):
	pass

func pressure_down(id):
	if id == 1 and not cavedoor_engime_1_2_free:
		$CavernDoor_Enginme1_2.open()
	if id == 2:
		var f1 = $LF_BAS_1
		var f2 = $LF_BAS_2
		var f3 = $LF_BAS_3
		var f4 = $LF_BAS_4
		f1.eteindre()
		f2.eteindre()
		f3.eteindre()
		f4.eteindre()
		for e in code:
			if e == 1 :
				f1.allumer()
			if e == 2:
				f2.allumer()
			if e == 3 :
				f3.allumer()
			if e == 4:
				f4.allumer()
	if id == 3 :
		var f1 = $LF_BAS_1
		var f2 = $LF_BAS_2
		var f3 = $LF_BAS_3
		var f4 = $LF_BAS_4
		var t1 = $LF_HAUT_1
		var t2 = $LF_HAUT_2
		var t3 = $LF_HAUT_3
		var t4 = $LF_HAUT_4
		var ok = true
		for e in code:
			if e == 1 and t1.burning == false : ok = false
			if e == 2 and t2.burning == false : ok = false
			if e == 3 and t3.burning == false : ok = false
			if e == 4 and t4.burning == false : ok = false
		var c2 = []
		for e in [1,2,3,4]:
			if not e in code: c2.append(e)
		for e in c2:
			if e == 1 and t1.burning == true : ok = false
			if e == 2 and t2.burning == true : ok = false
			if e == 3 and t3.burning == true : ok = false
			if e == 4 and t4.burning == true : ok = false
			
		
		if not ok :
			reset_code()
			f1.eteindre()
			f2.eteindre()
			f3.eteindre()
			f4.eteindre()
			t1.eteindre()
			t2.eteindre()
			t3.eteindre()
			t4.eteindre()
			if $PressurePlate2.is_active:
				for e in code :
					if e == 1 : f1.allumer()
					if e == 2 : f2.allumer()
					if e == 3 : f3.allumer()
					if e == 4 : f4.allumer()
		else:
			$Stairs.activate()
func pressure_up(id):
	if id == 1 and not cavedoor_engime_1_2_free:
		if tuto2_shown == false :
			tuto2_shown = true
			$Player/Camera2D/CanvasLayer/HUD.draw_tutorial(2)
		$CavernDoor_Enginme1_2.close()
	if id == 2:
		var f1 = $LF_BAS_1
		var f2 = $LF_BAS_2
		var f3 = $LF_BAS_3
		var f4 = $LF_BAS_4
		f1.eteindre()
		f2.eteindre()
		f3.eteindre()
		f4.eteindre()
		
