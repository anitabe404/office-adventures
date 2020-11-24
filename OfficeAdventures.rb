require_relative "TextGrabber"
require_relative "Player"

class OfficeAdventures
  include TextGrabber

  attr_accessor :current_player
  attr_reader :game_endings, :text_grabber, :person_unknown

  def initialize
    # @text_grabber = TextGrabber.new
    @game_endings = create_end_state_hash("./Game_Endings.txt")
  end

  def start
=begin
start_text = """
Welcome to Office Adventures!
A game where you try to survive the day without getting fired.
    """
    puts start_text
    # self.print_section_text(start_text)
=end
    self.clear
    self.typewriter("Welcome to Office Adventures!")
    self.typewriter("A game where you try to survive the day without getting fired.")

    puts "\n"
    selection = self.prompt.select("What would you like to do?", %w(Play Instructions))

    case selection
    when "Play"
      self.play
    when "Instructions"
      instructions
    end
  end

  def play
    print "Enter your name: "
    name = $stdin.gets.chomp
    @current_player = Player.new(name)
    self.report_due
  end


  def fired(text)
    # some code here
    self.clear
    self.typewriter("You're fired!")
    self.typewriter(text)
    puts "\n"
    press_enter
    puts "\n"
    play_again?
  end

  def report_due
    self.clear

    self.typewriter("10:00 A.M. Monday morning...")
    puts "\n"
    sleep 0.5
    puts "You stare blankly at the monitor as your cursor blinks on an empty document."
    puts "Your report is due after lunch along with a presentation to your colleagues."
    puts "As you try to will yourself to type something meaningful,"
    puts "your boss appears behind you."

    sleep 3
    puts "\n"
    press_enter
    puts "\n"


dialogue = <<END
Boss: Hey #{@current_player.name}!
      How's the report coming?
      Will it be ready in time for the meeting?
END

    self.typewriter(dialogue)
    puts "\n"
    selection = self.prompt.yes? ("How do you reply to your boss?")
    puts "\n"

    if selection
      self.typewriter("You: Yes. It'll be ready.")
      puts "\n"
      self.typewriter("Boss: Great! See you after lunch.")
      puts "\n"
      press_enter
      secret
    else
      more_time
    end

  end

  def instructions
    puts "Here's how you play."
    sleep 5
    start
  end

  def more_time

    puts "\n"
    self.typewriter("You: No.")
    puts "\n"
    self.print_section_text("Boss (visibly angry): Why not?")
    puts "\n"

    choices = {"I'm sick & I need to go home." => "A",  "I got busy on other projects. I need more time." => "B", "Just kidding." => "C"}
    selection = self.prompt.select("How do you reply?", choices)
    puts "\n"

    case selection
    when "A"
      text = """
You: I don't feel well.
     I think I need to go home
"""
      self.typewriter(text)
      press_enter
      fired(@game_endings[:f01])
    when "B"
      self.typewriter("You: I got busy on other projects.\n     I need more time.")
      press_enter
      success(@game_endings[:s02])
    when "C"
      self.typewriter("You (laughing nervously): I'm joking. It'll be done.")
      self.typewriter("Boss (chuckling): You had me there for a minute! I'll see you at the meeting.")
      puts "\n"
      press_enter
      self.secret
    end
  end

  def secret
    clear
    puts "You turn back to your computer determined to come up with something."
    puts "Suddenly, your mouse stops working, and your screen goes blank!\n"
    sleep 2
    puts "\n"
    press_enter

    self.clear
    self.typewriter("Unknown: Hello #{@current_player.name}. Do you want to know a secret?")
    sleep 1
    puts"\n"


    choices = {"Ummmmmm, sure." => "Y",  "Sorry, I have too much work to do." => "N", "Who are you?" => "?"}
    selection = self.prompt.select("How do you respond?", choices)
    puts "\n"

    case selection
    when "Y"
      @person_unknown = true
      self.typewriter("You: Sure, I guess.")
      sleep 1
      puts "\n"
      dilemma
    when "N"
      success(@game_endings[:s01])
    when "?"
      person_unknown = false
      self.typewriter("You: Who are you?")
      sleep 1
      puts "\n"
      dilemma
    end
  end

  def success(text)
    self.clear
    self.typewriter("Hooray!")
    self.typewriter(text)
    puts "\n"
    press_enter
    puts "\n"
    play_again?
  end

  def dilemma
    if @person_unknown
dialogue = <<END
Unknown: Your boss has been embezzling money from the company.
         He's stolen over $100,000 in the past 3 years.
         I need your help to stop him.
         Will you help me?
END

      self.typewriter(dialogue)
      puts "\n"

      selection = self.prompt.yes?("Will you help?")
      puts "\n"

      if selection
        self.typewriter("You: Okay. How can I help?")
        puts "\n"
        press_enter
        send_email
      else
        self.typewriter("You: No, sorry.")
        puts "\n"
        press_enter
        fired(@game_endings[:f05])
      end
    else
dialogue = <<END

...
Unknown: A former employee.
         I was wrongfully terminated after the boss framed me
         for the embezzlement he committed.
         Will you help me?
END
      self.typewriter(dialogue)

      choices = {"Sure. What can I do to help?" => "Y",  "Sorry, I have too much work." => "N", "Stop responding & tell your boss." => "!"}
      selection = self.prompt.select("How do you respond?", choices)
      puts "\n"

      case selection
      when "Y"
        person_unknown = false
        self.typewriter("You: Sure. What can I do to help?")
        puts "\n"
        send_email
      when "N"
        self.typewriter("You: Sorry, I have too much work.")
        puts "\n"
        press_enter
        fired(@game_endings[:f02])
      when "!"
        self.typewriter("...")
        puts "You leave your computer and inform your boss of what's happening."
        puts "\n"
        press_enter
        fired(@game_endings[:f03])
      end
    end
  end

  def send_email
    self.typewriter("Unknown: I need you to send an email to the CFO. Can you do this?")

    choices = {"Yes, what should I say?" => "Y",  "Sorry, this is too intense for me." => "N", "Tell your boss." => "!"}
    selection = self.prompt.select("How do you reply?", choices)
    if @person_unknown
      case selection
      when "Y"
        fired(@game_endings[:f04])
      when "N"
        fired(@game_endings[:f05])
      when "!"
        fired(@game_endings[:f03])
      end
    else
      case selection
      when "Y"
        success(@game_endings[:s03])
      when "N"
        fired(@game_endings[:f02])
      when "!"
        fired(@game_endings[:f03])
      end
    end

  end

  def clear
    system("clear")
  end

  def press_enter
    print "(Press Enter to continue)"
    $stdin.gets
    puts "\n"
  end

  def play_again?
    self.typewriter("Would you like to play again?")

    selection = prompt.yes?("Play again?")
    report_due if selection
  end

end

new_game = OfficeAdventures.new
new_game.start
