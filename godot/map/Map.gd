extends TileMap

onready var _tileset = get_tileset()

var _child_cache = []

func add_entity(entity) -> void:
	add_child(entity)
	entity.position = map_to_world(entity.cell)
	_child_cache.push_back(entity)

func is_floor_passable(cell: Vector2) -> bool:
	var index = get_cellv(cell)
	return _tileset.tile_get_name(index) in RL.PASSABLE_TILES

func get_entity_at(cell: Vector2):
	for child in _child_cache:
		if child.cell == cell:
			return child
	return null

func is_cell_passable(cell: Vector2) -> bool:
	if is_floor_passable(cell):
		var entity = get_entity_at(cell)
		return !entity or !entity.is_in_group(RL.GROUP_BLOCKER)
	return false

func get_passable_cells(amount = 1):
	var result = []
	if amount < 1:
		return result
	
	var used_cells = get_used_cells()
	used_cells.shuffle()
	for cell in used_cells:
		if is_cell_passable(cell):
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
