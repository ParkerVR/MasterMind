extends Control




# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _update_current_guess(button: g.ButtonOption):

	if button == g.ButtonOption.CLEAR:
		g.responses = g.responseClear.duplicate()
		g.theGuess = []
		
		if g.GameState == g.GameStateOption.WIN || g.GameState == g.GameStateOption.LOSE:
			g.GameState = g.GameStateOption.RESTART
			g.reset()
		else:
			g.GameState = g.GameStateOption.CLEAR
	
	# About to input last response!
	elif g.theGuess.size() == g.theCodeLength-1:
		var guessColor : g.CodeColor = g.ButtonOptionToCodeColor[button]
		g.theGuess.append(guessColor)
		g.respond()
		
	elif g.theGuess.size() >= g.theCodeLength:
		print("Full!!!")
	else:
		var guessColor : g.CodeColor = g.ButtonOptionToCodeColor[button]
		g.theGuess.append(guessColor)
		g.GameState = g.GameStateOption.GUESSING
		

	


func _process_color_button(event, button: g.ButtonOption):
	if event is InputEventMouseButton:
		if (event.button_index == 1 && event.is_pressed()):
			_update_current_guess(button)


func _process_button_red(event):
	_process_color_button(event, g.ButtonOption.RED)

func _process_button_orange(event):
	_process_color_button(event, g.ButtonOption.ORANGE)
			
func _process_button_yellow(event):
	_process_color_button(event, g.ButtonOption.YELLOW)
			
func _process_button_green(event):
	_process_color_button(event, g.ButtonOption.GREEN)
			
func _process_button_blue(event):
	_process_color_button(event, g.ButtonOption.BLUE)	
			
func _process_button_violet(event):
	_process_color_button(event, g.ButtonOption.VIOLET)

# Does a Clear Operation
func _process_button_black(event):
	_process_color_button(event, g.ButtonOption.CLEAR)

