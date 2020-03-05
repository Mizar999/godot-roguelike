extends Control

var _connections
var tilesize setget _set_tilesize

class ConnectionData:
	var from
	var to
	var connected
	
	func _init(from_p, to_p, connected_p):
		from = from_p
		to = to_p
		connected = connected_p

func _ready():
	_connections = {}
	tilesize = 1

func set_connection(from: Vector2, to: Vector2, connected: bool) -> void:
	var key = "%s,%s;%s,%s" % [from.x, from.y, to.x, to.y]
	if _connections.has(key):
		_connections[key].connected = connected
	else:
		_connections[key] = ConnectionData.new(from, to, connected)

func _set_tilesize(size: Vector2) -> void:
	tilesize = size
	update()

func _draw():
	var color
	var data
	var from
	var dir
	var half_tilesize = tilesize * 0.5
	for key in _connections:
		data = _connections[key]
		color = Color.limegreen if data.connected else Color.crimson
		# draw a line in direction from 'data.from' to 'data.to' with half tilesize length
		from = data.from * tilesize + half_tilesize
		dir = (data.to - data.from) * half_tilesize
		draw_line(from, from + dir, color, 1.5)
