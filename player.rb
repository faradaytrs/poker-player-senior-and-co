class Player

  VERSION = '0.3'

  def bet_request(game_state)
  	log 'GAME_STATE', game_state

    tactic = Tactic.new game_state
    repeats = tactic.by_rank
    log 'tactic.by_rank', repeats
  	repeats.keys.each do |rank|
      bet = 0
      bet = 600  if repeats[rank] == 2 && ['10', 'J', 'Q', 'K', 'A'].include? rank
      bet = 1000 if repeats[rank] > 2
      if bet > 0
        log_bet bet
        return bet
      end
    end
    repeats = tactic.by_suit
    log 'tactic.by_suit', repeats
    repeats.keys.each do |suit|
      if repeats[suit] >= 5
        log_bet 1000
        return 1000
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


class Tactic
  attr_reader :game_state

	def initialize(game_state)
    @game_state = game_state
  end

  def by_rank
    all_cards('rank').each_with_object({}) { |rank, memo| memo[rank] = memo[rank] ? memo[rank] + 1 : 1 }
  end

  def by_suit
    all_cards('suit').each_with_object({}) { |rank, memo| memo[rank] = memo[rank] ? memo[rank] + 1 : 1 }
  end

  private

  def all_cards(type)
    our_cards.map { |c| c[type] } + game_state['community_cards'].map { |c| c[type] }
  end

  def our_cards
    game_state['players'][game_state['in_action']]['hole_cards']
  end
end