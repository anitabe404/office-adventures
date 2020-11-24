class ReportDue
  def enter
    # Fix code so that the clear method works
    # self.clear

    # Fix code so that the typewriter method works.
    # self.typewriter("10:00 A.M. Monday morning...")
    puts "\n"
    sleep 0.5
    puts "You stare blankly at the monitor as your cursor blinks on an empty document."
    puts "Your report is due after lunch along with a presentation to your colleagues."
    puts "As you try to will yourself to type something meaningful,"
    puts "your boss appears behind you."

    sleep 3

    # Update code so that the puts "\n" needed for formatting occurs inside of
    # press_enter method
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

    # Move the following code to the choose method
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

  def choose
  end

  def next_scene
  end

  # Delete this method once the code has beeen moved to the appropriate new method
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
