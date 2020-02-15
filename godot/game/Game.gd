extends Reference
class_name Game

var map
var player
var actors: Array

func _init(map_p):
	map = map_p
	add_player()
	add_props()

func add_player() -> void:
	player = RL.database.create_entity("actors/player")
	player.cell = Vector2(1, 1)
	map.add_entity(player)
	actors.push_back(player)

func add_props() -> void:
	var entity = RL.database.create_entity("props/statue")
	entity.cell = Vector2(2, 3)
	map.add_entity(entity)
