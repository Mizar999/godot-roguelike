extends Actor
class_name Player

func _ready():
	set_process_unhandled_key_input(false)

#warning-ignore:unused_argument
func take_turn(game: Game):
	set_process_unhandled_key_input(true)

func _unhandled_key_input(event):
	var command = null
	if event.is_action_pressed(RL.ACTION_WAIT):
		command = Command.new()
	else:
		for dir in RL.DIRECTIONS:
			if event.is_action_pressed(dir):
				command = MovementCommand.new(self, RL.DIRECTIONS[dir])
				break
	
	if command != null:
		get_tree().set_input_as_handled()
		set_process_unhandled_key_input(false)
		emit_signal(RL.SIGNAL_ACTED, command)
