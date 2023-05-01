extends CharacterBody2D
class_name Spaceship
@export
var _acceleration:float = 10

@export
var _maxSpeed:float = 350

@export
var _rotationSpeed:float = 125

@export
var _breakFactor:float = 0.92

var _reactor:Sprite2D

var _gameManager:GameManager

@export
var PlanetContainer:Node2D

@export
var IndicatorContainer:Node2D

var IndicatorPrefabs:PackedScene

func _ready() -> void:
	_gameManager = get_node("/root/GameManager")
	_reactor = get_node("Reactor")
	IndicatorPrefabs = preload("res://assets/prefabs/indicator.tscn") as PackedScene
	RegenIndicator()

func RegenIndicator() -> void:
	for child in IndicatorContainer.get_children():
		IndicatorContainer.remove_child(child)
	for planet in PlanetContainer.get_children():
		var p:SpacePlanet = planet as SpacePlanet
		if p != null && _gameManager.CanLandOnPlanet(p.PlanetId):
			var indicatorComponent = IndicatorPrefabs.instantiate() as Indicator
			indicatorComponent.rocket = self
			indicatorComponent.planet = p
			IndicatorContainer.add_child(indicatorComponent)

func _physics_process(delta) -> void:
	if _gameManager.IsDeath:
		pass
	else:
		var input_vector:Vector2 = Vector2(0, -Input.get_action_strength("forward"))
		velocity += input_vector.rotated(rotation) * _acceleration
		velocity = velocity.limit_length(_maxSpeed)
		if input_vector.y < 0:
			_reactor.show()
		if Input.is_action_pressed("right"):
			rotate((deg_to_rad(_rotationSpeed * delta) as float))
		if Input.is_action_pressed("left"):
			rotate((deg_to_rad(-_rotationSpeed * delta) as float))
		if input_vector.y == 0:
			_reactor.hide()
			velocity = velocity.move_toward(Vector2.ZERO, 3)
		if Input.is_action_pressed("backward"):
			velocity *= _breakFactor
		move_and_slide()

