extends Command
class_name MovementCommand

var _actor
var _dir

func _init(actor: Actor, dir: Vector2):
	_actor = actor
	_dir = dir

func execute(game: Game):
	var map = game.map
	var new_cell = _actor.cell + _dir
	if !map.is_floor_passable(new_cell):
		return wait("'%s' cannot move to '%s'" % [_actor.describe(), _dir])
	
	var entity = map.get_entity_at(new_cell)
	if entity:
		if entity.is_in_group("blocker"):
			return fail("'%s' bumps into '%s'" % [_actor.describe(), entity.describe()])
	
	game.move(_actor, new_cell)
	success()
