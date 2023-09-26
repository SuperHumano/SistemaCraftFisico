extends StaticBody3D

# Objetos mostraveis
@export var obj_class_maneger: ObjectClassManeger
@onready var iron_sword: Node3D = $IronSword
@onready var diamond_sword: Node3D = $DiamondSword

# Propriedades ativa/desativa visibilidade
var objects: Array[Node3D]
var objects_quantity: int
var i : int = 0

func _ready() -> void:
	objects = [iron_sword, diamond_sword]
	objects_quantity = len(objects)
	
func interact():
	objects[i].visible = false
	i += 1
	i = i % objects_quantity
	obj_class_maneger.i = i
	objects[i].visible = true
	
