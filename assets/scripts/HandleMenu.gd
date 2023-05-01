extends Control
class_name HandleMenu
var _gameManager: GameManager

func _ready() -> void:
	_gameManager = get_node("/root/GameManager")
	DisplayCredit(_gameManager.MustShowCreditsFirst)

var _isOnDeliver:bool = true

var _isShowingCredits:bool = false

@export
var LabelDeliver:Label

@export
var LabelCredits:Label

@export
var CreditsTexture:TextureRect

@export
var PaperSound:AudioStreamPlayer2D

@export
var Fader:ColorRect

var _isLeaving:bool = false

func FadeOut() -> void:
	var duration:float = 2.0
	var stepspersec:float = 30.0
	var steptime:float = 1.0 / stepspersec
	var time:float = 0.0
	Fader.color = Color(0, 0, 0, 0)
	while time < duration:
		await get_tree().create_timer(steptime).timeout
		Fader.color = Color(0, 0, 0, time / duration)
		time += steptime
	Fader.color = Color(0, 0, 0, 1)
	await get_tree().create_timer(1).timeout
	StartGame()

func StartGame() -> void:
	_gameManager.NewGame()
	_gameManager.LandingOn(_gameManager.PlanetPosition)

func _process(delta) -> void:
	if _isLeaving:
		return 
	if _isShowingCredits:
		if Input.is_action_just_released("echap"):
			DisplayCredit(false)
	else:
		if Input.is_action_just_released("forward") || Input.is_action_just_released("backward"):
			_isOnDeliver = !_isOnDeliver
		if _isOnDeliver:
			LabelDeliver.text = "X"
			LabelCredits.text = ""
		else:
			LabelDeliver.text = ""
			LabelCredits.text = "X"
		if Input.is_action_just_released("enter"):
			if _isOnDeliver:
				_isLeaving = true
				FadeOut()
			else:
				DisplayCredit(true)

func DisplayCredit(display) -> void:
	if display:
		PaperSound.play()
	CreditsTexture.visible = display
	_isShowingCredits = display

