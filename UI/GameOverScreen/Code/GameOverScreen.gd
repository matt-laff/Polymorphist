extends Node2D

var dialogBox_ps: PackedScene = preload("res://UI/DialogBox/Code/DialogBox.tscn")

var gameOverText = [
	"Oooh that sucks, no choice but to try again, right?",
	"There will be a reset button eventually"
]


func _ready():
	var myDialog = dialogBox_ps.instance()
	self.add_child(myDialog)
	myDialog.setDialog(gameOverText)
	myDialog.connect("dialogFinished", self, "_on_DialogBox_dialogFinished")
	myDialog.set_global_position(self.position - Vector2(-250, -250))
	$AnimationPlayer.play("GameOver")
	
func _on_DialogBox_dialogFinished():
	get_tree().quit()
