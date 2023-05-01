extends Node2D
@export
var PlanetsContainer:Node

@export
var PlanetLabelName:Label

func _ready() -> void:
	var gm:GameManager = get_node("/root/GameManager")
	var planets = PlanetsContainer.get_children()
	var thePlanet:int = gm.PlanetPosition
	for planet in planets:
		var p:GroundPlanet = planet as GroundPlanet
		if p != null && p.PlanetId != gm.PlanetPosition:
			PlanetsContainer.remove_child(planet)
	if PlanetLabelName != null:
		PlanetLabelName.text = gm.PlanetNames[thePlanet]

