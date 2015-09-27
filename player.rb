require_relative 'tactic'

class Player

  VERSION = 'RANDOMIZE\'EM ALL' 

  def bet_request(game_state)
  	log 'GAME_STATE', game_state

    tactic = Tactic.new game_state

    if tactic.is_street?
      log 'street', 10000
      return 10000
    end

    # by rank
    repeats = tactic.by_rank
    log 'tactic.by_rank', repeats
    
    if tactic.pair_weight >= 3
      log 'pair_weight', 10000
      return 10000
    end

  	repeats.keys.each do |rank|
      bet = 0
      bet = 200 if repeats[rank] == 2 && ['2', '3', '4', '5'].include?(rank)
      bet = 400 if repeats[rank] == 2 && ['6', '7', '8', '9'].include?(rank)
      bet = 600 if repeats[rank] == 2 && ['10', 'J', 'Q', 'K', 'A'].include?(rank)
      bet = 10000 if repeats[rank] > 2
      if bet > 0
        log_bet bet
        return bet
      end
    end

    # by suit
    repeats = tactic.by_suit
    log 'tactic.by_suit', repeats
    repeats.keys.each do |suit|
      if repeats[suit] >= 5
        log 'flash', 10000
        return 10000
      end
      if repeats[suit] == 4 && tactic.cards_count == 5
        log 'prob. flash', game_state['pot']
        return game_state['pot']
      end
    end

    blind = game_state['small_blind'] * 2
  	log_bet blind
  	blind
  end

  def showdown(game_state)

  end

  def rank

  end


  def log_bet(bet)
  	puts "[LOGGING] BET: #{bet}"
  end

  def log(key, data)
  	puts "[LOGGING] #{key}: #{data}"
  end
end