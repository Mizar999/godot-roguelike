extends Node

export (String, MULTILINE) var entity_name = "None"
export (bool) var blocks_movement = false

var cell = Vector2()

func setup():
	add_to_group("entity")
	if blocks_movement:
		add_to_group("blocker")
	
	for node in get_children():
		if node.has_method("setup"):
			node.setup()

func describe() -> String:
	return entity_name
