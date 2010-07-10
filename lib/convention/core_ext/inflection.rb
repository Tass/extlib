require 'inflection'

class String

  def singular
    Inflection.singular(self)
  end unless method_defined? :singular

  def plural
    Inflection.plural(self)
  end unless method_defined? :plural

end
