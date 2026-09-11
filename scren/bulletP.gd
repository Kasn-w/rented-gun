class_name bullet_p

extends CharacterBody2D

var dmg: int
var sp: float
var direct: Vector2

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	velocity = direct * sp
	move_and_slide()

func setup(damage: int, speed: float, di:Vector2):
	direct = di.normalized()
	dmg = damage
	sp = speed


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body is enemy):
		body.takeDmg(dmg)
		queue_free()
	if (body is StaticBody2D):
		queue_free()
