extends PickableItem

class_name Potion
var itemDescription = "This is a potion"

func _ready():
	itemName = "Potion"
	itemDescription = "It's a potion."
	interactionText = "Pick Up"
	formData = null
	
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
	if interactorParent.addItemToInventory(self) == true:
		pickedUp = true
	else:
		inventoryFull()
	
	spawnDialog()


func _on_DialogBox_dialogFinished():
	if pickedUp == true:
		self.queue_free()
