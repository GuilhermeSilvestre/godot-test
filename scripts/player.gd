extends RigidBody3D

@export var force_strength = 16.0
@export var bullet_scene : PackedScene  # Referência para a cena do projétil
@export var bullet_speed = 60.0  # Velocidade do projétil

func _ready():
	# Verifica se bullet_scene está corretamente atribuído
	if not bullet_scene:
		print("Bullet scene not assigned!")

func _physics_process(delta):
	var force = Vector3()

	if Input.is_action_pressed("ui_right"):
		force.x += force_strength
	if Input.is_action_pressed("ui_left"):
		force.x -= force_strength
	if Input.is_action_pressed("ui_up"):
		force.z -= force_strength
	if Input.is_action_pressed("ui_down"):
		force.z += force_strength

	if force != Vector3():
		apply_central_force(force)

	# Disparar projéteis
	if Input.is_action_just_pressed("shoot"):  # Use is_action_just_pressed para detectar um clique
		shoot_bullet()

func shoot_bullet():
	if bullet_scene:
		var bullet = bullet_scene.instantiate()  # Instanciar o projétil
		get_tree().root.add_child(bullet)  # Adicionar o projétil à cena
		bullet.transform.origin = transform.origin  # Posicionar o projétil na posição do personagem
		
		# Ajustar a direção e aplicar a força ao projétil
		var direction = transform.basis.z.normalized()  # Assumindo que o eixo z é a direção para frente
		bullet.apply_impulse(direction * bullet_speed)
	else:
		print("Bullet scene is not assigned!")
