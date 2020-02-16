extends Reference
class_name Game

var map
var player
var actors: Array

func _init(map_p):
	map = map_p
	player = spawn("actors/player", Vector2(1, 1))
	spawn("props/statue", Vector2(2, 3))

func spawn(path: String, cell: Vector2):
	var entity = RL.database.create_entity(path)
	entity.cell = cell
	map.add_entity(entity)
	# Cannot check for type 'Actor' with 'entity is Actor', because of cylcic reference
	# see: https://github.com/godotengine/godot/issues/21461#issuecomment-578860188
	if entity.has_method("take_turn"):
		actors.push_back(entity)
	return entity

func main_loop() -> void:
	var command
	var command_result
	while true:
		player.call_deferred("take_turn", self) # TODO replace player with actors array
		command = yield(player, "acted")
		command.call_deferred("execute", self)
		command_result = yield(command, "executed")
		if (command_result.result_type != command_result.ResultType.Success) and (command_result.message != ""):
			print(command_result.message)

func is_cell_passable(cell: Vector2) -> bool:
	return false # TODO implement me
