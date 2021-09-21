class_name PlayerAnimation extends AnimatedSprite


var direction: Dependency = Dependency.new(1)
var on_ground: Dependency = Dependency.new(true)
var is_move: Dependency = Dependency.new(false)


# Lifecycle methods

func _physics_process(_delta: float) -> void:
	self.flip_h = self.direction.value == -1

	var state = [
		self.on_ground.value,
		self.is_move.value
	]

	match state:
		[true, true]:
			self.play("move")
		[false, ..]:
			self.play("jump")
		_:
			self.play("idle")
