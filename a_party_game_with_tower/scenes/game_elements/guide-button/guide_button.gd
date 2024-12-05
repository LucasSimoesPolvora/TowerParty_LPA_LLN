extends Button

@onready var popup = $Popup

func _ready() -> void:
	pass

func _on_pressed() -> void:
	popup.popup_centered()
