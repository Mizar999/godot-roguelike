extends Actor
class_name Enemy

# TODO implement ai
func take_turn(game: Game):
	var command = Command.new()
	if game.player:
		var path = game.pathfinder.find_path(cell, game.player.cell)
		if path.size() > 1:
			var dir = path[1] - cell # index 0 is the actor itself
			command = MovementCommand.new(self, dir)
	emit_signal(RL.SIGNAL_ACTED, command)
