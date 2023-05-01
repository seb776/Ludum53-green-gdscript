extends Area2D
class_name Box
@export
var MissionSelection: Control

@export
var Rocket:LandscapeRocket

var _gameManager: GameManager

@export
var labels:PackedStringArray

@export
var rewards:PackedInt32Array

@export
var keys:PackedStringArray

@export
var _planetTarget:PackedInt32Array

var MissionPrefabs:PackedScene

func _ready() -> void:
	MissionPrefabs = (preload("res://assets/prefabs/Mission/Mission.tscn") as PackedScene)
	MissionSelection.visible = false
	_gameManager = get_node("/root/GameManager")
	if _gameManager.TimeForTheLastTravel():
		SetLastMission()
	else:
		var i:int = 0
		while i < labels.size():
			var missionComponent = MissionPrefabs.instantiate()
			MissionSelection.add_child(missionComponent)
			self.SetMission(labels[i], rewards[i], keys[i], _planetTarget[i], missionComponent)
			i += 1

func SetLastMission() -> void:
	for child in MissionSelection.get_children():
		MissionSelection.remove_child(child)
	var missionComponent = MissionPrefabs.instantiate()
	MissionSelection.add_child(missionComponent)
	self.SetMission(_gameManager.lastMissionLabel, _gameManager.lastMissionReward, _gameManager.lastMissionKey, _gameManager.lastMissionPlanet, missionComponent)

func SetMission(label, reward, key, planetTarget, node) -> void:
	var m:Mission = node as Mission
	if m != null:
		m.setNewMission(label, key, reward, planetTarget)

func _process(delta) -> void:
	if MissionSelection.visible:
		if Input.is_action_pressed("mission_one"):
			self.ChoiceDone(0)
		else:
			if Input.is_action_pressed("mission_two"):
				self.ChoiceDone(1)
			else:
				if Input.is_action_pressed("mission_three"):
					self.ChoiceDone(2)

func StartMission(i) -> void:
	var m:Mission = self.MissionSelection.get_children()[i] as Mission
	if m != null:
		_gameManager.LoadMission(m)

func GetMission(i) -> Mission:
	return MissionSelection.get_children()[i] as Mission

func MissionIsPossible(i) -> bool:
	if i >= MissionSelection.get_children().size():
		return false
	var m:Mission = GetMission(i)
	if m != null:
		return m.planetTarget == _gameManager.PlanetPosition || _gameManager.cash >= Rocket.GoingSpaceCost
	return false

func ChoiceDone(choice) -> void:
	if MissionIsPossible(choice):
		MissionSelection.visible = false
		self.StartMission(choice)

func RefreshPossibleMission() -> void:
	var missions = MissionSelection.get_children()
	var i:int = 0
	while i < missions.size():
		var m:Mission = missions[i] as Mission
		if m != null:
			m.setDisable(MissionIsPossible(i))
		i += 1

func SetMissionSelectVisible(visible_, body) -> void:
	var p:CharacterBody2D = body as CharacterBody2D
	if p != null && !_gameManager.MissionInProgress():
		MissionSelection.visible = visible_

func OnBodyEntered(body) -> void:
	self.SetMissionSelectVisible(true, body)
	if _gameManager.TimeForTheLastTravel():
		SetLastMission()
	RefreshPossibleMission()

func OnBodyExited(body) -> void:
	self.SetMissionSelectVisible(false, body)

