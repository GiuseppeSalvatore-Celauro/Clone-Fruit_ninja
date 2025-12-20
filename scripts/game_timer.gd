extends Panel
signal time_end
@onready var timer: Timer = $Timer
@onready var time_counter: Label = $TimeCounter

func _ready()->void:
	timer.wait_time = timer.wait_time * (save_manager.data.upgrades["Time"] + 1)
	timer.start()
	time_counter.text = str(int(timer.time_left))
	
func _process(_delta: float) -> void:
	if time_counter.text != str(int(timer.time_left)):
		time_counter.text = time_formatter(int(timer.time_left))
		
func time_formatter(time_in_sec: int)->String:
	var minutes:int = floor(time_in_sec / 60)
	var seconds:int = time_in_sec % 60
	return "%02d : %02d" % [minutes, seconds]
	
	

func _on_timer_timeout() -> void:
	emit_signal("time_end")
