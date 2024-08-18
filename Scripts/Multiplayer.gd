extends Node2D

# Declare the ENetMultiplayerPeer instance
var peer = ENetMultiplayerPeer.new()

# Exported PackedScene variables
@export var world_scene: PackedScene
@export var player_scene: PackedScene
@export var enemy_scene: PackedScene

# Reference to the MenuBar
@onready var menu_bar = $MenuBar

func _on_host_pressed():
	# Set up server
	peer.create_server(25566)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)

	# Add player and world
	_add_player()
	var enemy = enemy_scene.instantiate()
	call_deferred("add_child", enemy)
	var world = world_scene.instantiate()
	call_deferred("add_child", world)

	# Remove the MenuBar after logic
	menu_bar.queue_free()

func _add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child", player)

func _on_join_pressed():
	# Set up client
	var chosen_ip = $MenuBar/TextEdit.text
	peer.create_client(chosen_ip, 25566)
	multiplayer.multiplayer_peer = peer
	var world = world_scene.instantiate()
	call_deferred("add_child", world)

	# Remove the MenuBar after logic
	menu_bar.queue_free()
