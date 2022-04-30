extends Node


export(float) var fadeoutTime = 2

var fadedOut = true
var timer = 0

signal _OnFadeOut


func _ready():
	
	fadedOut = true
	$Sprite.visible = !fadedOut
	$RichTextLabel.visible = !fadedOut
	$Light2D.visible = !fadedOut

	timer = 0

func _process(delta):
	
	if !fadedOut:
		timer += delta
	
	if timer >= fadeoutTime:
		
		timer = 0
		fadedOut = true
		$Sprite.visible = !fadedOut
		$RichTextLabel.visible = !fadedOut
		$Light2D.visible = !fadedOut

		emit_signal("_OnFadeOut")
	
	

func Build(item):
	
	if(item == null):
		
			
		$RichTextLabel.bbcode_text = "[center]" + "Nothing found in the box..."
		fadedOut = false
		$RichTextLabel.visible = !fadedOut
		
		return
		
	$RichTextLabel.bbcode_text = "[center]" + item.name
#	$RichTextLabel.hint_tooltip = item.price as String
	$Sprite.texture = item.texture
	
	fadedOut = false
	$Sprite.visible = !fadedOut
	$RichTextLabel.visible = !fadedOut
	$Light2D.visible = !fadedOut


func _OnBoxOpen(item):
	Build(item)
