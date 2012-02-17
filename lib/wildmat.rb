module Wildmat

  VERSION = '0.0.1'

# Asterisk (*) to match any sequence of zero or more characters.
# Question mark (?) to match any single character.
# Set of specified characters. It is specified as a list of characters, or as a range of characters where the beginning and end of the range are separated by a minus (or dash) character, or as any combination of lists and ranges. The dash can also be included in the set as a character if it is the beginning or end of the set. This set is enclosed in square brackets. The close square bracket (]) may be used in a set if it is the first character in the set.
# Negation of a set. It is specified the same way as the set with the addition of a caret character (^) at the beginning of the test string just inside the open square bracket.
# Backslash (\) character to invalidate the special meaning of the open square bracket ([), the asterisk, backslash or the question mark. Two backslashes in sequence will result in the evaluation of the backslash as a character with no special meaning.

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
