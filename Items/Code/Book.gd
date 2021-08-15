extends PickableItem



func _ready():
	self.itemName = "Book"
	self.interactionText = "Read"

	
	self.skeletonDialogText = [
		"This book needs some words",
		"Something like, \"To my dear friend...\"",
		"\"I'm sorry you feel you've lost them, but I am not the one who took them.\""
	]
	
	self.dogDialogText = [
		"You chew through a few of the pages",
		"Written on the edge of a page, you see a small handwritten passage",
		" \"To my dear friend...\"",
		"\"I'm sorry you feel you've lost them, it was not my choice to make.\""
	]
	
	self.chickenDialogText = [
		"A chicken has no need for puny words",
		"You shred the book to pieces with your mighty beak"
	]

	
func onInteraction(interactorParent):
	self.dialogText = getDialog(interactorParent)
	if interactorParent.currentForm == "Chicken":
		self.hide()
	elif interactorParent.addItemToInventory(itemName) == true:
		pickedUp = true
	
	spawnDialog()

func _on_DialogBox_dialogFinished():
	if pickedUp == true:
		self.queue_free()
	elif self.visible == false:
		self.queue_free()
