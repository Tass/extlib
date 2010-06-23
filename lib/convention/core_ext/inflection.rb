require 'convention/provide/inflection'

class String

  def singular
    Convetion::Inflection.singular(self)
  end unless method_defined? :singular

  def plural
    Convetion::Inflection.plural(self)
  end unless method_defined? :plural

end
