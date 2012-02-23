require "spec_helper"
require "wildmat"

describe Wildmat do

  context 'word characters' do
    bad_string = "foo bar baz"
    %w[
      asdf
      _
      123
      a1
      foo_bar_baz
      _under
      after_
    ].each do |input|
      it "should not change word characters: #{input}" do
        Wildmat.regexp_pattern(input).should eq input
      end
      it "should match itself: #{input} =~ #{input}" do
        input.should match Wildmat.to_regexp(input)
      end
      it "should not match an arbitrary string: #{input} !~ #{bad_string}" do
        bad_string.should_not match Wildmat.to_regexp(input)
      end
    end
  end

  context 'question mark' do
    # Negative cases
    negatives = %w[ abc nice caba abcde ]
    # Positive cases
    [
      [ '?abc', %w[ 1abc aabc _abc .abc ] ],
      [ 'abc?', %w[ abc1 abcc abc_ abc. ] ],
      [ 'a??c', %w[ abzc a12c a_?c a.!c ] ],
    ].each do |wildmat,inputs|
      regexp = Wildmat.to_regexp(wildmat)
      it "should match a single character: #{wildmat} =~ #{inputs}" do
        inputs.each do |input|
          input.should match regexp
        end
      end
      it "should not match the negatives: #{wildmat} !~ #{negatives}" do
        negatives.each do |input|
          input.should_not match regexp
        end
      end
    end
  end

  context 'backslash' do
    # Negative cases
    negatives = %w[ ab abd abcd ]
    # Positive cases
    [
      [ '\a\b\c', %w[ abc ] ],
      [ '\a\b\?', %w[ ab? ] ],
      [ '\a\b\[', %w[ ab\[ ] ],
    ].each do |wildmat,inputs|
      regexp = Wildmat.to_regexp(wildmat)
      it "should match: #{wildmat} =~ #{inputs}" do
        inputs.each do |input|
          input.should match regexp
        end
      end
      it "should not match: #{wildmat} != #{negatives}" do
        negatives.each do |input|
          input.should_not match regexp
        end
      end
    end
  end

  context 'asterisk' do
    # Test cases
    [
      [ 'a*b', %w[ ab aab abb a123b a_:-?=b ], %w[ ba aba ab123 123ab ] ],
      [ 'ab*', %w[ ab aba abb ab123 ab_:-?= ], %w[ ba bab 123ab a123b ] ],
      [ '*ab', %w[ ab aab bab 123ab _:-?=ab ], %w[ ba aba a123b ab123 ] ],
    ].each do |wildmat,inputs,negatives|
      regexp = Wildmat.to_regexp(wildmat)
      it "should match a single character: #{wildmat} =~ #{inputs}" do
        inputs.each do |input|
          input.should match regexp
        end
      end
      it "should not match the negatives: #{wildmat} != #{negatives}" do
        negatives.each do |input|
          input.should_not match regexp
        end
      end
    end
  end

  context 'character class' do
    # Test cases
    [
      [ '[a-z]',  %w[ a d z ], %w[ ab 0 - * ] ],
      [ '[0-9]',  %w[ 0 5 9 ], %w[ a 00 - * ] ],
      [ '[a-]',   %w[ a - ], %w[ b 0 a- * ] ],
      [ '[-a]',   %w[ a - ], %w[ b 0 -a * ] ],
      [ '[]0-9]', %w[ \] 5 ], %w[ \]0 a - * ] ],
    ].each do |wildmat,inputs,negatives|
      regexp = Wildmat.to_regexp(wildmat)
      it "should match: #{wildmat} =~ #{inputs}" do
        inputs.each do |input|
          input.should match regexp
        end
      end
      it "should not match: #{wildmat} != #{negatives}" do
        negatives.each do |input|
          input.should_not match regexp
        end
      end
    end
  end

  context 'negative character class' do
    # Test cases
    [
      [ '[^a-z]',  %w[ 0 - * ], %w[ a d z ab ] ],
      [ '[^0-9]',  %w[ a - * ], %w[ 0 5 9 00 ] ],
      [ '[^a-]',   %w[ b 0 * ], %w[ a - a- ]   ],
      [ '[^-a]',   %w[ b 0 * ], %w[ a - -a ]   ],
      [ '[^]0-9]', %w[ a - * ], %w[ \] 5 \]0 ] ],
    ].each do |wildmat,inputs,negatives|
      regexp = Wildmat.to_regexp(wildmat)
      it "should match: #{wildmat} =~ #{inputs}" do
        inputs.each do |input|
          input.should match regexp
        end
      end
      it "should not match: #{wildmat} != #{negatives}" do
        negatives.each do |input|
          input.should_not match regexp
        end
      end
    end
  end

end
