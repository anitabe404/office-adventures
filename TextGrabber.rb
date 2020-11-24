require "tty-prompt"

module TextGrabber
  def create_end_state_hash(filename)
    game_endings_hash = {}
    endings_file = open(filename)

    endings_file.each do |line|
      temp = line.split(": ")
      game_endings_hash[temp[0].to_sym] = temp[1]
    end

    game_endings_hash
  end

  def grab_section_text(filename, game_section)
    # Open Game_Text File
    # Look for section tag in order to pull the correct text
    # Display text to termnial
    # Use typewriter function?
    section_text = open(filename).read
    my_regex = /<#{game_section}>\n.*/
    puts section_text[my_regex]
  end

  def print_section_text(section_text)
    # self.clear
    section_text.each_line do |line|
      typewriter(line)
      print "\n"
      sleep 0.3
    end
  end

  def clear
    system("clear")
  end

  def typewriter(text)
    text.each_char {|c| print c; sleep 0.07}
    puts "\n"
  end

  def prompt
    TTY::Prompt.new
  end
end

# my_opener = TextGrabber.new
# my_opener.create_end_state_hash("./Game_Endings.txt")
# my_opener.grab_section_text("./Welcome_Screen.txt", "report_due")
