extends TileMap

func add_entity(entity) -> void:
	add_child(entity)
	entity.position = map_to_world(entity.cell)

func is_floor_passable(cell: Vector2) -> bool:
	return true # TODO implement me

func get_entity_at(cell: Vector2):
	for child in get_children():
		if child.cell == cell:
			return child
	return null
