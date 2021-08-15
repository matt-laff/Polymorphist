extends StaticBody2D

class_name InteractableItem
var itemName: String = "defaultItemName"
var dialogBox_ps: PackedScene = preload("res://UI/DialogBox/Code/DialogBox.tscn")

var dialogText = [
	"default text"
]

var skeletonDialogText = [
	"I can't do anything with this yet"
]
var dogDialogText = [
	"The dog can't do anything with this yet"
]

var chickenDialogText = [
	"Your chicken brain can't comprehend this"
]
var interactionText: String = "default"


func interactAvailable(interactorParent: Node) -> bool:
	return interactorParent is Player # if interactionBox's parent is Player, return true

func setInteractionText():
	return interactionText

func spawnDialog():
	var myDialog = dialogBox_ps.instance()
	self.add_child(myDialog)
	myDialog.setDialog(dialogText)
	myDialog.connect("dialogFinished", self, "_on_DialogBox_dialogFinished")
	myDialog.set_global_position(self.global_position)


	
func setDialogText(formName):
	match formName:
		"Chicken":
			dialogText = chickenDialogText
		"Dog":
			dialogText = dogDialogText
		"Skeleton":
			print("form name: " + formName)
			dialogText = skeletonDialogText

func getDialog(interactorParent):
	match interactorParent.currentForm:
		"Skeleton":
			return skeletonDialogText
		"Dog":
			return dogDialogText
		"Chicken":
			return chickenDialogText
		_:
			var noDialog = [
				"I don't have dialog for you yet"
			]
			return noDialog
