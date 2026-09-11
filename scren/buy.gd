extends Area2D

signal buyed(s:String)

@onready var control: Control = $Control
@onready var label: Label = $Label
@onready var blbar: Sprite2D = $Sprite2D2

var check: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("buy")
	control.disable()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (check):
		blbar.show()
	else:
		blbar.hide()
	label.set_visible(check)
	if (check and Input.is_action_just_pressed("ui_accept")):
		control.enable()


func _on_body_entered(body: Node2D) -> void:
	if (body is player):
		check = true
		

func _on_body_exited(body: Node2D) -> void:
	if (body is player):
		check = false

func _on_timer_timeout() -> void:
	queue_free()


func _on_control_buyed(thing: Variant) -> void:
	buyed.emit(thing)
