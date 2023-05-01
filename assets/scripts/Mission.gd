extends MarginContainer
class_name Mission
var MissionLabel:String

var MissionKey:String

var reward: int

var planetTarget: int

@export
var labelMission:Label

@export
var labelCash:Label

@export
var key:Label

@export
var DisableComponent:ColorRect

func setNewMission(missionLabel, missionKey, reward, planetTarget) -> void:
	self.MissionLabel = missionLabel
	self.MissionKey = missionKey
	self.reward = reward
	self.planetTarget = planetTarget
	self.labelMission.text = missionLabel
	self.key.text = missionKey
	self.labelCash.text = "reward: " + str(reward)

func setDisable(disable) -> void:
	DisableComponent.visible = !disable

