# So we can test with all provided solutions
#BareTest.new_component :inflection do
require 'convention/inflection'
suite 'Inflection', :use => :tabular_data do
  suite 'bijective' do
    setup.tabular_data <<-TABLE
  @from | @to
  :singular | :plural
  :plural | :singular
  TABLE

    setup.tabular_data(File.read(File.expand_path('../inflection', __FILE__)))

    setup do
      class << self
        attr_reader :singular, :plural
      end
    end

    exercise "converting :singular <=> :plural from :from" do
      ::Convention::Inflection.send(@to, send(@from))
    end
    verify "returns :to" do
      returns(send(@to))
    end
  end

  suite 'injective singular -> plural' do

    setup.tabular_data(File.read(File.expand_path('../injective', __FILE__)))

    exercise "converting :plural" do
      ::Convention::Inflection.singular(@plural)
    end
    verify "returns :singular" do
      returns(@singular)
    end

  end
end
