tool
extends TextureButton

export(String) var buttonText = "button text"
export(int) var arrowMargins = 100
export(float) var arrowHeightOffset = 4 

func _ready():
	setText()
	hideArrows()
	set_focus_mode(true)
	$AnimationPlayer.playback_speed = .8
	$AnimationPlayer.play("MenuArrows")
	
func _process(_delta):
	if Engine.editor_hint:
		$AnimationPlayer.play("MenuArrows")
		setText()
		showArrows()
	
func setText():
	$RichTextLabel.bbcode_text = "[center] %s [/center]" % [buttonText]

func showArrows():
	for arrow in [$rightArrow, $leftArrow]:
		arrow.visible = true
		arrow.global_position.y = rect_global_position.y + (rect_size.y / arrowHeightOffset)
		
	var rectCenter = rect_position.x + (rect_size.x/2)
	$leftArrow.global_position.x = rectCenter - arrowMargins
	$rightArrow.global_position.x = rectCenter + arrowMargins - 10


func hideArrows():
	$rightArrow.visible = false
	$leftArrow.visible = false
	



func _on_ButtonTemplate_focus_entered():
	showArrows()

 
func _on_ButtonTemplate_focus_exited():
	hideArrows()
