extends Node

func create_entity(path):
	var entity = get_node(path)
	if entity:
		return entity.duplicate()
	print("Entity doesn't exist at path '%s'." % path)
