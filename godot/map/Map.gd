extends TileMap

onready var _tileset = get_tileset()

func add_entity(entity) -> void:
	add_child(entity)
	entity.position = map_to_world(entity.cell)

func is_floor_passable(cell: Vector2) -> bool:
	var index = get_cellv(cell)
	return _tileset.tile_get_name(index) in RL.PASSABLE_TILES

func get_entity_at(cell: Vector2):
	for child in get_children():
		if child.cell == cell:
			return child
	return null

func get_passable_cells(amount = 1):
	var result = []
	if amount < 1:
		return result
	
	var used_cells = get_used_cells()
	used_cells.shuffle()
	for cell in used_cells:
		if is_floor_passable(cell) and get_entity_at(cell) == null:
			result.push_back(cell)
			if result.size() >= amount:
				break
	return result

func get_floor_cells():
	var result = []
	for cell in get_used_cells():
		if is_floor_passable(cell):
			result.push_back(cell)
	return result
