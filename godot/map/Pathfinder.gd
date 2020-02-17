extends Reference
class_name Pathfinder

var astar: AStar2D
var bounds: Rect2
var _map

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

# TODO bad performance, rewrite to only update dirty cells
func get_path(from: Vector2, to: Vector2):
	_update_connections(from, to)
	return astar.get_point_path(_get_id(from), _get_id(to))

func _update_connections(from: Vector2, to: Vector2) -> void:
	var neighbor
	var neighbor_id
	var is_neighbor_passable
	var cell_id
	var is_cell_passable
	for cell in _map.get_floor_cells():
		cell_id = _get_id(cell)
		is_cell_passable = cell == from or !_map.get_entity_at(cell)
		for x in range(-1, 2):
			for y in range(-1, 2):
				neighbor = Vector2(cell.x + x, cell.y + y)
				neighbor_id = _get_id(neighbor)
				if neighbor != cell and astar.has_point(neighbor_id):
					is_neighbor_passable = neighbor == to or !_map.get_entity_at(neighbor)
					if is_cell_passable and is_neighbor_passable:
						astar.connect_points(cell_id, neighbor_id, true)
					elif is_cell_passable:
						astar.connect_points(neighbor_id, cell_id, false)
					elif is_neighbor_passable:
						astar.connect_points(cell_id, neighbor_id, false)
					else:
						if astar.are_points_connected(cell_id, neighbor_id):
							astar.disconnect_points(cell_id, neighbor_id)

func _get_id(cell) -> int:
	return (cell.y * bounds.size.x) + cell.x
