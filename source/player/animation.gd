class_name PlayerAnimation extends AnimatedSprite


var direction: FuncRef
var on_ground: FuncRef
var is_move: FuncRef


# Lifecycle methods

func _physics_process(_delta: float) -> void:
	if self.direction.is_valid():
		self.flip_h = self.direction.call_func() == -1
	
	var state = [
		self.on_ground.is_valid() && self.on_ground.call_func(),
		self.is_move.is_valid() && self.is_move.call_func()
	]
	
	match state:
		[true, true]: 
			self.play("move")
		[false, ..]: 
			self.play("jump")
		_:
			self.play("idle")
