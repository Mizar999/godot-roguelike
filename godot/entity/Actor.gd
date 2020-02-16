extends Entity
class_name Actor

func take_turn(_game: Game):
	emit_signal("acted", Command.new())
