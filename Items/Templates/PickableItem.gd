extends InteractableItem
class_name PickableItem

var pickedUp = false
var canTransform = false
var inventoryIsFullDialog = [
	"Your inventory is full!"
]


onready var collisionShape = $Collider

func disableCollision():
	collisionShape.queue_free()
func _on_DialogBox_dialogFinished():
	if pickedUp == true:
		self.queue_free()

func getIconTexture():
	return $Sprite.texture
