class String

  def line_pace
    self.each_char {|c| putc c ; sleep 0.02 ; $stdout.flush}
  end

end
