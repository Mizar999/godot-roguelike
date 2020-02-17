extends Reference
class_name Pathfinder

var astar: AStar2D
var bounds: Rect2
var dirty_cells: Array
var _map

# TODO enemies should not bump into each other
func _init():
	astar = AStar2D.new()
	bounds = Rect2()
	dirty_cells = []
	_map = null

func initialize_map(map) -> void:
	astar.clear()
	_map = map
	bounds = map.get_used_rect()
	var cells = map.get_floor_cells()
	for cell in cells:
		astar.add_point(_get_id(cell), Vector2(cell.x, cell.y))
	for cell in cells:
		_connect_neighbors(cells, cell)

func get_path(from: Vector2, to: Vector2):
	dirty_cells.push_back(from)
	_connect_dirty_cells()
	return astar.get_point_path(_get_id(from), _get_id(to))

func _connect_neighbors(cells: Array, cell_to_connect: Vector2) -> void:
	var neighbor
	var neighbor_id
	var cell_id = _get_id(cell_to_connect)
	for x in range(-1, 2):
		for y in range(-1, 2):
			neighbor = Vector2(cell_to_connect.x + x, cell_to_connect.y + y)
			if neighbor != cell_to_connect and neighbor in cells and !_map.get_entity_at(neighbor):
				neighbor_id = _get_id(neighbor)
				if !astar.are_points_connected(cell_id, neighbor_id):
					astar.connect_points(cell_id, neighbor_id)

func _connect_dirty_cells() -> void:
	var cells = _map.get_floor_cells()
	while !dirty_cells.empty():
		_connect_neighbors(cells, dirty_cells.pop_front())

func _get_id(cell) -> int:
	return (cell.y * bounds.size.x) + cell.x
