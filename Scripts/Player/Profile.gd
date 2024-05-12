extends Control



func _process(delta):
	get_node("stats_label").text = "Player Health: %s\nPlayer Attack: %s\nPlayer Defense: %s" % [Game.player_health,Game.right_hand_equipped.item_damage,Game.right_hand_equipped.item_defense]
