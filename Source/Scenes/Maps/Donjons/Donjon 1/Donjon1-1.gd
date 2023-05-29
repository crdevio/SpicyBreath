extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var e1_fini = false
var e2_fini = false
var e3_fini = false

var e3_torch = false
var e3_press_1 = false
var e3_press_2 = false

var e1_well_placed = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func open_door1():
	$CavernDoor_E0_1.queue_free()

func pressure_down(id):
	if not e2_fini:
		var g1 = $LightingFirecamp2
		g1.visible = true
		g1.collision_mask = 7
		g1.collision_layer = 7
	if not e3_fini and id == 2:
		var g1 = $LightingFirecamp3
		g1.visible = true
		g1.collision_mask = 7
		g1.collision_layer = 7
	if not e3_fini :
		check_e3()
	
func pressure_up(id):
	
	if not e2_fini:
		var g1 = $LightingFirecamp2
		g1.visible = false
		g1.collision_mask = 0
		g1.collision_layer = 0
	if not e3_fini and id == 2:
		var g1 = $LightingFirecamp3
		g1.visible = false
		g1.collision_mask = 0
		g1.collision_layer = 0
func ground_fired_callback(id):
	if not e1_fini :
		var g1 = $GoalMarker_E1_1
		var g2 = $GoalMarker_E1_2
		var g3 = $GoalMarker_E1_3
		var g4 = $GoalMarker_E1_4
		var g5 = $GoalMarker_E1_5
		var g6 = $GoalMarker_E1_6
		g1.show()
		g2.show()
		g3.show()
		g4.show()
		g5.show()
		g6.show()
	elif not e2_fini:
		$CavernDoorE2_1.queue_free()
		e2_fini = true
	elif not e3_fini:
		check_e3()

func check_e3():
	var c1 = $LightingFirecamp3.burning
	var c2 = $PressurePlate.is_active
	var c3 = $PressurePlate4.is_active
	if (not e3_fini) and c1 and c2 and c3:
		e3_fini = true
		$Stairs.activate()

func goal_marker_reached(id):
	if not e1_fini :
		e1_well_placed += 1
		if e1_well_placed == 6 :
			e1_fini = true
			$CavernDoorE1_2.queue_free()
func goal_marker_unreached(id):
	if not e1_fini :
		e1_well_placed -= 1

