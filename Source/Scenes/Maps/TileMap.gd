extends TileMap

export(float) var delay = 5

var tiles = []

var elapsed = 0

onready var pet = get_node("/root/Map/Pet")
onready var player = get_node("/root/Map/Player")

func _ready():
	elapsed = OS.get_ticks_msec()/1000.0
	
func _physics_process(delta):
	elapsed += delta
	
	var play_pos = world_to_map(player.position)
	var pet_pos = world_to_map(pet.position)
	
	while (tiles.size() > 0 and elapsed - tiles[0][0] >= delay):
		
		if play_pos.distance_to(tiles[0][1]) <= 1 or pet_pos.distance_to(tiles[0][1]) <= 1:
			tiles.append([elapsed, tiles[0][1], tiles[0][2]])
		else:
			set_cellv(tiles[0][1], 15, false, false, false, tiles[0][2])
			update_dirty_quadrants()
			
		tiles.remove(0)
	
func add_icy(x, y, tile):
	if get_cell(x, y) != 15:
		return false
	tiles.append([OS.get_ticks_msec()/1000.0, Vector2(x, y), get_cell_autotile_coord(x, y)])
	set_cellv(Vector2(x, y), 14, false, false, false, Vector2(7, 0))
	update_dirty_quadrants()
	return true
	
func froze_ground(orb, pos, diminish):
	
	pos = world_to_map(pos)
	
	if not add_icy(pos.x, pos.y, orb):
		return false
	if diminish:
		orb.scale -= Vector2.ONE * 0.25
		return orb.scale.length() < 0.1
	return true
