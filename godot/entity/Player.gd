extends Actor
class_name Player

#warning-ignore:unused_signal
signal acted

func _ready():
	set_process_unhandled_key_input(false)

#warning-ignore:unused_argument
func take_turn(game: Game):
	set_process_unhandled_key_input(true)

func _unhandled_key_input(event):
	for dir in RL.DIRECTIONS:
		if event.is_action_pressed(dir):
			get_tree().set_input_as_handled()
			set_process_unhandled_key_input(false)
			emit_signal(RL.SIGNAL_ACTED, MovementCommand.new(self, RL.DIRECTIONS[dir]))
			return
