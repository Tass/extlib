class Module

  def find_const(const_name)
    if const_name[0..1] == '::'
      Object.full_const_get(const_name[2..-1])
    else
      nested_const_lookup(const_name)
    end
  end unless method_defined? :find_const

  private

  # Doesn't do any caching since constants can change with remove_const
  def nested_const_lookup(const_name)
    unless equal?(Object)
      constants = []

      name.split('::').each do |part|
        const = constants.last || Object
        constants << const.const_get(part)
      end

      parts = const_name.split('::')

      # from most to least specific constant, use each as a base and try
      # to find a constant with the name const_name within them
      constants.reverse_each do |const|
        # return the nested constant if available
        return const if parts.all? do |part|
          const = if RUBY_VERSION >= '1.9.0'
            const.const_defined?(part, false) ? const.const_get(part, false) : nil
          else
            const.const_defined?(part) ? const.const_get(part) : nil
          end
        end
      end
    end unless method_defined? :nested_const_lookup

    # no relative constant found, fallback to an absolute lookup and
    # use const_missing if not found
    Object.full_const_get(const_name)
  end unless method_defined? :nested_const_lookup
end

class Object

  # @param name<String> The name of the constant to get, e.g. "Merb::Router".
  #
  # @return [Object] The constant corresponding to the name.
  def full_const_get(name)
    list = name.split("::")
    list.shift if list.first.blank?
    obj = self
    list.each do |x|
      # This is required because const_get tries to look for constants in the
      # ancestor chain, but we only want constants that are HERE
      obj = obj.const_defined?(x) ? obj.const_get(x) : obj.const_missing(x)
    end
    obj
  end unless method_defined? :full_const_get

  # @param name<String> The name of the constant to get, e.g. "Merb::Router".
  # @param value<Object> The value to assign to the constant.
  #
  # @return [Object] The constant corresponding to the name.
  def full_const_set(name, value)
    list = name.split("::")
    toplevel = list.first.blank?
    list.shift if toplevel
    last = list.pop
    obj = list.empty? ? Object : Object.full_const_get(list.join("::"))
    obj.const_set(last, value) if obj && !obj.const_defined?(last)
  end unless method_defined? :full_const_set

  # Defines module from a string name (e.g. Foo::Bar::Baz)
  # If module already exists, no exception raised.
  #
  # @param name<String> The name of the full module name to make
  #
  # @return [nil]
  def make_module(string)
    current_module = self
    string.split('::').each do |part|
      current_module = if current_module.const_defined?(part)
        current_module.const_get(part)
      else
        current_module.const_set(part, Module.new)
      end
    end
    current_module
  end unless method_defined? :make_module

end
