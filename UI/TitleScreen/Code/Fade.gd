extends ColorRect

signal fadeFinished

func fadeIn():
	$AnimationPlayer.play("FadeIn")
	
	
func fadeOut():
	$AnimationPlayer.play("FadeOut")

func _on_AnimationPlayer_animation_finished(_anim_name):
	emit_signal("fadeFinished")

