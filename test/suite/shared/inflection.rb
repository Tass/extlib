# So we can test with all provided solutions
#BareTest.new_component :inflection do
require 'convention/inflection'
suite 'Convention' do
suite 'Inflection', :use => :tabular_data do
  setup.tabular_data(File.read(File.expand_path('../inflection', __FILE__)))

  setup.tabular_data <<-TABLE
@from | @to
:singular | :plural
:plural | :singular
TABLE

  setup do
    class << self
      attr_reader :singular, :plural
    end
  end

  exercise "converting :singular <=> :plural from :from to :to" do
    ::Convention::Inflection.send(@to, send(@from))
  end
  verify "returns as expected" do
    returns(send(@to))
  end

end
end
