class RiverRun::CLI

  def call
    welcome
    list_events
    ask_input
  end

  def welcome
    puts "\nWelcome to RiverRun Film Festival's CLI App!".cyan
  end

  def list_events
    @events = RiverRun::Event.today.reverse
    puts "\n"
    @events.each.with_index(1) do |event, i|
      puts "  #{i}. #{event.name} [#{event.date}]"
    end
  end

  def ask_input
    puts "\nEnter [1, 2, 3] for more information on one of these events,".cyan
    puts "or type \"list\" to see the list of events again,".cyan
    print "or type \"exit\" to leave the program: ".cyan
    input = gets.strip
    if input.to_i > 0
      if @events[input.to_i - 1]
        @events[input.to_i - 1].more_info.each.with_index do |p, i|
          puts "\n"
          p.line_pace
          unless i == (@events[input.to_i - 1].more_info.size - 1)
            puts "\n\nPress any key to continue...\n".light_blue
            STDIN.getch
          else
            puts "\n"
          end
        end
        puts "\nType \"go\" to visit the RiverRun website for this event,".cyan
        print "or type \"list\" to return to the main list of upcoming events: ".cyan
        input2 = gets.strip
        if input2 == "go"
          `open #{@events[input.to_i - 1].url}`
          puts "\n...opening information about event in browser..."
        else
          list_events
        end
      else
        puts "\n\tI don't recognize that input, please type [1, 2, 3] or \"exit\""
      end
    elsif input == "list"
      list_events
    elsif input == "exit"
      exit_method
    else
      "\n\tI don't recognize that input, please type [1, 2, 3] or \"exit\""
    end
    ask_input unless input == "exit"
  end

  def line_pace
    self.each_char {|c| putc c ; sleep 0.02 ; $stdout.flush}
  end

  def exit_method
    puts "\nThank you for stopping by! Take care!\n\n"
  end

end


# if we want to open page in browser use:
      # `open #{@events[input.to_i - 1].url}`
      # puts "\n...opening information about event in browser..."
