class_name player

extends CharacterBody2D

signal gameover(msg)
signal takedamge(num)

@onready var weapon: Node = $weapon
@onready var gun = load("res://scren/basicgun.tscn")

var hp: int = 20
var SPEED: float = 300
var dmg: float = 6
var gspeed: float = 600
var gunnum: int = 0
var buynum: int = 0
var interval: float = 1.0

func get_hp():
	return hp
func get_spe():
	return SPEED
func get_dmg():
	return dmg
func get_gspeed():
	return gspeed
func get_interval():
	return interval

func set_hp(n: int):
	hp = n
func set_spe(n: float):
	SPEED = n
func set_dmg(n: float):
	dmg = n
func set_gspeed(n: float):
	gspeed = n
func set_interval(n: float):
	interval = n

func get_gunn():
	return gunnum

func _ready() -> void:
	addw()
	
func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var directionx := Input.get_axis("ui_left", "ui_right")
	var directiony := Input.get_axis("ui_up", "ui_down")
	if directionx and directiony:
		velocity.x = (directionx * SPEED) / 1.5
		velocity.y = (directiony * SPEED) / 1.5
	elif directionx:
		velocity.x = directionx * SPEED
		velocity.y = move_toward(velocity.y, 0, SPEED)
	elif directiony:
		velocity.y = directiony * SPEED
		velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func takeDmg(num: int, ene: String):
	hp -= num
	takedamge.emit(num)
	if (hp < 1):
		gameover.emit()
	
func addw():
	var create = gun.instantiate()
	gunnum += 1
	weapon.add_child(create)

func die():
	queue_free()
	
