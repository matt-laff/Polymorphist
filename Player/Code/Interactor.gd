extends Area2D

class_name Interactor

signal updateInteractable(newInteractable)

onready var interactorParent = self.get_owner() # If there are issues, original design had this be nodepath

var interactionTarget: Node = null

func _process(_delta):
	if interactionTarget != null && Input.is_action_just_pressed("interact"):
		if interactionTarget.has_method("onInteraction"):
			interactionTarget.onInteraction(interactorParent)


func _on_Interactor_body_exited(body):
	if body == interactionTarget:
		interactionTarget = null
		emit_signal("updateInteractable", null)


func _on_Interactor_body_entered(body):
	var canInteract: bool
	
	if body.has_method("interactAvailable"):
		canInteract = body.interactAvailable(interactorParent)
		interactionTarget = body
		emit_signal("updateInteractable", interactionTarget)
