extends StaticBody3D

@onready var particles: GPUParticles3D = $SpawnPoint/GPUParticles3D
@onready var audio: AudioStreamPlayer3D = $SpawnPoint/AudioStreamPlayer3D
@onready var wall_frame: StaticBody3D = $WallFrame

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
	
	obj_class = wall_frame.curr_class.new()
	
	if obj_class.has_requirements(curr_objects):
		obj_class.queue_requirements(curr_objects)
		var instance: RigidBody3D = obj_class.instantiate_object(spawn_point)
		particles.emitting = true
		audio.play()
		world.add_child(instance)
