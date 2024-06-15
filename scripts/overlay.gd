extends Control

@onready var pauseButton = $Pause
@onready var victoryScreen = $Victory_Screen
@onready var victoryAnim = $Victory_Screen/AnimationPlayer

var animPlaying
var is_paused

func _ready():
	var popup=pauseButton.get_popup()
	popup.id_pressed.connect(file_menu)
	victoryScreen.hide()
	Global.play_music_level()
	animPlaying = false

func _process(_delta):
	if Global.victory:
		victoryScreen.show()
		if not animPlaying:
			victoryAnim.play("blur")
			animPlaying = true
	else:
		victoryScreen.hide()

func _on_pause_toggled(_toggled_on):
	is_paused = get_tree().paused
	if is_paused:
		get_tree().paused=false
		$AnimationPlayer.play("RESET")
	elif not is_paused:
		$AnimationPlayer.play("BLUR")
		

func file_menu(id):
	if id==0:
		if is_paused:
			get_tree().paused=false
			$AnimationPlayer.play("RESET")
	if id==1:
		get_tree().change_scene_to_file("res://ui/Level_Select.tscn")
	

func _on_button_pressed():
	get_tree().change_scene_to_file("res://ui/Level_Select.tscn")

func _on_animation_player_animation_finished(anim_name):
	if anim_name=="BLUR":
		get_tree().paused=true
