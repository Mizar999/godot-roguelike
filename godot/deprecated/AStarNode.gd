extends Reference
class_name AStarNode

var cell
var cost
var estimated_cost
var previous: AStarNode

func _init(cell_p = Vector2(), cost_p = 0, estimated_cost_P = 0, previous_p = null):
	cell = cell_p
	cost = cost_p
	estimated_cost = estimated_cost_P
	previous = previous_p
