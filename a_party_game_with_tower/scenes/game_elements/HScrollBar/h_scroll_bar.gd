extends HScrollBar

var h_scrollbar : HScrollBar
var value_label : Label

const MIN_VALUE = 25
const MAX_VALUE = 500
const BASE_VALUE = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	defineElement()
	configScrollbar()

func defineElement():
	h_scrollbar = $"."
	value_label = $Label

func configScrollbar():
	h_scrollbar.min_value = MIN_VALUE
	h_scrollbar.max_value = MAX_VALUE
	h_scrollbar.value = BASE_VALUE
	
	var callable = Callable(self, "_on_scroll_value_changed")
	h_scrollbar.connect("value_changed", callable)
	update_value_label(h_scrollbar.value)

func _on_scroll_value_changed(value: float):
	update_value_label(value)

func update_value_label(value):
	value_label.text = "Vitesse : " + str(round(value))
	Global.pieceSpeed = value
