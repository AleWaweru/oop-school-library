class Nameable
    def correct_name
      raise NotImplementedError, "Method 'correct_name' must be implemented in a subclass."
    end
  end
  
  class BaseDecorator < Nameable
    def initialize(nameable)
      @nameable = nameable
    end
  
    def correct_name
      @nameable.correct_name
    end
  end
  

  class CapitalizeDecorator < BaseDecorator
    def correct_name
      original_name = @nameable.correct_name
      original_name.capitalize
    end
  end
  
  class TrimmerDecorator < BaseDecorator
    def correct_name
      original_name = @nameable.correct_name
      trimmed_name = original_name[0..9] 
      trimmed_name
    end
  end
  