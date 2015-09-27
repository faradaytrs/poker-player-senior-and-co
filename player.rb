class Player

  VERSION = 0.2

  def bet_request(game_state)
  	#sum = game_state['players'].inject(0) { |player, acc| acc + player['bet'] }
  	avg = game_state['pot'] / 5.0
  	puts avg
  	#game_state['community_cards'].size >= 3

  	p game_state['players']

  	our_cards = game_state['players'][game_state['in_action']]['hole_cards']


	all_cards = our_cards.map { |cd| cd['rank'] } + community_cards.map { |cd| cd['rank'] }

	repeats = all_cards.each_with_object({}) { |rank, memo| memo[rank] = memo[rank] ? memo[rank] + 1 : 1 }
    
    repeats.keys.each do |rank|
    	return 1000 if repeats[rank] > 2
    end

    if our_cards[0]['rank'] == our_cards[1]['rank'] 
  		puts '[22] Pair'
  		1000
	else
		40
	end

  end

  def showdown(game_state)

  end

  def rank

  end
end
