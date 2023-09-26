class_name IronSword 

var sword = preload("res://Cenas/Objetos&Ambiente/Objetos/Produtos/iron_sword.tscn")

func has_requirements(curr_materials: Dictionary) -> bool:
	return len(curr_materials.Ferro) > 1 and len(curr_materials.Pau) > 0

func queue_requirements(curr_materials: Dictionary) -> void:
	for i in range(0,2):
		curr_materials.Ferro[i].queue_free()
	curr_materials.Pau[0].queue_free()

func instantiate_object(spawn_local: Vector3) -> RigidBody3D:
	var sword_instance = sword.instantiate()
	sword_instance.position = spawn_local
	return sword_instance
