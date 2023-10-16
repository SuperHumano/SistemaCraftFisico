extends StaticBody3D

# Objetos mostraveis
@onready var iron_sword: Node3D = $IronSword
@onready var diamond_sword: Node3D = $DiamondSword

var relatives: Array[Node3D]
var curr_class: GDScript

var objects_quantity: int
var i : int = 0

func _ready() -> void:
	# Define Relativos
	relatives = [iron_sword, diamond_sword]
	# Prepara visibilidade dos produtos
	_set_settings()
	# Define a classe do momento
	curr_class = relatives[i].obj_class
	# Define a quantidade de elementos
	objects_quantity = len(relatives)
	

func interact():
	# Muda o quadro visível
	relatives[i].visible = false
	i += 1
	i = i % objects_quantity
	relatives[i].visible = true
	# Define a classe do momento
	curr_class = relatives[i].obj_class

func _set_settings() -> void:
	for product in relatives:
		for child in product.get_children():
			child.transparency = 0.6
			child.cast_shadow = false
