extends CharacterBody2D
class_name Player
@export
var moveSpeed:float = 200

@export
var gravity:float = 500

var GameManager: GameManager

func _ready() -> void:
	GameManager = get_node("/root/GameManager")

func _physics_process(delta) -> void:
	var move:Vector2 = Vector2.ZERO
	if Input.is_action_pressed("right"):
		move.x = self.moveSpeed
	if Input.is_action_pressed("left"):
		move.x = -self.moveSpeed
	move.y += gravity
	self.velocity = move
	self.move_and_slide()

