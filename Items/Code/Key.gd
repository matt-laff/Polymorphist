extends PickableItem


func _ready():
	itemName = "Key"
	interactionText = "Key"
	
	skeletonDialogText = [
		"Oh a key, this should be useful."
	]
	
	dogDialogText = [
		"Shiny!",
	]
	
	chickenDialogText = [
		"*caw* It's a key.",
	]


func onInteraction(interactorParent):
	dialogText = getDialog(interactorParent)
	if interactorParent.addItemToInventory(itemName) == true:
		pickedUp = true
	else:
		inventoryFull()
	
	spawnDialog()


func _on_DialogBox_dialogFinished():
	if pickedUp == true:
		self.queue_free()

