extends Reference
class_name SimpleAStar

enum Topology {
	Four,
	Eight
}

var passable_callback

var _openlist: Array
var _closedlist: Dictionary
var _from: Vector2
var _directions: Array
var _topology

func find_path(from: Vector2, to: Vector2, topology = Topology.Eight) -> Array:
	_openlist = []
	_closedlist = {}
	_from = from
	_topology = topology
	_setup_directions()
	_add_node(to)
	var result = []
	
	var key: String
	var node: AStarNode
	var neighbors: Array
	while !_openlist.empty():
		node = _openlist.pop_front()
		key = "%s,%s" % [node.cell.x, node.cell.y]
		if _closedlist.has(key):
			continue
		_closedlist[key] = node
		if node.cell == _from:
			break
		
		neighbors = _get_neighbors(node.cell)
		for neighbor in neighbors:
			key = "%s,%s" % [neighbor.x, neighbor.y]
			if _closedlist.has(key):
				continue
			_add_node(neighbor, node)
	
	key = "%s,%s" % [_from.x, _from.y]
	if _closedlist.has(key):
		node = _closedlist[key]
		while node:
			result.push_back(node.cell)
			node = node.previous
	return result

func _setup_directions() -> void:
	if _topology == Topology.Four:
		_directions = [
			Vector2(1, 0),
			Vector2(-1, 0),
			Vector2(0, 1),
			Vector2(0, -1)
		]
	else:
		_directions = [
			Vector2(1, 0),
			Vector2(-1, 0),
			Vector2(0, 1),
			Vector2(0, -1),
			Vector2(1, 1),
			Vector2(1, -1),
			Vector2(-1, 1),
			Vector2(-1, -1)
		]

func _get_neighbors(current_cell: Vector2) -> Array:
	var result = []
	var neighbor
	for dir in _directions:
		neighbor = current_cell + dir
		if !passable_callback.call_func(_from, neighbor):
			continue
		result.push_back(neighbor)
	return result

func _add_node(cell: Vector2, previous = null) -> void:
	var estimated_cost = _distance(cell)
	var node = AStarNode.new(cell, (previous.cost if previous else 0), estimated_cost, previous)
	var total_cost = node.cost + node.estimated_cost
	
	var temp_node
	var temp_total_cost
	for index in range(_openlist.size()):
		temp_node = _openlist[index]
		temp_total_cost = temp_node.cost + temp_node.estimated_cost
		if total_cost < temp_total_cost or (total_cost == temp_total_cost and estimated_cost < temp_node.estimated_cost):
			_openlist.insert(index, node)
			return
	_openlist.push_back(node)

func _distance(current_cell: Vector2) -> float:
	if _topology == Topology.Four:
		return abs(current_cell.x - _from.x) + abs(current_cell.y - _from.y)
	else:
		return max(abs(current_cell.x - _from.x), abs(current_cell.y - _from.y))
