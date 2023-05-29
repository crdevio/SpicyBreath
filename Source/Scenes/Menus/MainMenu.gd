extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("AnimText")
	$AnimationPlayer2.playback_speed = 0.25
	$AnimationPlayer2.play("AnimMap")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LaunchGame_pressed():
	get_tree().change_scene("res://Scenes/Maps/Donjons/Tutoriel.tscn")
	pass # Replace with function body.
