class_name enemy

extends CharacterBody2D

signal die(x,y,boss)
@onready var enemy_c: CollisionShape2D = $enemyC
@onready var enemy_c2: CollisionShape2D = $Area2D/CollisionShape2D

@onready var sp: AnimatedSprite2D = $AnimatedSprite2D
@onready var enemy_s: AnimatedSprite2D = $AnimatedSprite2D
@onready var target = $"../player"
#@export var sp: Sprite2D

var hp: int = 20
var SPEED: float = 230
var isboss: bool = false

func _ready():
	enemy_s.set_z_index(2)
	add_to_group("enemies")

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if (isboss):
		enemy_s.set_scale(Vector2(0.7,0.7))
		enemy_c.set_scale(Vector2(3,3))
		enemy_c2.set_scale(Vector2(3,3))
	sp.modulate = Color.from_hsv(0, 1 - (((750.0/float(hp))/100))  , 1.0 , 1.0)
	var direction: Vector2
	if (target):
		direction = target.global_position - global_position
	else:
		direction = Vector2(randf_range(-100,100), randf_range(-100,100))
	if (direction.length() > 10):
		velocity = direction.normalized() * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()

func setup(Hp: int, speed: float, b:bool):
	hp = Hp
	SPEED = speed
	isboss = b

func takeDmg(num: int):
	hp -= num
	if (hp < 1):
		die.emit(self.global_position.x, self.global_position.y, isboss)
		queue_free()
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body is player):
		body.takeDmg(1, "Dude")
