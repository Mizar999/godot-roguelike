extends Entity
class_name Actor

#warning-ignore:unused_argument
func take_turn(game: Game):
	emit_signal(RL.SIGNAL_ACTED, Command.new())
