extends CanvasLayer

signal start_game
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func show_message(text):
	$message.text = text
	$message.show()
	$"message timer".start()
	
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $"message timer".timeout
	$"message".text = "Dodge the Creeps!"
	$"message".show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$"start button".show()

func update_score(score):
	$Scorelabel.text = str(score)


func _on_start_button_pressed():
	$"start button".hide()
	start_game.emit()
	$Scorelabel.text = str(0)
	$message.hide()


func _on_message_timer_timeout():
	$"message".hide()
