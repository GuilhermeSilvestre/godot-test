extends RigidBody3D

var force_strength = 20.0

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
