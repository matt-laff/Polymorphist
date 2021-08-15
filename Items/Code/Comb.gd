extends TransformableItem



func _ready():
	itemName = "Comb"
	interactionText = "Pick Up"
	formChange = "Dog"
	
	skeletonDialogText = [
		"A comb of some kind?",
		"There's a tuft of fur stuck in it"
	]
	
	dogDialogText = [
		"There's a faint smell of shampoo",
		"This comb's owner clearly loved their pet"
	]
	
	chickenDialogText = [
		"Pointy"
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
