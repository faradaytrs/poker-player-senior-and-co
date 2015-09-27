class Player

  VERSION = 0.2

  def bet_request(game_state)
  	#sum = game_state['players'].inject(0) { |player, acc| acc + player['bet'] }
  	avg = game_state['pot'] / 5.0
  	puts avg
  	#game_state['community_cards'].size >= 3

  	p game_state['players']

  	our_cards = game_state['players'][game_state['in_action']]['hole_cards']

  	our_cards[0]['rank'] == our_cards[1]['rank'] ? 1000 : 40



	rescue Exception => e
		puts e
		30
	end
  end

  def showdown(game_state)

  end

  def rank

  end
end
