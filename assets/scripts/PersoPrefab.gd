extends CharacterBody2D
class_name PersoPrefab
var moveSpeed:float = 200

@export
var gravity:float = 50

@export
var CharacterBody:CharacterBody2D

@export
var AnimatedSprite:AnimatedSprite2D

func _ready() -> void:
	pass

func _physics_process(delta) -> void:
	var move:Vector2 = Vector2(0, gravity)
	if Input.is_action_pressed("right"):
		AnimatedSprite.scale = Vector2(1, 1)
		move.x = self.moveSpeed
	if Input.is_action_pressed("left"):
		AnimatedSprite.scale = Vector2(-1, 1)
		move.x = -self.moveSpeed
	if move.x > 0.1 || move.x < -0.1:
		AnimatedSprite.play("Walk")
	else:
		AnimatedSprite.play("Idle")
	CharacterBody.velocity = move
	CharacterBody.move_and_slide()

