extends StaticBody3D

@export var obj_class_maneger: Resource
@onready var particles: GPUParticles3D = $SpawnPoint/GPUParticles3D
@onready var audio: AudioStreamPlayer3D = $SpawnPoint/AudioStreamPlayer3D

var spawn_point: Vector3
var world: Node
var obj_class

var curr_objects: Dictionary = {"Ferro":[], "Diamante":[], "Pau":[]}

func _ready() -> void:
	spawn_point = $SpawnPoint.global_position
	world = get_tree().current_scene
	
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("material"):
		curr_objects[body.material].append(body)
		

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("material"):
		curr_objects[body.material].erase(body)
		

func interact():
	if obj_class != obj_class_maneger.obj_classes[obj_class_maneger.i]:
		obj_class = obj_class_maneger.obj_classes[obj_class_maneger.i].new()
		
	if obj_class.has_requirements(curr_objects):
		obj_class.queue_requirements(curr_objects)
		var instance: RigidBody3D = obj_class.instantiate_object(spawn_point)
		particles.emitting = true
		audio.play()
		world.add_child(instance)
