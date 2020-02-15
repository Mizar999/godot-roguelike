extends TileMap

func _ready():
	var entity = RL.database.create_entity("props/statue")
	entity.cell = Vector2(2, 3)
	add_entity(entity)

func add_entity(entity):
	add_child(entity)
	entity.position = map_to_world(entity.cell)
