extends TransformableItem



func _ready():
	itemName = "Feather"
	interactionText = "Pick Up"
	formChange = "Chicken"
	
	skeletonDialogText = [
		"It's a feather, how strange",
		"I wonder what kind of bird it came from"
	]
	
	dogDialogText = [
		"*sniff* Wait... this is a chicken feather!",
		"Wouldn't want to accidentally give myself a chicken body"
	]
	
	chickenDialogText = [
		"If there's another chicken around here, I'll challenge him.",
		"...There can be only one."
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
