extends CharacterBody2D
class_name Spaceship
var _acceleration:float = 10

var _maxSpeed:float = 350

var _rotationSpeed:float = 100

var _gameManager:GameManager

func _ready() -> void:
	_gameManager = get_node("/root/GameManager")

func _physics_process(delta) -> void:
	if _gameManager.IsDeath:
		pass
	else:
		var input_vector:Vector2 = Vector2(0, Input.get_axis("forward", "backward"))
		velocity += input_vector.rotated(rotation) * _acceleration
		velocity = velocity.limit_length(_maxSpeed)
		if Input.is_action_pressed("right"):
			rotate((deg_to_rad(_rotationSpeed * delta) as float))
		if Input.is_action_pressed("left"):
			rotate((deg_to_rad(-_rotationSpeed * delta) as float))
		if input_vector.y == 0:
			velocity = velocity.move_toward(Vector2.ZERO, 3)
		move_and_slide()

