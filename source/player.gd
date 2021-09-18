extends KinematicBody2D


export(float) var speed: float = 7.5
export(float) var gravity: float = 10.0
export(float) var jump_force: float = 10.0


# Private memebrs 
var __is_moving: bool = false
var __on_ground: bool = false
var __facing_direction: float = 1.0
var __jump_velocity: Vector2 = Vector2.ZERO


onready var __animation: AnimatedSprite = $animation


# Lifecycle methods

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	var direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		0.0
	).normalized()
	
	self.__is_moving = direction.x != 0.0 
	if self.__is_moving:
		self.__facing_direction = sign(direction.x)
	
	if self.__on_ground: 
		self.__jump_velocity = Vector2.ZERO
		
		if Input.is_action_just_pressed("jump"): 
			self.__on_ground = false
			self.__jump_velocity = Vector2.UP * self.jump_force
		
	var velocity: Vector2 = direction * self.speed
	
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
	
	self.__handle_animation()


# Private methods

func __handle_animation() -> void: 
	self.__animation.flip_h = self.__facing_direction == -1
	
	match [self.__on_ground, self.__is_moving]:
		[true, true]: 
			self.__animation.play("move")
		[false, ..]: 
			self.__animation.play("jump")
		_:
			self.__animation.play("idle")
	
