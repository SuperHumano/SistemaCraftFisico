extends StaticBody3D

# Objetos mostraveis
@onready var iron_sword: Node3D = $IronSword
@onready var diamond_sword: Node3D = $DiamondSword

var products: Array[Node3D]
var curr_class: GDScript

var objects_quantity: int
var i : int = 0

func _ready() -> void:
	# Define Relativos
	products = [iron_sword, diamond_sword]
	# Prepara visibilidade dos produtos
	_set_settings()
	# Define a classe do momento
	curr_class = products[i].obj_class
	# Define a quantidade de elementos
	objects_quantity = len(products)
	

func interact() -> void:
	# Muda o quadro visível
	products[i].visible = false
	i += 1
	i = i % objects_quantity
	products[i].visible = true
	# Define a classe do momento
	curr_class = products[i].obj_class

func _set_settings() -> void:
	for product in products:
		for child in product.get_children():
			child.transparency = 0.6
			child.cast_shadow = false
