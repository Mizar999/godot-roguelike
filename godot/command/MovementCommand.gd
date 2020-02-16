extends Command
class_name MovementCommand

var _actor
var _dir

func _init(actor: Actor, dir: Vector2):
	_actor = actor
	_dir = dir

func execute(game: Game):
	print(_dir) # TODO move the actor
	success()
