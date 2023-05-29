extends StaticBody2D

export(bool) var type = false 

func _ready():
	$Sprite.flip_h = not type


func _on_Area2D_body_entered(body):
	if "spell_mirror_destroy" in body.get_groups():
		body.queue_free()
		queue_free()
		return
		
	if "spell" in body.get_groups() and "spell_mirror" in body.get_groups():
		
		var dir = body.direction
		dir = Vector2(dir.y, dir.x)
		
		if type :
			dir *= -1
		
		print(dir.angle())
		
		body.position = Vector2.ZERO
		body.transform = body.transform.rotated(dir.angle() - body.direction.angle())
		body.position = position + dir * 32
		
		body.direction = dir
		body.velocity = dir * body.speed
		
	if "spell_wind" in body.get_groups():
		type = not type
		$Sprite.flip_h = not type
