extends Node
class_name Entity

export (String, MULTILINE) var entity_name = "None"
export (bool) var blocks_movement = false

var cell = Vector2()

func _ready():
	add_to_group("entity")
	if blocks_movement:
		add_to_group("blocker")

func describe() -> String:
	return entity_name
