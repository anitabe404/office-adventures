require_relative "dilemma"
require_relative "report_due"
require_relative "secret"
require_relative "more_time"
require_relative "send_email"
#require_relative ""

class Map
  @@scenes = {
    'report_due' => ReportDue.new,
    'secret' => Secret.new,
    'more_time' => MoreTime.new,
    'dilemma' => Dilemma.new,
    'send_email' => SendEmail.new,
    #'fired' => Fired.new,
    #'success' => Success.new
  }

  def initialize
    @start_scene = 'report_due'
  end

  def next_scene(scene_name)
    @@scenes[scene_name]
  end

  def opening_scene
    next_scene(@start_scene)
  end
end
