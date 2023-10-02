extends StaticBody3D

# Objetos mostraveis
@onready var iron_sword: Node3D = $IronSword
@onready var diamond_sword: Node3D = $DiamondSword

var relatives: Array[Array]
var curr_class: GDScript

var objects_quantity: int
var i : int = 0

func _ready() -> void:
	# Define Relativos
	relatives = [[iron_sword, IronSword], [diamond_sword, DiamondSword]]
	# Define a classe do momento
	curr_class = relatives[i][1]
	# Define a quantidade de elementos
	objects_quantity = len(relatives)
	

func interact():
	# Muda o quadro visível
	relatives[i][0].visible = false
	i += 1
	i = i % objects_quantity
	relatives[i][0].visible = true
	# Define a classe do momento
	curr_class = relatives[i][1]
