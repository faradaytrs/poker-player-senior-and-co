class Player

  VERSION = 0.2

  def bet_request(game_state)
  	#sum = game_state['players'].inject(0) { |player, acc| acc + player['bet'] }
  	avg = game_state['pot'] / 5.0
  	puts avg
  	#game_state['community_cards'].size >= 3

  	p game_state['players']

  	our_cards = game_state['players'][game_state['in_action']]['hole_cards']


	all_cards = our_cards.map { |cd| cd['rank'] } + game_state['community_cards'].map { |cd| cd['rank'] }

	repeats = all_cards.each_with_object({}) { |rank, memo| memo[rank] = memo[rank] ? memo[rank] + 1 : 1 }
    
	p all_cards

    repeats.keys.each do |rank|
    	if repeats[rank] >= 2
    		log_bet 1000
    		return 1000
    	end
    end

    if our_cards[0]['rank'] == our_cards[1]['rank'] 
  		bet = 1000
	else
		bet = game_state['small_blind'] * 2
	end

	log_bet bet
	bet
  end

  def showdown(game_state)

  end

  def rank

  end


  def log_bet(bet)
  	puts "[LOGGING] BET: #{bet}"
  end
end


class Tactic

end