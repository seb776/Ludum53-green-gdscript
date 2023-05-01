extends Node
var STRING_NULL:String = "[[STRING_NULL]]"

var _missionName:String

var _missionReward:int

var _missionPlanetTarget:int

var cash: int

var PlanetPosition: int

var IsDeath: bool

var PlanetNames:PackedStringArray = ["Fecaloria", "Odorix", "Etronis", "Porcelainus"]

var WinCash:int = 300

var MustShowCreditsFirst:bool

var lastMissionLabel: String = "A mysterious package... damaged and without indication"

var lastMissionReward: int = 10000

var lastMissionKey: String = "E"

var lastMissionPlanet: int = 3

var _planetScene:String = "res://scenes/game/PlanetScene.tscn"

var _spaceScene:String = "res://scenes/game/SpaceScene.tscn"

var _menuScene:String = "res://scenes/game/menu.tscn"

var _startCash:int = 0

func _ready() -> void:
	self.NewGame()

func NewGame() -> void:
	self.cash = _startCash
	self.PlanetPosition = 0
	self.MustShowCreditsFirst = false
	self.IsDeath = false
	self.ClearMission()

func TimeForTheLastTravel() -> bool:
	return WinCash <= cash

func LoadScene(scenePath) -> void:
	get_tree().change_scene_to_file(scenePath)

func CanLandOnPlanet(i) -> bool:
	var isFinalPlanet:bool = i == lastMissionPlanet
	return ((!IsFinalMission() && !isFinalPlanet) || (IsFinalMission() && isFinalPlanet))

func LoadMenu() -> void:
	LoadScene(_menuScene)

func LoadMission(mission) -> void:
	_missionName = mission.name
	_missionPlanetTarget = mission.planetTarget
	_missionReward = mission.reward

func LandingOn(planetId) -> void:
	self.PlanetPosition = planetId
	self.LoadScene(_planetScene)

func GoInSpace() -> void:
	LoadScene(_spaceScene)

func Pay(cost) -> void:
	self.cash -= cost

func MissionInProgress() -> bool:
	return _missionName != STRING_NULL

func MissionReward() -> int:
	return _missionReward

func MissionPlanetTarget() -> int:
	return _missionPlanetTarget

func MissionSucces() -> void:
	if MissionInProgress():
		if IsFinalMission():
			MustShowCreditsFirst = true
			LoadMenu()
		else:
			self.cash += _missionReward
			ClearMission()

func IsFinalMission() -> bool:
	return _missionPlanetTarget == lastMissionPlanet

func ClearMission() -> void:
	_missionName = STRING_NULL

