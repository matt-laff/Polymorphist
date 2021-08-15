extends Control
class_name InteractorUI

export var interactorNodePath: NodePath

export var interactionTextNodePath: NodePath

var interactionText = "interact"
var position: Vector2

onready var parent = self.get_owner()

func _ready():
	parent.connect("updateInteractable", self, "interactionTargetChanged", [], CONNECT_DEFERRED)
	self.hide()
	
func _process(_delta):
	position = Vector2(parent.position.x, parent.position.y - 50)
	set_position(position)
	
func interactionTargetChanged(newInteractable: Node) -> void:
	if newInteractable == null: #Original design had a return here if issues occur
		self.hide()
	else:
		if newInteractable.has_method("setInteractionText"):
			interactionText = newInteractable.setInteractionText()
			get_node(interactionTextNodePath).text = interactionText
		self.show()
		$AnimationPlayer.play("active")
	
