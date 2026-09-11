extends Area2D
signal collect(amount)

@onready var sprite_2d: Sprite2D = $Sprite2D
var game = load("uid://cqvaev05dnc5o")
var amount: int = 20
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.set_z_index(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if (body is player):
		collect.emit(amount)
		queue_free()


func _on_timer_timeout() -> void:
	queue_free()
