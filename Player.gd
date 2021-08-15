extends KinematicBody2D
class_name Player

var speed = 225

onready var animationPlayer: AnimationPlayer = $AnimationPlayer
onready var currentForm = "Skeleton"
onready var sprite = $Skeleton


#CHEAT AND TEST KEYS
#==================

func _process(_delta):
	if Input.is_action_just_pressed("cheatKey"):
		if currentForm == "Skeleton":
			updateForm("Chicken")
		else:
			updateForm("Skeleton")

#==================

# Movement Input
#====================
func _physics_process(_delta):
	var direction = Vector2.ZERO
	direction = setDirection(direction)
	
	if direction != Vector2.ZERO:
		direction = move_and_slide(direction * speed)
		updateAnimation(direction)
	else:
		updateIdleAnimation(currentForm)
	if Input.is_action_pressed("sprint"):
		speed = 300
		animationPlayer.playback_speed = 1.35
	if Input.is_action_just_released("sprint"):
		speed = 225
		animationPlayer.playback_speed = 1

func setDirection(direction):
	direction.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	direction.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	direction = direction.normalized()
	return direction


#===================

#Animation Handlers
#===================
func updateAnimation(direction):
	if direction.x > 0:
		animationPlayer.play(currentForm + "WalkRight")
	elif direction.x < 0:
		animationPlayer.play(currentForm + "WalkLeft")
	elif direction.y < 0:
		animationPlayer.play(currentForm + "WalkUp")
	elif direction.y > 0:
		animationPlayer.play(currentForm + "WalkDown")
	
func updateIdleAnimation(currentForm):
	if animationPlayer.current_animation == (currentForm + "WalkDown"):
		animationPlayer.play(currentForm + "Idle")
	elif animationPlayer.current_animation == (currentForm + "WalkUp"):
		animationPlayer.play(currentForm + "IdleUp")
	elif animationPlayer.current_animation == (currentForm + "WalkRight"):
		animationPlayer.play(currentForm + "IdleRight")
	elif animationPlayer.current_animation == (currentForm + "WalkLeft"):
		animationPlayer.play(currentForm + "IdleLeft")

func updateForm(newForm):
	currentForm = newForm
	sprite.hide()
	$Explosion.explode()
	match currentForm:
		"Skeleton":
			sprite = $Skeleton
		"Chicken":
			sprite = $Chicken
		"Dog":
			pass # DELETE THIS
	sprite.show()
	

# Inventory functions

func addItemToInventory(itemName) -> bool:
	if $Inventory.addItem(itemName) == true:
		return true
	else:
		return false