extends TileMap

@export var random_point_radius := 6.0
var rng := RandomNumberGenerator.new()


func _ready() -> void:
	Manager.maze = self
	get_random_point_in_radius(Vector2(0,0))


func get_random_point_in_radius(center: Vector2) -> Vector2:
	rng.randomize()
	#convert "center" to tilemap position
	var center_local := to_local(center)
	var center_local_tilemap := local_to_map(center_local)
	#get all tiles within that radius (how?) if they are from 'floor' type
	#pick random position from that
	var all_tiles := get_used_cells(0)
	var tiles_in_radius := []
	for cell in all_tiles:
		var data = get_cell_tile_data(0, cell)
		var floor = data.get_custom_data("Floor")
		var dist = Vector2(cell).distance_to(center_local_tilemap)
		if floor and dist <= random_point_radius:
			tiles_in_radius.append(cell)
	var target = tiles_in_radius[rng.randi() % tiles_in_radius.size()]
	return to_global(map_to_local(target))
