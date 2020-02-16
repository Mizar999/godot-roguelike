extends Reference
class_name Scheduler

var objects: Array
var _current_index

func _init():
	_current_index = 0

func add(obj):
	objects.push_back(obj)

func remove(obj):
	objects.erase(obj)
	_update_index()

func next():
	if objects.empty():
		return null
	var obj = objects[_current_index]
	_current_index += 1
	_update_index()
	return obj

func _update_index():
	if _current_index >= objects.size():
		_current_index = 0
