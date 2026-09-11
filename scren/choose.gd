extends Control

@onready var c_3: Button = $CanvasLayer/c3
@onready var c_2: Button = $CanvasLayer/c2
@onready var c_1: Button = $CanvasLayer/c1
@onready var re: Button = $CanvasLayer/re
@onready var exit: Button = $CanvasLayer/exit
@onready var _1: Label = $"CanvasLayer/1"
@onready var _2: Label = $"CanvasLayer/2"
@onready var _3: Label = $"CanvasLayer/3"

@onready var all = [c_3, c_2, c_1, re, exit]
@onready var allla = [_1,_2,_3]
@onready var buy = [null,null,null]
var power = ["speed","dmg","gun","bullet speed"]
var rare = ["more Money earn","gun speed"]

var powerd = ["Increase player speed by 10%\n\nCost 100","Increase dmg of all gun by 15%\n\nCost 100","More gun more bullet fire\n\nCost 100\nRent 200","Increase bullet speed by 10%\n\nCost 100"]
var rared = ["Increase earn amount by 10%\n\nCost 100","Decrease gun fired interval by 10%\n\nCost 100"]

signal buyed(thing)
signal reloadsend

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reload()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func disable():
	for i in all:
		i.visible = false
		i.disabled = true
	for i in allla:
		i.visible = false
	
func enable():
	for i in all:
		i.visible = true
		i.disabled = false
	for i in allla:
		i.visible = true

func reload():
	for i in range(buy.size()):
		if (randf_range(0,1) > 0.8):
			var temp = int(randf_range(0,rare.size()))
			buy[i] = rare[temp]
			allla[i].text = rared[temp]
		else:
			var temp = int(randf_range(0,power.size()))
			buy[i] = power[temp]
			allla[i].text = powerd[temp]
	c_1.text = buy[0]
	c_2.text = buy[1]
	c_3.text = buy[2]

func _on_exit_button_down() -> void:
	disable()

func buye(s:String):
	buyed.emit(s)
	
func _on_c_1_button_down() -> void:
	if(buy[0] != null):
		buye(buy[0])
		buy[0] = null
		c_1.text = "BUYED"
		_1.text = ""


func _on_c_2_button_down() -> void:
	if(buy[1] != null):
		buye(buy[1])
		buy[1] = null
		c_2.text = "BUYED"
		_2.text = ""


func _on_c_3_button_down() -> void:
	if(buy[2] != null):
		buye(buy[2])
		buy[2] = null
		c_3.text = "BUYED"
		_3.text = ""


func _on_re_button_down():
	buye("re")
	reload()
