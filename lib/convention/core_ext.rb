require 'convention/inflector'
require 'convention/lookup'

class String
  def singular
    Extlib::Inflection.singular(self)
  end
  alias_method(:singularize, :singular)
  def plural
    Extlib::Inflection.plural(self)
  end
  alias_method(:pluralize, :plural)
end
