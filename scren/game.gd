extends Node2D
@export var area: Rect2 = Rect2(-1000, -600, 1000, 600)
@onready var timerE: Timer = $TimerE
@onready var timerC: Timer = $TimerC
@onready var buysound: AudioStreamPlayer = $buysound
@onready var gunbuysound: AudioStreamPlayer = $gunbuysound
@onready var rentdue: Timer = $rentdue
@onready var rentcountdown: Timer = $rentcountdown

var countdown: = load("res://scren/countdown.tscn")
var wins = load("res://scren/win.tscn")
var loses = load("res://scren/lose.tscn")
var live: bool = true
var ekill:int = 0

var _enemy = load("res://scren/enemy.tscn")
var _coll = load("res://scren/collect.tscn")
var _buy = load("res://scren/buy.tscn")
var timeer: float = 0
var minn: int
var sec: int
var money: int = 1000
var rent: int = 0
var bonus: float = 1
var eneable: bool = true
var balive: bool = false
var iswin: bool = false
var counttrack:int = 0
@onready var p: player = $player
var power = ["speed","dmg","gun","bullet speed","more Money earn","gun speed"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (live):
		if (ekill >= 30) and (p.get_hp() < 21):
			p.set_hp(p.get_hp() + 1)
			ekill = 0
		
		timeer += 1 * delta
		minn = floor(timeer / 60)
		sec = floor(fmod(timeer, 60))
			
		rent = p.get_gunn() * 200
		if (rentdue.time_left <= 3):
			if (counttrack != ceil(rentdue.time_left)):
				counttrack = ceil(rentdue.time_left)
				countdownf(counttrack)
			if (counttrack == 1):
				rentcountdown.start(rentdue.time_left)
				
				
func countdownf(i: int):
	var create = countdown.instantiate()
	if (i != 0):
		create.setup(str(i))
	else:
		create.setup("RENT DUE")
	add_child(create)
	create.fade()
	
func spawnEnemy(s: int, e:int, b:bool = false):
	var create = _enemy.instantiate()
	
	var pos = Vector2(
		randf_range(area.position.x, area.end.x),
		randf_range(area.position.y, area.end.y)
	)
	
	create.setup(randf_range(s,e), 130, b)
	create.position = pos
	
	add_child(create)
	create.die.connect(edie)
	
func spawnCollect(x = null, y = null):
	var create = _coll.instantiate()
	
	var pos = Vector2(
		randf_range(area.position.x, area.end.x),
		randf_range(area.position.y, area.end.y)
	)
	if (x and y):
		pos = Vector2(x,y)

	add_child(create)
	create.position = pos
	create.collect.connect(coll)
	
func spawnBuy():
	var create = _buy.instantiate()
	
	var pos = Vector2(
		randf_range(area.position.x, area.end.x),
		randf_range(area.position.y, area.end.y)
	)
	create.position = pos

	add_child(create)
	create.buyed.connect(buy)

func buy(what: String):
	if (what == power[0]):
		p.set_spe(p.get_spe() * 1.1)
	if (what == power[1]):
		p.set_dmg(p.get_dmg() * 1.15)
	if (what == power[2]):
		gunbuysound.playr()
		p.addw()
	if (what == power[3]):
		p.set_gspeed(p.get_gspeed() * 1.1)
	if (what == power[4]):
		bonus += 0.1
	if (what == power[5]):
		p.set_interval(p.get_interval() * 0.9)
	var base:int
	if (what == "re"):
		base = 200
	else:
		buysound.playr()
		base = 100
	money -= base

func gameover(win:bool):
	if (live):
		if (win) and !(iswin):
			eneable = false
			iswin = true
			var create = wins.instantiate()
			add_child(create)
			create.setup(String.num(money,0))
			create.con.connect(conti)
		else:
			eneable = false
			var create = loses.instantiate()
			var minns: String = String.num(minn,0)
			var secs: String = String.num(sec, 0)
			if (secs.length() < 2):
				secs = "0" + secs
			var txt:String = minns + " : " + secs
			add_child(create)
			create.setup(txt)
			create.con.connect(conti)
			p.die()
			var timerA = get_tree().get_nodes_in_group("time")
			for i in timerA:
				i.stop()
			var m = get_tree().get_nodes_in_group("buy")
			for i in m:
				i.queue_free()
		live = false
		
func conti():
	eneable = true
	live = true

func _on_timer_timeout() -> void:
	if (eneable):
		if (minn < 1 and sec < 30):
			if (sec > 10):
				timerE.start(3)
				for i in range(floor(randf_range(0,5))):
					spawnEnemy(3,10)
			else:
				timerE.start(1)
		elif (minn < 1):
			timerE.start(3)
			for i in range(floor(randf_range(1,5))):
				spawnEnemy(8,15)
		elif (minn < 2 and sec < 30):
			timerE.start(3)
			for i in range(floor(randf_range(1,5))):
				spawnEnemy(8,24)
		elif (minn < 2):
			timerE.start(2)
			for i in range(floor(randf_range(1,5))):
				spawnEnemy(15,24)
		elif (minn < 3):
			timerE.start(3)
			for i in range(floor(randf_range(2,6))):
				spawnEnemy(20,28)
		elif (minn < 4):
			timerE.start(2)
			for i in range(floor(randf_range(2,7))):
				spawnEnemy(25,30)
		elif (minn < 5 and sec < 30):
			timerE.start(2)
			for i in range(floor(randf_range(2,7))):
				spawnEnemy(30,40)
		elif (minn < 5):
			timerE.start(2)
			for i in range(floor(randf_range(3,10))):
				spawnEnemy(30,40)
		else:
			if (iswin):
				timerE.start(1)
			else:
				timerE.start(1.3 - (minn/30.0))
			for i in range(floor(randf_range(4,10))):
				if (iswin):
					spawnEnemy(10 * minn, 15 * minn)
				else:
					spawnEnemy(10,21)
				
			if !(balive):
				spawnEnemy(100*minn,100*minn,true)
				balive = true
			

func _on_timer_c_timeout() -> void:
	timerC.start()
	spawnCollect()

func coll(amount: int):
	money += amount * bonus
	
func edie(x: float, y:float, b:bool):
	var d:float = 30
	ekill += 1
	for i in range(int(randf_range(1,5))):
		spawnCollect(randf_range(x-d,x+d),randf_range(y-d,y+d))
	if (b):
		balive = false
		if !(iswin):
			gameover(true)

func _on_timer_b_timeout() -> void:
	spawnBuy()

func _on_rentdue_timeout() -> void:
	money -= rent
	if(money < 0):
		gameover(false)

func _on_player_gameover() -> void:
	gameover(false)

func _on_player_takedamge(num: Variant) -> void:
	money -= num

func _on_area_2d_buyed(s: String) -> void:
	buy(s)

func _on_rentcountdown_timeout() -> void:
	countdownf(0)
	rentcountdown.stop()
