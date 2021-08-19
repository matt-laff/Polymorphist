extends InteractableItem

class_name RatHole

signal ratHoleEntered

var unlocked: bool = false
var alreadyOpenedDialogText = [
	"There's nothing left here."
]

func _ready():
	self.itemName = "RatHole"
	self.interactionText = "Interact"

	
	self.skeletonDialogText = [
		"It's a small hole."
	]
	
	self.dogDialogText = [
		"You try to crawl into the hole...",
		"It's no use, you're too big"
	]
	
	self.chickenDialogText = [
		"A chicken needs not concern himself with such small things"
	]

	self.ratDialogText = [
		"It's a tunnel!",
		"Where does this go?"
	]
	
	
func onInteraction(interactorParent):
	player = interactorParent
	self.dialogText = getDialog(interactorParent)
	if interactorParent.currentForm == "Rat":
		spawnDialog()
	else:
		spawnDialog()


func _on_DialogBox_dialogFinished():
	if player.currentForm == "Rat":
		emit_signal("ratHoleEntered", self)
	pass
	
func getTargetPosition():
	return $TargetPosition.global_position
