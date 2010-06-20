module Convention
  def self.provided?
    @provided ||= unless defined?(Extlib::Inflection) || defined?(ActiveSupport::Inflection)
      if defined?(Bundler)
        if $LOAD_PATH.any? {|path| path.include? 'extlib'}
          :extlib
        elsif $LOAD_PATH.any? {|path| path.include? 'activesupport'}
          :active_support
        else
          false
        end
      else
        # Assumed other gems get loaded first.
        false
      end
    end
  end
end
