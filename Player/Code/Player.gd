extends KinematicBody2D
class_name Player

var speed = 225
var dead = false

onready var animationPlayer: AnimationPlayer = $AnimationPlayer
onready var currentForm = "Skeleton"
onready var sprite = $Skeleton
onready var screenSize = get_viewport_rect().size



#CHEAT AND TEST KEYS
#==================

func _process(_delta):
	
	if dead == true:
		gameOver()
	
	if Input.is_action_just_pressed("cheatKey"):
		if currentForm == "Skeleton":
			updateForm("Chicken")
		else:
			updateForm("Skeleton")
	if Input.is_action_just_pressed("spawnPotion"):
		$Inventory.addItem("Potion")
	if Input.is_action_just_pressed("spawnKey"):
		$Inventory.addItem("Key")
	if Input.is_action_just_pressed("spawnFeather"):
		$Inventory.addItem("Feather")
	if Input.is_action_just_pressed("spawnComb"):
		$Inventory.addItem("Comb")

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
		updateIdleAnimation()
	if Input.is_action_pressed("sprint"):
		speed = 300
		animationPlayer.playback_speed = 1.35
	if Input.is_action_just_released("sprint"):
		speed = 225
		animationPlayer.playback_speed = 1
#	self.position.x = clamp(position.x, 0, screenSize.x)
#	self.position.y = clamp(position.y, 0, screenSize.y)

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
	
func updateIdleAnimation():
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
			sprite = $Dog
		"Rat":
			sprite = $Rat
		"Wyvern":
			sprite = $Wyvern
	sprite.show()
	

# Inventory functions

func addItemToInventory(itemName) -> bool:
	if $Inventory.addItem(itemName) == true:
		return true
	else:
		return false

func hasItem(itemName) -> bool:
	print("has item called")
	if $Inventory.hasItem(itemName) == true:
		print("has item in player")
		return true
	else:
		return false
		
func removeItemFromInventory(itemName):
	$Inventory.removeItem(itemName)

func getActiveItem():
	if $Inventory.activeItemSlot.item != null:
		return $Inventory.activeItemSlot.item.itemName
	else:
		return null


func gameOver():
	get_tree().change_scene("res://UI/GameOverScreen/Code/GameOverScreen.tscn")
	
	
