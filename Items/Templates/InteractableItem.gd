extends StaticBody2D

class_name InteractableItem
var itemName: String = "defaultItemName"
var dialogBox_ps: PackedScene = preload("res://UI/DialogBox/Code/DialogBox.tscn")

onready var screenSize = get_viewport_rect().size

var dialogText = [
	"default text"
]

var inventoryFullText = [
	"Your inventory is full, you can't pick up any more!",
	"Press [Middle Mouse Button] on an item in your inventory to delete it and make room"
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
	myDialog.rect_position.x = clamp(myDialog.rect_position.x, 0, screenSize.x -500)
	myDialog.rect_position.y = clamp(myDialog.rect_position.y, 0, screenSize.y)


	
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
			
func inventoryFull():
	dialogText = inventoryFullText
