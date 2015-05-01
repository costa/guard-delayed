
ENV['GUARD_ENV'] = 'test'
ENV['RAILS_ENV'] = 'test'

require 'rubygems'

Dir["#{File.expand_path('..', __FILE__)}/support/**/*.rb"].each { |f| require f }

require 'guard/compat/test/helper'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus unless ENV.key?('CI')
  config.run_all_when_everything_filtered = true

  config.disable_monkey_patching!

  # config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  # config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed

  config.before(:each) do
    allow(Guard::Compat::UI).to receive(:notify)
    allow(Guard::Compat::UI).to receive(:info)
    @fixture_path = Pathname.new(File.expand_path('../fixtures/', __FILE__))
  end
end
