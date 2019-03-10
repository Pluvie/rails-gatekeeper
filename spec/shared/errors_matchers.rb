require 'rspec/expectations'

RSpec::Matchers.define :have_error do |error_type, options = {}|
  unless options[:on].present?
    raise "Must specify a field to look for error with 'on'. "\
      "Example: expect(model).to have_error :blank, on: :name"
  end
  
  match do |actual|
    field = options[:on]
    actual.errors.details[field].present?
    actual.errors.details[field].map { |error| error[:error] }.include? error_type
  end
end
