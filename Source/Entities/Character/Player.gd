extends KinematicBody2D

export(float) var snapping_duration = 0.2

var elapsed = 0

var _snapping_direction = Vector2.ZERO
var _snapping_final = null

onready var ray = $RayCast2D
onready var pet = get_parent().get_node("Pet")

onready var power = $Power
var can_move = true
var pressing_delay = 0

func _ready():
	$Camera2D/CanvasLayer/HUD.update_affichage()
	ray.add_exception(pet)
	pass

var orientation = null
var folowing = true

var fire_when_finished = false

func receive_pepper(id):
	UnlockedThings.unlocked[id] = true
	$Camera2D/CanvasLayer/HUD.received_pepper(id)
func _physics_process(delta):
	if can_move:
		if Input.is_action_just_pressed("game_spicy_1"):
			if UnlockedThings.unlocked[0]:
				UnlockedThings.actived[0] = not UnlockedThings.actived[0]
				$Camera2D/CanvasLayer/HUD.update_affichage()
				#print("ACTIVE :")
				#print(UnlockedThings.actived[0])
		if Input.is_action_just_pressed("game_spicy_2"):
			if UnlockedThings.unlocked[1]:
				UnlockedThings.actived[1] = not UnlockedThings.actived[1]
				$Camera2D/CanvasLayer/HUD.update_affichage()
		if Input.is_action_just_pressed("game_spicy_3"):
			if UnlockedThings.unlocked[2]:
				UnlockedThings.actived[2] = not UnlockedThings.actived[2]
				$Camera2D/CanvasLayer/HUD.update_affichage()
		if Input.is_action_just_pressed("game_spicy_4"):
			if UnlockedThings.unlocked[3]:
				UnlockedThings.actived[3] = not UnlockedThings.actived[3]
				$Camera2D/CanvasLayer/HUD.update_affichage()
		if Input.is_action_just_pressed("game_spicy_5"):
			if UnlockedThings.unlocked[4]:
				UnlockedThings.actived[4] = not UnlockedThings.actived[4]
				$Camera2D/CanvasLayer/HUD.update_affichage()
		if Input.is_action_just_pressed("game_interact"):
			var space_state = get_world_2d().direct_space_state
			var result = space_state.intersect_ray(position,position + orientation * 32,[self])
			if result:
				if result.collider.has_method("Interact"):
					result.collider.Interact()
		elapsed += delta
		if(elapsed < snapping_duration && _snapping_final != null):
			position += _snapping_direction * delta
			$AnimationTree.get("parameters/playback").travel("Walking")
			$AnimationTree.set("parameters/Idle/blend_position",_snapping_direction)
			$AnimationTree.set("parameters/Walking/blend_position",_snapping_direction)
			return
		elif _snapping_final != null:
			position = _snapping_final

			_snapping_final = null
			_snapping_direction = Vector2.ZERO
			
			if(fire_when_finished):
				power.fire(self)
				fire_when_finished = false
			
		else:
			var moving = Vector2.ZERO 
			
			if Input.is_action_pressed("game_move_right"):
				moving = Vector2(1, 0)
			elif Input.is_action_pressed("game_move_left"):
				moving = Vector2(-1, 0)
			elif Input.is_action_pressed("game_move_forward"):
				moving = Vector2(0, -1)
			elif  Input.is_action_pressed("game_move_down"):
				moving = Vector2(0, 1)
			
			pressing_delay += delta
			
			if moving == Vector2.ZERO:
				if Input.is_action_pressed("game_fire"):
					if pet.orientation * 32 != (position - pet.position):
						power.fire(self)
					else:
						move_on_tilemap(-pet.orientation)
						pressing_delay = 0
						fire_when_finished = true
				else:
					$AnimationTree.get("parameters/playback").travel("Idle")
					pet.animation_tree.get("parameters/playback").travel("Idle")
					if Input.is_action_just_pressed("game_pet_toggle_following"):
						if pet.position.distance_to(self.position)/32 == 1:
							folowing = not folowing
							if folowing:
								ray.add_exception(pet)
							else:
								ray.clear_exceptions()
								ray.remove_exception(pet)
							last_direction = Vector2.ZERO
					pressing_delay = 0
			elif pressing_delay > 0.025:
				move_on_tilemap(moving)
				pressing_delay = 0  
			if Input.is_action_just_pressed("game_rotate_pet_right"):
				var rte = Vector2(1, 0)
				pet.orientation = rte
				pet.animation_tree.set("parameters/Idle/blend_position", rte)
			elif Input.is_action_just_pressed("game_rotate_pet_left"):
				var rte = Vector2(-1, 0)
				pet.orientation = rte
				pet.animation_tree.set("parameters/Idle/blend_position", rte)
			elif Input.is_action_just_pressed("game_rotate_pet_up"):
				var rte = Vector2(0, -1)
				pet.orientation = rte
				pet.animation_tree.set("parameters/Idle/blend_position", rte)
			elif Input.is_action_just_pressed("game_rotate_pet_down"):
				var rte = Vector2(0, 1)
				pet.orientation = rte
				pet.animation_tree.set("parameters/Idle/blend_position", rte)
			
var last_direction = Vector2.ZERO
func update_hud():
	$Camera2D/CanvasLayer/HUD.update_affichage()
func move_on_tilemap(direction:Vector2):
	orientation = direction
	ray.cast_to = direction * 32
	ray.force_raycast_update()
	if not ray.is_colliding():
		_snapping_direction = direction * 32 / snapping_duration
		_snapping_final = position + direction * 32
		
		if folowing:
			if last_direction != Vector2.ZERO:
				pet.move_on_tilemap(last_direction)
			else:
				pet.move_on_tilemap(-(pet.position - position)/32)
			
		last_direction = direction
	else:
		$AnimationTree.set("parameters/Idle/blend_position", orientation)
	elapsed = 0
	
	
