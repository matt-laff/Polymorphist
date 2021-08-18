extends TransformableItem



func _ready():
	itemName = "Cheese"
	interactionText = "Pick Up"
	formChange = "Rat"
	
	skeletonDialogText = [
		"It's... cheese?"
	]
	
	dogDialogText = [
		"*sniif* This smells like a rat!"
	]
	
	chickenDialogText = [
		"A worthy offering for the great chicken"
	]

func onInteraction(interactorParent):
	dialogText = getDialog(interactorParent)
	if interactorParent.addItemToInventory(itemName) == true:
		pickedUp = true
	else:
		inventoryFull()
	
	spawnDialog()


func _on_DialogBox_dialogFinished():
	if self.pickedUp == true:
		self.queue_free()
