class_name Player extends KinematicBody2D


export(float) var speed: float = 7.5
export(float) var gravity: float = 10.0
export(float) var jump_force: float = 10.0

var __on_ground: bool = false
var __jump_velocity: Vector2 = Vector2.ZERO

onready var __input: PlayerInput = $input
onready var __collision: PlayerCollision = $collision


# Lifecycle methods

func _ready() -> void:
	self.__collision.player_position.attach(self, "get_position")

	var animation = $animation
	animation.direction.attach(self.__input, "direction")
	animation.is_move.attach(self.__input, "is_move")
	animation.on_ground.attach(self.__collision, "on_ground")


func _physics_process(delta: float) -> void:
	self.__handle_jump()

	var velocity: Vector2 = self.__input.movement_horizontal() * self.speed

	if !self.__collision.on_ground():
		self.__jump_velocity += Vector2.DOWN * self.gravity

	velocity += self.__jump_velocity

	var previous_position: Vector2 = self.position

	var collision: KinematicCollision2D = self.move_and_collide(velocity)
	if collision && collision.normal.x != 0.0:
		var position_delta: Vector2 = previous_position - self.position
		var remaining_y = velocity.y - position_delta.y

		self.move_and_collide(Vector2(0.0, remaining_y))


# Private methods

func __handle_jump() -> void:
	if !self.__collision.on_ground():
		return

	self.__jump_velocity = Vector2.ZERO

	if self.__input.is_jump():
		self.__jump_velocity = Vector2.UP * self.jump_force
