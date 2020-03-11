extends Actor
class_name Enemy

# TODO implement ai
func take_turn(game: Game):
	var command = Command.new()
	if game.player:
		var path = game.pathfinder.get_path(cell, game.player.cell)
		print("%s -> %s = '%s'" % [cell, game.player.cell, path])
		if path.size() > 2:
			var dir = path[1] - cell # index 0 is the actor itself
			command = MovementCommand.new(self, dir)
	emit_signal(RL.SIGNAL_ACTED, command)
