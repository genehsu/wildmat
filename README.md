= wildmat

* https://github.com/genehsu/wildmat

== DESCRIPTION:

This is a gem to create regexp objects from wildmat patterns

All wildmat patterns match an entire string. The pattern matching
operations are as follows: (from wikipedia http://en.wikipedia.org/wiki/Wildmat)

* Asterisk (*) to match any sequence of zero or more characters.
* Question mark (?) to match any single character.
* Set of specified characters. It is specified as a list of characters, or as a range of characters where the beginning and end of the range are separated by a minus (or dash) character, or as any combination of lists and ranges. The dash can also be included in the set as a character if it is the beginning or end of the set. This set is enclosed in square brackets. The close square bracket (]) may be used in a set if it is the first character in the set.
* Negation of a set. It is specified the same way as the set with the addition of a caret character (^) at the beginning of the test string just inside the open square bracket.
* Backslash (\) character to invalidate the special meaning of the open square bracket ([), the asterisk, backslash or the question mark. Two backslashes in sequence will result in the evaluation of the backslash as a character with no special meaning.

== FEATURES/PROBLEMS:

* FIX (list of features or problems)

== SYNOPSIS:

  FIX (code sample of usage)

== REQUIREMENTS:

* wildmat gem

== INSTALL:

* FIX (sudo gem install, anything else)

== DEVELOPERS:

After checking out the source, run:

  $ rake newb

This task will install any missing dependencies, run the tests/specs,
and generate the RDoc.

== LICENSE:

(The MIT License)

Copyright (c) 2012 Gene Hsu

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
