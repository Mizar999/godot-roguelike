extends Reference
class_name Pathfinder

var astar: AStar2D
var bounds: Rect2
var _map
var _debug_draw

func _init():
	astar = AStar2D.new()
	bounds = Rect2()
	_map = null

func initialize_map(map, debug_draw) -> void:
	astar.clear()
	_map = map
	_debug_draw = debug_draw
	_debug_draw.tilesize = _map.cell_size * _map.scale
	bounds = map.get_used_rect()
	var cells = map.get_floor_cells()
	for cell in cells:
		astar.add_point(_get_id(cell), Vector2(cell.x, cell.y))
	update_connections(cells)

func get_path(from: Vector2, to: Vector2):
	update_connections([from], to)
	return astar.get_point_path(_get_id(from), _get_id(to))

# TODO Something is wrong with this procedure
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
					is_neighbor_passable = neighbor == target or _map.is_cell_passable(neighbor)
					if is_neighbor_passable:
						astar.connect_points(cell_id, neighbor_id, false)
					else:
						if astar.are_points_connected(cell_id, neighbor_id):
							astar.disconnect_points(cell_id, neighbor_id)
					_debug_draw.set_connection(cell, neighbor, astar.are_points_connected(cell_id, neighbor_id))
	_debug_draw.update()

func _get_id(cell) -> int:
	return (cell.y * bounds.size.x) + cell.x
