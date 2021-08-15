extends Sprite

func _ready():
	self.hide()

func explode():
		self.z_index = 1
		self.pause_mode = Node.PAUSE_MODE_PROCESS
		$AnimationPlayer.pause_mode = Node.PAUSE_MODE_PROCESS
		get_tree().paused = true
		self.show()
		$AnimationPlayer.play("poof")


		


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "poof":
		self.hide()
		get_tree().paused = false
		self.pause_mode = Node.PAUSE_MODE_STOP
