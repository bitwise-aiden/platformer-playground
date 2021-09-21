class_name Player extends KinematicBody2D


export(float) var speed: float = 7.5
export(float) var gravity: float = 10.0
export(float) var jump_force: float = 10.0

var __on_ground: bool = false
var __jump_velocity: Vector2 = Vector2.ZERO

onready var __input: PlayerInput = $input


# Lifecycle methods

func _ready() -> void:
	var animation = $animation
	animation.direction.attach(self.__input, "direction")
	animation.is_move.attach(self.__input, "is_move")
	animation.on_ground.attach(self, "on_ground")


func _physics_process(delta: float) -> void:
	self.__handle_jump()
	
	var velocity: Vector2 = self.__input.movement_horizontal() * self.speed
	
	if !self.__on_ground: 
		self.__jump_velocity += Vector2.DOWN * self.gravity
	
	velocity += self.__jump_velocity
	
	var previous_position: Vector2 = self.position
	
	var collision: KinematicCollision2D = self.move_and_collide(velocity)
	if collision:
		if collision.normal == Vector2.UP:
			self.__on_ground = true
		else:
			var position_delta: Vector2 = previous_position - self.position
			var remaining_y = velocity.y - position_delta.y
			
			self.move_and_collide(Vector2(0.0, remaining_y))


# Public methods

func on_ground() -> bool:
	return self.__on_ground


# Private methods

func __handle_jump() -> void: 
	if !self.__on_ground:
		return
	
	self.__jump_velocity = Vector2.ZERO
	
	if self.__input.is_jump(): 
		self.__on_ground = false
		self.__jump_velocity = Vector2.UP * self.jump_force
