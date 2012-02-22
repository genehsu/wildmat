require "rspec"
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
      it "should match itself: #{input}" do
        input.should match Wildmat.to_regexp(input)
      end
      it "should not match an arbitrary string: #{input}" do
        bad_string.should_not match Wildmat.to_regexp(input)
      end
    end
  end

  context 'question mark' do
    # Negative cases
    negatives = %w[ abc nice caba ]
    # Positive cases
    [
      [ '?abc', %w[ 1abc aabc _abc .abc ] ],
      [ 'abc?', %w[ abc1 abcc abc_ abc. ] ],
      [ 'a??c', %w[ abzc a12c a_?c a.!c ] ],
    ].each do |wildmat,inputs|
      regexp = Wildmat.to_regexp(wildmat)
      it "should match a single character: #{wildmat}" do
        inputs.each do |input|
          input.should match regexp
        end
      end
      it "should not match the negatives: #{wildmat}" do
        negatives.each do |input|
          input.should_not match regexp
        end
      end
    end

  end

end
