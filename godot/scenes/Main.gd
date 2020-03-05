extends Node

onready var map = $Map
onready var debug_draw = $DebugDraw
var game

func _ready():
	randomize()
	game = Game.new(map, debug_draw)
	game.main_loop()

func _unhandled_key_input(event):
	if event.is_action_pressed(RL.ACTION_QUIT):
		get_tree().quit()
