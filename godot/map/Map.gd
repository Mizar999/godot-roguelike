extends TileMap

func add_entity(entity) -> void:
	add_child(entity)
	entity.position = map_to_world(entity.cell)
