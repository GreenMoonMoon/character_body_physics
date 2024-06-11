extends CharacterBody3D

const JUMP_VELOCITY = 8.5
const ORIENT_SPEED = 5.0
const GRAVITY_MOD := 2.0

var speed: float = 10.0
@onready var arm: SpringArm3D = $SpringArm3D

func _process(delta):
	if Input.is_action_just_pressed("inc_speed"):
		speed += 1.0
	if Input.is_action_just_pressed("dec_speed"):
		speed -= 1.0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * GRAVITY_MOD * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("left", "right", "forward", "backward").rotated(-arm.rotation.y)
	var direction = Vector3(input_dir.x, 0, input_dir.y).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		
		rotation.y = lerp_angle(rotation.y, atan2(velocity.x,velocity.z), delta * ORIENT_SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
