extends PickableItem

class_name Potion

func _ready():
	itemName = "Potion"
	interactionText = "Pick Up"

	skeletonDialogText = [
		"Nice, a potion!"
	]
	
	dogDialogText = [
		"Smells like death..."
	]
	
	chickenDialogText = [
		"...",
		"You barely resist the urge to destroy the vial",
		"The chicken in you knows its time is near..."
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
