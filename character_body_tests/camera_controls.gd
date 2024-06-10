extends SpringArm3D

const LOOK_SENSITIVITY := 0.001

var offset: Vector3
var look_input: Vector2

@export var distance := 5.0

func _ready():
	offset = position
	spring_length = distance
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(delta):
	position = get_parent().position + offset
	rotation.y = look_input.y
	rotation.x = look_input.x
	
	spring_length = lerp(spring_length, distance, delta * 1.0)
	

func _input(event):
	if event is InputEventMouseMotion:
		look_input.y = wrapf(look_input.y - event.relative.x * LOOK_SENSITIVITY, 0.0, TAU)
		look_input.x = clampf(look_input.x - event.relative.y * LOOK_SENSITIVITY, -1.5, 1.0)
