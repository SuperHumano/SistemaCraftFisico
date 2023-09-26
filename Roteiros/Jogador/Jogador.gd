extends CharacterBody3D

@onready var neck: Node3D = $Neck
@onready var camera: Camera3D = $Neck/Camera3D
@onready var ray: RayCast3D = $Neck/Camera3D/RayCast3D
@onready var obj_target: Marker3D = $Neck/Camera3D/Marker3D

# Define velocidades
const SPEED: float = 5
const JUMP_VELOCITY: float = 4.5

# Define o alcance de interações
const RANGE: float = 2.0

# Definie a gravidade
var gravity: float = 9.8

# Variavel do objeto
var object_picked : RigidBody3D = null

func _ready() -> void:
	# Prende o cursor do mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	# Movimenta a camera
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y( -event.relative.x * 0.003)
			camera.rotate_x( -event.relative.y * 0.003)
			camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
	
	# Liberta o cursor do mouse
	if Input.is_action_just_pressed("sair"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# Ativa a função interagir
	if Input.is_action_just_pressed("interagir"):
		_interact()
	
func _physics_process(delta: float) -> void:
	# Aplica a gravidade
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Aplica o pulo
	if Input.is_action_just_pressed("pular") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Aplica a direção
	var input_dir := Input.get_vector("esquerda", "direita", "frente", "tras")
	var direction := (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Aplica a velocidade
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	# Aplica a parada
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	# Aplica um Vector3 na direção obj_target
	if object_picked:
		object_picked.set_linear_velocity((obj_target.global_position - object_picked.global_position)*10.0)

	move_and_slide()
 
# Ação pega, solta, ou caso seja um interagível, interage
func _interact():
	if object_picked == null:
		if ray.is_colliding():
			if ray.global_position.distance_to(ray.get_collision_point()) < RANGE:
				var collider = ray.get_collider()
				# Pega o objeto
				if collider.is_in_group("objeto"):
					# Desacelerando movimentos angulares
					collider.angular_damp = 3.0
					collider.set_collision_layer_value(1,false)
					# Resolução do pulinho
					await get_tree().create_timer(0.1).timeout
					object_picked = collider
				# Ativa a função interact em objetos interagíveis
				elif collider.is_in_group("interagivel"):
					collider.interact()
	else:
		object_picked.set_collision_layer_value(1,true)
		object_picked.angular_damp = 0
		# Aplica movimento ao objeto para que o mesmo seja percebido pela Area3D
		object_picked.set_linear_velocity(Vector3.UP * 2)
		object_picked = null
