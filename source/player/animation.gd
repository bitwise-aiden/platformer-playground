class_name PlayerAnimation extends AnimatedSprite2D


var direction: Dependency = Dependency.new(1)
var on_ground: Dependency = Dependency.new(true)
var is_move: Dependency = Dependency.new(false)


# Lifecycle methods

func _physics_process(_delta: float) -> void:
	flip_h = direction.value == -1

	var state = [
		on_ground.value,
		is_move.value
	]

	match state:
		[true, true]:
			play("move")
		[false, ..]:
			play("jump")
		_:
			play("idle")
