extends Control


func _ready():
	$VBoxContainer/StartButton.grab_focus()

func _on_StartButton_pressed():
	$Fade.fadeOut()
	
 
func _on_OptionsButton_pressed():
	get_tree().quit()


func _on_ExitButton_pressed():
	get_tree().quit()


func _on_Fade_fadeFinished():
	get_tree().change_scene("res://Stages/Code/StageOne.tscn")
