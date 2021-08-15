extends PickableItem


func _ready():
	itemName = "Key"
	interactionText = "Key"
	
	skeletonDialogText = [
		"This is skeleton text",
		"With a second box"
	]
	
	dogDialogText = [
		"Dog Dialog Text"
	]


	
func onInteraction(interactorParent):
	dialogText = getDialog(interactorParent)
	spawnDialog()
	if interactorParent.addItemToInventory(itemName) == true:
		pickedUp = true

func _on_DialogBox_dialogFinished():
	if pickedUp == true:
		self.queue_free()

