extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var enigme1 = 0
var e1_1_fini = false
var e1_2_fini = false
var e2_fini = false
var e3_fini = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("E2_TorchMoving")
	pass # Replace with function body.

func ground_fired_callback(id):
	if e1_1_fini == false :
		var f1 = $Torch_Engime1_1.burning
		var f2 = $Torch_Enigme1_2.burning
		if f1 == f2 == true :
			e1_1_fini = true
			$CavernDoor_Engime1_1.queue_free()
	elif e1_2_fini == false : 
		var f1 = $LF_Enigme1_1.burning
		if f1 :
			e1_2_fini = true 
			$CavernDoor_Enigme1_2.queue_free()
	
			 

func up_fired_callback(id):
	if e1_1_fini == false :
		var f1 = $Torch_Engime1_1.burning
		var f2 = $Torch_Enigme1_2.burning
		if f1 == f2 == true :
			e1_1_fini = true
			$CavernDoor_Engime1_1.queue_free()
	elif e1_2_fini == false : 
		var f1 = $LF_Enigme1_1.burning
		if f1 :
			e1_2_fini = true 
	elif e2_fini == false :
		if $Torch_Enigme2.burning:
			$AnimationPlayer.stop()
			$CavernDoor_Enigme2_1.queue_free()
			e2_fini = true
	elif e3_fini == false:
		var f = $Torch_E3.burning
		if f:
			e3_fini = true
			$Stairs.activate()
func open_door1():
	$CavernDoor_Give_1.queue_free()
