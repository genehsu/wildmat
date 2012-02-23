module Wildmat

  VERSION = '0.0.1'

  def self.to_regexp(pattern)
    %r(^#{regexp_pattern(pattern)}$)
  end

  def self.regexp_pattern(pattern)
    # * ? [ \ are treated specially
    # all other non-alphanumeric will be escaped
    literal(pattern, 0, '')
  end

  def self.literal(pattern, i, current)
    return current if i >= pattern.size
    case pattern[i]
    when '*'
      current << '.*'
    when '?'
      current << '.'
    when '\\'
      return backslash(pattern, i+1, current)
    when '['
      return character_class(pattern, i+1, current)
    when /\w/
      current << pattern[i]
    else
      current << '\\' << pattern[i]
    end
    literal(pattern, i+1, current)
  end

  def self.backslash(pattern, i, current)
    # TODO: raise error? if we reach the end of the pattern
    # in a backslash context
    # return ??? if i > pattern.size
    case pattern[i]
    when /\w/
      current << pattern[i]
    else
      current << '\\' << pattern[i]
    end
    literal(pattern, i+1, current)
  end

  def self.character_class(pattern, i, current)
    # TODO: raise error? if we reach the end of the pattern
    # in a character class context
    # return ??? if i > pattern.size
    case pattern[i]
    when ']'
      current << pattern[i]
      return literal(pattern, i+1, current)
    when /\w/
      current << pattern[i]
    else
      current << '\\' << pattern[i]
    end
    character_class(pattern, i+1, current)
  end

end
