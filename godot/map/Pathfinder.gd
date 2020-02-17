extends Reference
class_name Pathfinder

var astar: AStar2D
var bounds: Rect2
var _map

# TODO enemies should not bump into each other
func _init():
	astar = AStar2D.new()
	bounds = Rect2()
	_map = null

func initialize_map(map) -> void:
	astar.clear()
	_map = map
	bounds = map.get_used_rect()
	for cell in map.get_floor_cells():
		astar.add_point(_get_id(cell), Vector2(cell.x, cell.y))

func get_path(from: Vector2, to: Vector2):
	_update_connections([from, to])
	return astar.get_point_path(_get_id(from), _get_id(to))

func _update_connections(passable_cells = []) -> void:
	var neighbor
	var neighbor_id
	var cell_id
	var is_passable
	var cells = _map.get_floor_cells()
	for cell in cells:
		cell_id = _get_id(cell)
		is_passable = cell in passable_cells
		for x in range(-1, 2):
			for y in range(-1, 2):
				neighbor = Vector2(cell.x + x, cell.y + y)
				if neighbor != cell and neighbor in cells:
					neighbor_id = _get_id(neighbor)
					if is_passable or neighbor in passable_cells or !_map.get_entity_at(neighbor):
						astar.connect_points(cell_id, neighbor_id)
					else:
						astar.disconnect_points(cell_id, neighbor_id)

func _get_id(cell) -> int:
	return (cell.y * bounds.size.x) + cell.x
