extends Label

@onready var game: Node2D = $"../.."
@onready var label: Label = $"."
#var min: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var minn: String = String.num(game.minn,0)
	var sec: String = String.num(game.sec, 0)
	if (sec.length() < 2):
		sec = "0" + sec
	label.text = minn + " : " + sec
