extends Actor
class_name Player

signal acted

var _input_dirs = {
	"n": Vector2(0, -1),
	"ne": Vector2(1, -1),
	"e": Vector2(1, 0),
	"se": Vector2(1, 1),
	"s": Vector2(0, 1),
	"sw": Vector2(-1, 1),
	"w": Vector2(-1, 0),
	"nw": Vector2(-1, -1)
}

func _ready():
	set_process_unhandled_key_input(false)

func take_turn(_game: Game):
	set_process_unhandled_key_input(true)

func _unhandled_key_input(event):
	for dir in _input_dirs:
		if event.is_action_pressed(dir):
			get_tree().set_input_as_handled()
			set_process_unhandled_key_input(false)
			emit_signal("acted", MovementCommand.new(self, _input_dirs[dir]))
			return
