require "./map.rb"

class Engine
  def initialize
    @scene_map = Map.new
  end

  def play
    puts "#{@scene_map.opening_scene}"
    puts "Game play goes here."
  end
end

game = Engine.new
game.play
