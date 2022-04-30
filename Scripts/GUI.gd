extends Control



func UpdateGUI(money):
	
	$RichTextLabel.bbcode_text = "[center]" + money as String + " Gold"



func _OnMoneyChanged(money):
	UpdateGUI(money)
