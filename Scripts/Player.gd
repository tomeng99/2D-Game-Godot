extends CharacterBody2D

@onready var camera = $Camera2D
var is_local_player = false

func _ready():
	if is_multiplayer_authority():
		is_local_player = true
		camera.make_current()

func _enter_tree():
	set_multiplayer_authority(name.to_int())
 
func _physics_process(_delta):
	if is_multiplayer_authority():
		velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down") * 100
		
	move_and_slide()
 
