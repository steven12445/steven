extends CharacterBody2D

func _physics_process(delta):
	var input_direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = input_direction * 400
	move_and_slide()

	if is_attacking:
		attack_timer += delta
		if attack_timer >= attack_duration:
			is_attacking = false
			$HeldBaton.position = Vector2(695,264)
			$HeldBaton.rotation = 0.0
			


func _on_pickup_area_area_entered(area):
	if area.is_in_group("baton") and not $HeldBaton.visible:
		area.queue_free()
		$HeldBaton.visible = true
var is_attacking = false
var attack_length = 35
var attack_timer = 0
var attack_duration = 0.15

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if $HeldBaton.visible and not is_attacking:
			attack()

func attack():
	is_attacking = true
	attack_timer = 0
	var mouse_global = get_global_mouse_position()
	var dir = (mouse_global - global_position).normalized()
	$HeldBaton.rotation = dir.angle()
	$HeldBaton.set_position((dir * attack_length)+Vector2(695,264)) 
func _on_hit_enemy(body):
	print("m")
	if is_attacking and body.name == "Enemy":
		print("hit enemy: ", body.name)
		body.queue_free()
