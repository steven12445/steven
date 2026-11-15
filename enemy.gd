extends CharacterBody2D
@export var speed: float = 80.0
@export var max_hp = 3
var hp = max_hp

@onready var hp_bar = $ProgressBar
var player: Node2D

func _ready():
	player = get_parent().get_node("Player")
	hp_bar.max_value = max_hp
	hp_bar.value = hp

func _physics_process(delta):
	if player == null:
		return
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

func take_damage():
	hp -= 1
	hp_bar.value = hp
	if hp <= 0:
		queue_free()
