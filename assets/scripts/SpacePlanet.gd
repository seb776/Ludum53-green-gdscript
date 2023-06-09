extends Node2D
class_name SpacePlanet
@export
var PlanetId:int

@export
var PlanetTexture:Texture2D

@export
var PlanetNameLabel:Label

@export
var LandingLabel:Label

@export
var ColorA:Color

@export
var ColorB:Color

@export
var planet:PlanetPrefab

@export
var ExitShipPosition:Node2D

var _gameManager:GameManager

func _ready() -> void:
	_gameManager = get_node("/root/GameManager")
	LandingLabel.visible = false
	planet.ColorA = ColorA
	planet.ColorB = ColorB
	if PlanetNameLabel != null:
		PlanetNameLabel.text = "[" + _gameManager.PlanetNames[PlanetId] + "]"

func _process(delta) -> void:
	if Input.is_action_just_released("mission_one") && LandingLabel.visible:
		_gameManager.LandingOn(PlanetId)

func isFinalPlanet() -> bool:
	return _gameManager.lastMissionPlanet == PlanetId

func SetLandingLabel(visible_, node) -> void:
	var c:CharacterBody2D = node as CharacterBody2D
	if c != null && _gameManager.CanLandOnPlanet(PlanetId):
		LandingLabel.visible = visible_

func OnBodyEntered(body) -> void:
	self.SetLandingLabel(true, body)

func OnBodyExited(body) -> void:
	self.SetLandingLabel(false, body)

