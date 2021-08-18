extends InteractableItem

var unlocked: bool = false
var alreadyOpenedDialogText = [
	"There's nothing left here."
]

func _ready():
	self.itemName = "Chest"
	self.interactionText = "Open"

	
	self.skeletonDialogText = [
		"It's a chest!",
		"It's locked..."
	]
	
	self.dogDialogText = [
		"You try to pry open the chest with your teeth",
		"The chest refuses to open."
	]
	
	self.chickenDialogText = [
		"The mighty chicken need not concern itself with paltry gifts."
	]

	self.tutorialText = [
		"TUTORIAL: This is a chest, you can open it for a reward",
		"Be careful though, not all chests are what they seem..."
	]

	self.activeItemDialogText = [
		"I'm responding to your active item, in this case, it's a key!",
		"Found 1 [Potion]!"
	]
	
	
func onInteraction(interactorParent):
	if interactorParent.getActiveItem() == "Key" && unlocked == false:
		dialogText = activeItemDialogText
		unlocked = true
		$AnimationPlayer.play("ChestOpen")
		interactorParent.removeItemFromInventory("Key")
		interactorParent.addItemToInventory("Potion")
		spawnDialog()
	elif unlocked == true:
		dialogText = alreadyOpenedDialogText
		spawnDialog()
	else:
		self.dialogText = getDialog(interactorParent)
		spawnDialog()
	pass

func _on_DialogBox_dialogFinished():
	pass
	
