extends Reference
class_name Game

var map
var player
var actors: Scheduler
var pathfinder: Pathfinder

func _init(map_p):
	actors = Scheduler.new()
	
	map = map_p
	pathfinder = Pathfinder.new()
	pathfinder.initialize_map(map)
	
	player = spawn("actors/player", Vector2(1, 1))
	for cell in map.get_passable_cells(15):
		spawn("actors/goblin", cell)
	for cell in map.get_passable_cells(20):
		spawn("props/statue", cell).get_node("Symbol").self_modulate = Color(randf(), randf(), randf())

func spawn(path: String, cell: Vector2):
	var entity = RL.database.create_entity(path)
	entity.cell = cell
	map.add_entity(entity)
	# Cannot check for type 'Actor' with 'entity is Actor', because of cylcic reference
	# see: https://github.com/godotengine/godot/issues/21461#issuecomment-578860188
	if entity.has_method("take_turn"):
		actors.add(entity)
	return entity

func move(actor, cell: Vector2) -> void:
	actor.cell = cell
	actor.position = map.map_to_world(cell)

func main_loop() -> void:
	var actor
	var command
	var command_result
	while true:
		if !command_result or command_result.result_type != command_result.ResultType.Wait:
			actor = actors.next()
			if actor == null:
				break
		
		actor.call_deferred("take_turn", self)
		command = yield(actor, RL.SIGNAL_ACTED)
		command.call_deferred("execute", self)
		command_result = yield(command, RL.SIGNAL_EXECUTED)
		if command_result.result_type != command_result.ResultType.Success and command_result.message != "":
			print(command_result.message)
