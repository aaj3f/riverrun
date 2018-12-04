class RiverRun::CLI

  def call
    welcome
    list_events
    ask_input
  end

  def welcome
    puts "\nWelcome to RiverRun Film Festival's CLI App!"
  end

  def list_events
    @events = RiverRun::Event.today.reverse
    puts "\n"
    @events.each.with_index(1) do |event, i|
      puts "  #{i}. #{event.name} [#{event.date}]"
    end
  end

  def ask_input
    puts "\nEnter [1, 2, 3] for more information on one of these events,"
    puts "or type \"list\" to see the list of events again,"
    print "or type \"exit\" to leave the program: "
    input = gets.strip
    if input.to_i > 0
      if @events[input.to_i - 1]
        #want to get heredoc of event info ... maybe @events[index].info

        `open #{@events[input.to_i - 1].url}`
        puts "\n...opening information about event in browser..."

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

  def exit_method
    puts "\nThank you for stopping by! Take care!\n\n"
  end

end
