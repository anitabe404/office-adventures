class Player
  @@players = []
  attr_reader :name
  attr_accessor :stats

  def initialize(name)
    @name = name
    @stats = {wins: 0, loss: 0}
    @@players << self
  end

end
