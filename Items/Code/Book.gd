extends InteractableItem

var activeItemDialogText = [
	"I'm responding to your active item, in this case, it's a key!"
]

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

	self.tutorialText = [
		"TUTORIAL: I'm a book, I can't be picked up, but sometimes I have helpful information.",
		"Watch out though, if you're in chicken form, you might be compelled to destroy me"
	]
	
	
	
func onInteraction(interactorParent):
#	if interactorParent.getActiveItem() == "Potion":
#		dialogText = activeItemDialogText
#	elif interactorParent.getActiveItem() == "Feather":
#		print("it's a feather")
#	elif interactorParent.getActiveItem() == "Key":
#		print("keys are useful!")
	
	
	
	if interactionCount == 0:
		dialogText = tutorialText
		interactionCount += 1
	else:
		self.dialogText = getDialog(interactorParent)
		if interactorParent.currentForm == "Chicken":
			self.hide()
			
	if interactorParent.getActiveItem() == "Potion":
		dialogText = activeItemDialogText
	spawnDialog()

func _on_DialogBox_dialogFinished():
	if self.visible == false:
		self.queue_free()
