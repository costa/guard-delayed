require 'guard/delayed'

RSpec.describe Guard::Delayed do

  describe "when passing an environment option" do

    let(:subject) {Guard::Delayed.new({environment: 'test'})}

    it "call first" do
      expect(::Delayed::Command).to receive(:new).with(['stop']).and_call_original
      expect(::Delayed::Command).to receive(:new).with(['start']).and_call_original
      subject.start
    end

    it "call last" do
      expect(::Delayed::Command).to receive(:new).with(['stop']).and_call_original
      subject.stop
    end

    it "on reload" do
      expect(::Delayed::Command).to receive(:new).with(['restart']).and_call_original
      subject.reload
    end

    it "on *all*" do
      expect(::Delayed::Command).to receive(:new).with(['restart']).and_call_original
      subject.run_all
    end

    it "after changes" do
      expect(::Delayed::Command).to receive(:new).with(['restart']).and_call_original
      subject.run_on_changes []
    end

  end

end
