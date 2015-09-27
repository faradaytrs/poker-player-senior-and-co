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