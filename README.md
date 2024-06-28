# Zarby

[![Gem Version](https://badge.fury.io/rb/zarby.svg)](http://badge.fury.io/rb/zarby)

A library to Manipulate String with utiles methods.

## Installation

Run:

    bundle add monetize

Or install it yourself as:

    $ gem install monetize

## Usage


Three module are available: CSV, Normelize And Anonymize

### CSV

Method do detecte delimiter in csv!

Since V 0.1.6 (depreciated and removed on 10/2024)

```ruby
Zarby::CSV.detect_delimiter("aa,bb,cc") # => ","
Zarby::CSV.detect_delimiter("aa;bb;cc") # => ";"
Zarby::CSV.detect_delimiter("aa,bb;cc,dd") # => ","
Zarby::CSV.detect_delimiter("aa;bb;cc,dd") # => ";"
```
Since V 0.1.7 

```ruby
Zarby.detect_delimiter("aa,bb,cc") # => ","
Zarby.detect_delimiter("aa;bb;cc") # => ";"
Zarby.detect_delimiter("aa,bb;cc,dd") # => ","
Zarby.detect_delimiter("aa;bb;cc,dd") # => ";"
```

`detect_delimiter`, render the dilimter, define in a csv on XXXX ms.
`[',', ';', ':', '|']`, is available by default.

### Normelize

Method to utf8 encode all caracters in a string (since widows , sweden enoding, etc ...).

Since V 0.1.6 (depreciated and removed on 10/2024)

```ruby
Zarby.utf8("Aa\xFCAa\xDF".force_encoding('Windows-1252')) # => "AaüAaß
# actually Windows-1252
Zarby::Normalize.utf8("Aa\xFCAa\xDF".force_encoding('ASCII-8BIT')) # => "AaüAaß"
# actually Windows-1252
Zarby::Normalize.utf8("Dur\xC3\xA9e".force_encoding('ASCII-8BIT')) # => "AaüAaß"

Zarby::Normalize.utf8("Aa\x80Aa\x81".force_encoding('ASCII-8BIT')) # => "AaüAaß"

```

Since V 0.1.7

```ruby
Zarby.utf8("Aa\xFCAa\xDF".force_encoding('Windows-1252')) # => "AaüAaß
# actually Windows-1252
Zarby.utf8("Aa\xFCAa\xDF".force_encoding('ASCII-8BIT')) # => "AaüAaß"
# actually Windows-1252
Zarby.utf8("Dur\xC3\xA9e".force_encoding('ASCII-8BIT')) # => "AaüAaß"

Zarby.utf8("Aa\x80Aa\x81".force_encoding('ASCII-8BIT')) # => "AaüAaß"

```

### Anonymise

Method to anonymise a string.

```ruby
Zarby.anonymise("z") # => "**"
Zarby.anonymise("za") # => "**"
Zarby.anonymise("zar") # => "z*r"
Zarby.anonymise("zarb") # => "z**b"
Zarby.anonymise("zarby") # => "za*by"
arby.anonymise("mewtwo") # => "me**wo"
arby.anonymise("Ectoplasma") # => "Ec******ma"
```

`anonymise` try to set '*' between two first and two last letter of the string if lenght greater than 4.
if string length between 1 to 2, return **.
if string length = 3 return a*a.
if string length = 4 return a**a.

if "@" is present, render `anonymise` string before and after "@", and kept "@" symbole.
exemple:

```ruby
Zarby.anonymise("z@z") # => "**@**"
Zarby.anonymise("za@za") # => "**@**"
Zarby.anonymise("zar@zar") # => "z*r@z*r"
Zarby.anonymise("zarb@zarb") # => "z**b@z**b"
Zarby.anonymise("zarby@zarby") # => "za*by@za*by"
Zarby.anonymise("mewtwo@mewtwo") # => "me**wo@me**wo"
Zarby.anonymise("Ectoplasma@Ectoplasma") # => "Ec******ma@Ec******ma"
# Using multiple "@"
Zarby.anonymise("pichu@pikachu@raichu") # => "pi*hu@pi***hu@ra**hu"
Zarby.anonymise("@fantominus@spectrum@ectoplasma@") # => "**@fa******us@sp****um@ec******ma"
```