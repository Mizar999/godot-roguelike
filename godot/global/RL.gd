extends Node

# see Project -> Project Settings -> Autoload

onready var database = preload("res://data/Database.tscn").instance()

const PASSABLE_TILES = [
	"floor"
]

const DIRECTIONS = {
	"n": Vector2(0, -1),
	"ne": Vector2(1, -1),
	"e": Vector2(1, 0),
	"se": Vector2(1, 1),
	"s": Vector2(0, 1),
	"sw": Vector2(-1, 1),
	"w": Vector2(-1, 0),
	"nw": Vector2(-1, -1)
}

const ACTION_QUIT = "quit"
const ACTION_WAIT = "wait"

const GROUP_ENTITY = "entity"
const GROUP_BLOCKER = "blocker"

const SIGNAL_ACTED = "acted"
const SIGNAL_EXECUTED = "executed"
const SIGNAL_MAP_CHANGED = "map_changed"
