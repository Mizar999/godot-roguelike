extends Node

onready var map = $Map
var game

func _ready():
	game = Game.new(map)
	game.main_loop()

func _unhandled_key_input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()
