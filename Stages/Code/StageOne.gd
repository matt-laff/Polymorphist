extends Node

var dialogBox_ps: PackedScene = preload("res://UI/DialogBox/Code/DialogBox.tscn")
var myDialogText = []

var introDialogText = [
	"Welcome to Polymorph! (working title)",
	"Along the way, you'll find potions that, when combined with the right items...",
	"... Will grant you the ability to change form. Use the forms to find a way out of this strange place...",
	"...And hopefully, you'll be able to find out who you are along the way...",
	"Have fun!"
]

var cutsceneText = [
	".... What happened?",
	"It just suddenly went dark...",
	"Who am I?",
	"... I can't remember..."	
]
var playerDialog = [
		"Wait... ",
		"WHAT HAPPENED TO MY BODY??",
		"-------------------------",
		"TODO: Add \"waking up \" animation after opening, add more to map level, add form-based combat?"
]


func _ready():
	$AnimatedBackground.show()
	$AnimatedBackground/AnimationPlayer.play("BackgroundBlur")
	myDialogText = cutsceneText
	spawnDialog()
	
	
func spawnDialog():
	var myDialog = dialogBox_ps.instance()
	self.add_child(myDialog)
	myDialog.set_position($notificationPosition.position)
	myDialog.setDialog(myDialogText)
	myDialog.connect("dialogFinished", self, "_on_DialogBox_dialogFinished")
	if myDialogText == introDialogText:
		myDialog.set_global_position($notificationPosition.position)

func _on_DialogBox_dialogFinished():
	if myDialogText == cutsceneText:
		$AnimatedBackground.hide()
		$AnimatedBackground/AnimationPlayer.stop()
		$Fade.fadeIn()
	elif myDialogText == playerDialog:
		myDialogText = introDialogText
		$AnimatedBackground.show()
		$AnimatedBackground/AnimationPlayer.play("BackgroundBlur")
		$AnimatedBackground.modulate.a = .5
		spawnDialog()
	else:
		$AnimatedBackground.hide()
		$AnimatedBackground/AnimationPlayer.stop()



func _on_Fade_fadeFinished():
	$Fade.queue_free()
	myDialogText = playerDialog
	spawnDialog()
