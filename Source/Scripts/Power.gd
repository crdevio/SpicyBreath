extends Node

export(float) var cooldown = 1000
onready var MovingBigFireball = load("res://Entities/Power/fire/MovingBigFireball/MovingBigFireball.tscn")
onready var MovingFireball = load("res://Entities/Power/fire/MovingFireball/MovingFireball.tscn")
onready var BigFireball = load("res://Entities/Power/fire/BigFireball/BigFireball.tscn")
onready var Fireball = load("res://Entities/Power/fire/Fireball/Fireball.tscn")

onready var MovingBigIceball = load("res://Entities/Power/ice/MovingBigIceball/MovingBigIceball.tscn")
onready var MovingIceball = load("res://Entities/Power/ice/MovingIceball/MovingIceball.tscn")
onready var BigIceball = load("res://Entities/Power/ice/BigIceball/BigIceball.tscn")
onready var Iceball = load("res://Entities/Power/ice/Iceball/Iceball.tscn")

"""
onready var MovingBigWaterball = load("res://Entities/Power/MovingBigWaterball.tscn")
onready var MovingWaterball = load("res://Entities/Power/MovingWaterball.tscn")
onready var BigWaterball = load("res://Entities/Power/BigWaterball.tscn")
onready var Waterball = load("res://Entities/Power/Waterball.tscn")

onready var BigWindball = load("res://Entities/Power/BigWindball.tscn")
"""
onready var Windball = load("res://Entities/Power/wind/Windball/Windball.tscn")

var last = -1

func fire(player):
	if OS.get_ticks_msec() - last < cooldown:
		return	
		
	last = OS.get_ticks_msec() 
	
	var fire = UnlockedThings.actived[UnlockedThings.dict["fire"]] and not UnlockedThings.actived[UnlockedThings.dict["invert"]]
	var ice = (UnlockedThings.actived[UnlockedThings.dict["fire"]] and UnlockedThings.actived[UnlockedThings.dict["invert"]])
	var wind = UnlockedThings.actived[UnlockedThings.dict["wind"]]
	
	var projection = UnlockedThings.actived[UnlockedThings.dict["projection"]]
	var invert = UnlockedThings.actived[UnlockedThings.dict["invert"]]
	var propagate = UnlockedThings.actived[UnlockedThings.dict["propagate"]]
	
	print("Fire : ",fire, " Ice : ",ice, " Wind : ",wind, " Projection : ",projection, " Invert  : ",invert, " Propagate : ",propagate)
	
	var water = false
	
	var bigger = wind
	wind = wind and not(fire or ice or water)
	
	
	if fire:
		if projection and bigger:
			fire_power(player, MovingBigFireball)
		elif projection:
			fire_power(player, MovingFireball)
		elif bigger:
			fire_power(player, BigFireball)
		else:
			fire_power(player, Fireball)
	elif ice:
		if projection and bigger:
			fire_power(player, MovingBigIceball)
		elif projection:
			fire_power(player, MovingIceball)
		elif bigger:
			fire_power(player, BigIceball)
		else:
			fire_power(player, Iceball)
	elif wind:
		fire_power(player,Windball)

func fire_power(player, type):
	if player.pet.orientation * 32 == (player.position - player.pet.position):
		return
	if type == null:
		return
	var power_instance = type.instance() 
	
	if(power_instance.has_method("fire_power")):
		power_instance.fire_power(player)
	else:
		
		power_instance.pet = player.pet
		power_instance.direction = player.pet.orientation

		if(power_instance.has_method("update_transform")):
			power_instance.update_transform()
		power_instance.position = player.pet.position 
		
		player.get_parent().add_child(power_instance)
	
		player.pet.animation_tree.get("parameters/playback").travel("Breathing")
		player.pet.animation_tree.set("parameters/Breathing/blend_position", player.pet.orientation)

func fire_moving_fireball(player):
	if player.pet.orientation * 32 == (player.position - player.pet.position):
		return
	var moving_fireball_instance = MovingFireball.instance() 
	moving_fireball_instance.pet = player.pet
	moving_fireball_instance.direction = player.pet.orientation

	moving_fireball_instance.transform = moving_fireball_instance.transform.rotated(player.pet.orientation.angle())
	moving_fireball_instance.position = player.pet.position + player.pet.orientation * 8

	player.get_parent().add_child(moving_fireball_instance)

	player.pet.animation_tree.get("parameters/playback").travel("Breathing")
	player.pet.animation_tree.set("parameters/Breathing/blend_position", player.pet.orientation)
