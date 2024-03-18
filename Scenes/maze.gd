extends TileMap

@export var random_point_radius := 6.0
var rng := RandomNumberGenerator.new()
var all_tiles : Array[Vector2i] 


func _ready() -> void:
	all_tiles = get_used_cells(0)
	Manager.maze = self


func get_random_point_in_radius(center: Vector2) -> Vector2:
	rng.randomize()
	#convert "center" to tilemap position
	var center_local := to_local(center)
	var center_local_tilemap := local_to_map(center_local)
	#get all tiles within that radius (how?) if they are from 'floor' type
	#pick random position from that
	var tiles_in_radius := []
	#for cell in all_tiles:
		#var data = get_cell_tile_data(0, cell)
		#var floor = data.get_custom_data("Floor")
		#var dist = Vector2(cell).distance_to(center_local_tilemap)
		#if floor and dist <= random_point_radius:
			#tiles_in_radius.append(cell)
	#var target = tiles_in_radius[rng.randi() % tiles_in_radius.size()]
	
	for col in range(center_local_tilemap.x - random_point_radius / 2, center_local_tilemap.x + random_point_radius + 1.0):
		for row in range(center_local_tilemap.y - random_point_radius/2, center_local_tilemap.y + random_point_radius + 1):
			var cell_coords = Vector2i(Vector2(col, row))
			var data = get_cell_tile_data(0, cell_coords)
			if data:
				var floor = data.get_custom_data("Floor")
				if floor:
					tiles_in_radius.append(cell_coords)
	var target = tiles_in_radius[rng.randi() % tiles_in_radius.size()]
	return to_global(map_to_local(target))
