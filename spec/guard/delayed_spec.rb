require 'guard/delayed'

RSpec.describe Guard::Delayed do

  describe "when passing an environment option" do

    let(:subject) {Guard::Delayed.new({environment: 'test'})}

    it "calls system with 'export RAILS_ENV=test;' call first" do
      expect(::Delayed::Command).to receive(:new).with('stop').and_return(double daemonize: true)
      expect(::Delayed::Command).to receive(:new).with('start').and_return(double daemonize: true)
      subject.start
    end

    it "calls system with 'export RAILS_ENV=test;' after changes" do
      expect(::Delayed::Command).to receive(:new).with('restart').and_return(double daemonize: true)
      subject.run_on_changes([])
    end

  end

end
