describe RiverRun::CLI do
  it 'responds to a #call method' do
    #Setup
    cli = RiverRun::CLI.new

    #Expectation
    expect(cli.call).not_to raise_error()

  end

end
