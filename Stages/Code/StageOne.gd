extends Node

var dialogBox_ps: PackedScene = preload("res://UI/DialogBox/Code/DialogBox.tscn")
var myDialogText = []

var introDialogText = [
	"Welcome to [insert game name here]",
	"You've been equipped with potions that will change you into different forms",
	"Use the forms to find a way out of this strange place",
	"And hopefully, you'll be able to find out who you are along the way..."
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
		"TODO: inventory form change, tile map, \"waking up\" animation for cutscene",
		"Also add scene changes if possible"
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
		$AnimatedBackground.modulate.a = .5
		spawnDialog()
	else:
		$AnimatedBackground.hide()



func _on_Fade_fadeFinished():
	$Fade.queue_free()
	myDialogText = playerDialog
	spawnDialog()
