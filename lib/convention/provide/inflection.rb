require 'convention/provide/provided'
case Convention.provided?
when :extlib
  require 'extlib/inflection'
  Convention::Inflection = Extlib::Inflection
when :active_support
  require 'active_support/inflector'
  Convention::Inflection = ActiveSupport::Inflector
else
  require 'convention/inflection'
end
