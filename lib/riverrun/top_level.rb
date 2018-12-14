class String

  def line_pace
    self.each_char {|c| putc c ; sleep 0.01 ; $stdout.flush}
  end

end
