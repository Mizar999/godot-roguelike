extends Reference
class_name Pathfinder

var astar: AStar2D
var bounds: Rect2
var dirty_cells
var _map
var _debug_draw

func _init():
	astar = AStar2D.new()
	bounds = Rect2()
	dirty_cells = {}
	_map = null

func initialize_map(map, debug_draw) -> void:
	astar.clear()
	_map = map
	_debug_draw = debug_draw
	_debug_draw.tilesize = _map.cell_size * _map.scale
	bounds = map.get_used_rect()
	_initialize_connections()

func get_path(from: Vector2, to: Vector2):
	update_connections()
	return astar.get_point_path(_get_id(from), _get_id(to))

func update_connections() -> void:
	var cell_id
	var neighbor
	var neighbor_id
	var is_passable
	for cell in dirty_cells:
		cell_id = _get_id(cell)
		is_passable = dirty_cells[cell]
		for x in range(-1, 2):
			for y in range(-1, 2):
				neighbor = Vector2(cell.x + x, cell.y + y)
				neighbor_id = _get_id(neighbor)
				if cell_id != neighbor_id and astar.has_point(cell_id) and astar.has_point(neighbor_id):
					# TODO Wrong update logic: Movement from cell to neighbor must be possible,
					# if neighbor is passable
					if is_passable:
						if !astar.are_points_connected(cell_id, neighbor_id):
							astar.connect_points(cell_id, neighbor_id)
					else:
						if astar.are_points_connected(cell_id, neighbor_id):
							astar.disconnect_points(cell_id, neighbor_id)
					_debug_draw.set_connection(cell, neighbor, astar.are_points_connected(cell_id, neighbor_id))
	dirty_cells.clear()
	_debug_draw.update()

func _get_id(cell) -> int:
	return (cell.y * bounds.size.x) + cell.x

func _initialize_connections() -> void:
	astar.clear()
	var cells = _map.get_floor_cells()
	for cell in cells:
		astar.add_point(_get_id(cell), Vector2(cell.x, cell.y))
	
	var cell_id
	var neighbor
	var neighbor_id
	for cell in cells:
		cell_id = _get_id(cell)
		for x in range(-1, 2):
			for y in range(-1, 2):
				neighbor = Vector2(cell.x + x, cell.y + y)
				neighbor_id = _get_id(neighbor)
				if cell_id != neighbor_id and astar.has_point(neighbor_id):
					astar.connect_points(cell_id, neighbor_id)
					_debug_draw.set_connection(cell, neighbor, astar.are_points_connected(cell_id, neighbor_id))
	_debug_draw.update()

