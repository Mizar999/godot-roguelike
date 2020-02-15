extends Node

onready var map = $Map

func _ready():
	var entity = RL.database.create_entity("props/statue")
	entity.cell = Vector2(2, 3)
	map.add_entity(entity)
