class_name InputBuffer


var __name: String = ""

var __buffer: float = .0
var __elapsed: float =.0


# Lifecycle methods

func _init(name: String,buffer: float = .15):
	__name = name

	__buffer = buffer


# Public methods

func triggered() -> bool:
	return __elapsed > 0.0


func process(delta: float) -> void:
	__elapsed = max(0.0, __elapsed - delta)

	if Input.is_action_just_pressed(__name):
		__elapsed = __buffer
