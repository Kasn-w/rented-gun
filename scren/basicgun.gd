extends Node2D

@onready var timer: Timer = $Timer
@onready var bullet = load("res://scren/bulletP.tscn")
@onready var gunshoot: AudioStreamPlayer = $gunshoot
@onready var p = get_parent().get_parent()
var speed = 600
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	fire()
	timer.start(p.get_interval())
	
func near():
	var enemies = get_tree().get_nodes_in_group("enemies")
	var nearest_enemy = null
	var shortest_distance = INF # Start with infinity
	
	for enemyn in enemies:
		var distance = p.global_position.distance_to(enemyn.global_position)
		if distance < shortest_distance:
			shortest_distance = distance
			nearest_enemy = enemyn
			
	return nearest_enemy
	
func fire():
	gunshoot.playr()
	var target = near()
	var create = bullet.instantiate()
	var direction:Vector2
	if(target):
		direction = target.global_position - p.global_position
	else:
		direction = Vector2(randf_range(-100,100), randf_range(-100,100))
	create.setup(p.get_dmg(), p.get_gspeed(), direction)
	create.position = p.global_position
	add_child(create)
	
