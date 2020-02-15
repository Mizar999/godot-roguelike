extends Node

onready var map = $Map
var game

func _ready():
	game = Game.new(map)
