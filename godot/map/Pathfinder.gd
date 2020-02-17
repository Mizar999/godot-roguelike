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
	var cells = map.get_floor_cells()
	for cell in cells:
		astar.add_point(_get_id(cell), Vector2(cell.x, cell.y))
	update_connections(cells)

func get_path(from: Vector2, to: Vector2):
	update_connections([from], to)
	return astar.get_point_path(_get_id(from), _get_id(to))

func update_connections(cells = [], target = null) -> void:
	var neighbor
	var neighbor_id
	var is_neighbor_passable
	var cell_id
	for cell in cells:
		cell_id = _get_id(cell)
		for x in range(-1, 2):
			for y in range(-1, 2):
				neighbor = Vector2(cell.x + x, cell.y + y)
				neighbor_id = _get_id(neighbor)
				if neighbor != cell and astar.has_point(neighbor_id):
					is_neighbor_passable = !_map.get_entity_at(neighbor) or (target and neighbor == target)
					if is_neighbor_passable:
						astar.connect_points(cell_id, neighbor_id, false)
					else:
						if astar.are_points_connected(cell_id, neighbor_id):
							astar.disconnect_points(cell_id, neighbor_id)

func _get_id(cell) -> int:
	return (cell.y * bounds.size.x) + cell.x
