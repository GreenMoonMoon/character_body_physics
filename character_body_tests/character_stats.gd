extends Control

@onready var character = $".."
@onready var char_speed: Label = $GridContainer/CharacterSpeed

func _process(delta):
	char_speed.text = String.num(character.speed)
