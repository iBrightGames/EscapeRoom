extends Node


export(float) var fadeoutTime = 2

var fadedOut = true
var timer = 0

signal _OnFadeOut


func _ready():
	
	fadedOut = true
	$Sprite.visible = !fadedOut
	$RichTextLabel.visible = !fadedOut
	timer = 0

func _process(delta):
	
	if !fadedOut:
		timer += delta
	
	if timer >= fadeoutTime:
		
		timer = 0
		fadedOut = true
		$Sprite.visible = !fadedOut
		$RichTextLabel.visible = !fadedOut
		emit_signal("_OnFadeOut")
	
	

func Build(item):
	
	$RichTextLabel.text = item.name
	$Sprite.texture = item.texture
	
	fadedOut = false
	$Sprite.visible = !fadedOut
	$RichTextLabel.visible = !fadedOut


func _OnBoxOpen(item):
	Build(item)
