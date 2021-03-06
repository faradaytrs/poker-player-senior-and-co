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

  def is_street?
    return false if cards_count < 5
    cards = all_cards('rank').map do |rank|
      case rank
        when 'J' then 11
        when 'Q' then 12
        when 'K' then 13
        when 'A' then 14
        else rank.to_i
      end
    end.sort.uniq
    cards.inject(cards[0]) do |prev, current|
      return false if current - prev != 1
    end
    true
  end

  def pair_weight
    data = by_rank
    data.keys.inject(0) do |acc, rank|
      if data[rank] > 1
        acc + data[rank]
      else
        acc
      end
    end
  end  

  def cards_count
    all_cards('rank').size
  end

  private

  def all_cards(type)
    our_cards.map { |c| c[type] } + game_state['community_cards'].map { |c| c[type] }
  end

  def our_cards
    game_state['players'][game_state['in_action']]['hole_cards']
  end
end