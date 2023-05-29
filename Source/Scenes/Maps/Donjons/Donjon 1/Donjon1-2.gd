extends Node2D

var e0_fini = false
var e1_fini = false

func _ready():
	pass # Replace with function body.

func pressure_up(id):
	$Torch.visible = false
	$Torch.collision_layer = 0
	$Torch.collision_mask = 0
	
func pressure_down(id):
	$Torch.visible = true
	$Torch.collision_layer = 7
	$Torch.collision_mask = 7

func up_fired_callback(id):
	if not e0_fini and id==0:
		$CavernDoor.queue_free()
		e0_fini = true
	elif not e1_fini and id==1:
		e1_fini = true

func ground_fired_callback(id):
	pass
