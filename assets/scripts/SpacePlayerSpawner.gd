extends Node2D
class_name SpacePlayerSpawner
@export
var Player:CharacterBody2D

@export
var PlanetContainter:Node

var _gm:GameManager

func _ready() -> void:
	_gm = get_node("/root/GameManager")
	for planet in PlanetContainter.get_children():
		var p:SpacePlanet = planet as SpacePlanet
		if p != null && p.PlanetId == _gm.PlanetPosition:
			Player.global_position = p.ExitShipPosition.global_position
			break

