extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func ground_fired_callback(id):
	if id == 0:
		$Stairs_D0.activate()
	
func up_fired_callback(id):
	if id == 0:
		$Stairs_D1.activate()
