# Zarby

[![Gem Version](https://badge.fury.io/rb/zarby.svg)](http://badge.fury.io/rb/zarby)

A library to Manipulate String with utiles methods.

## Installation

Run:

    bundle add zarby

Or install it yourself as:

    $ gem install zarby

## WARNING
:warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning:


V 0.1.6 (methods used wase depreciated and removed on 10/2024) for version (V 0.2.0)


:warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning: :warning:

## Usage

Three module are available: CSV, Normelize And Anonymize

### CSV

```ruby
detect_separator(content|string)
```

Method to detecte delimiter in csv!

Since V 0.1.6 (depreciated and removed on 10/2024) :warning: :warning: :warning: :warning: :warning: :warning::warning: :warning: :warning:

```ruby
Zarby::Csv.detect_separator("aa,bb,cc") # => ","
Zarby::Csv.detect_separator("aa;bb;cc") # => ";"
Zarby::Csv.detect_separator("aa,bb;cc,dd") # => ","
Zarby::Csv.detect_separator("aa;bb;cc,dd") # => ";"
```
Since V 0.1.7 :heart_eyes: :heart_eyes: :heart_eyes: :heart_eyes:

```ruby
Zarby.detect_separator("aa,bb,cc") # => ","
Zarby.detect_separator("aa;bb;cc") # => ";"
Zarby.detect_separator("aa,bb;cc,dd") # => ","
Zarby.detect_separator("aa;bb;cc,dd") # => ";"
```

`detect_separator`, render the separator, define in a csv on XXXX ms.
`[',', ';', ':', '|']`, is available by default.

### Normalize

```ruby
utf8(input|string)
```

Method to utf8 encode all caracters in a string (since widows , sweden enoding, etc ...).

Since V 0.1.6 (depreciated and removed on 10/2024) :warning: :warning: :warning: :warning: :warning: :warning::warning: :warning: :warning:

```ruby
Zarby::Normalize.utf8("Aa\xFCAa\xDF".force_encoding('Windows-1252')) # => "AaüAaß
# actually Windows-1252
Zarby::Normalize.utf8("Aa\xFCAa\xDF".force_encoding('ASCII-8BIT')) # => "AaüAaß"
# actually Windows-1252
Zarby::Normalize.utf8("Dur\xC3\xA9e".force_encoding('ASCII-8BIT')) # => "AaüAaß"

Zarby::Normalize.utf8("Aa\x80Aa\x81".force_encoding('ASCII-8BIT')) # => "AaüAaß"

```

Since V 0.1.7 :heart_eyes: :heart_eyes: :heart_eyes: :heart_eyes:

```ruby
Zarby.utf8("Aa\xFCAa\xDF".force_encoding('Windows-1252')) # => "AaüAaß
# actually Windows-1252
Zarby.utf8("Aa\xFCAa\xDF".force_encoding('ASCII-8BIT')) # => "AaüAaß"
# actually Windows-1252
Zarby.utf8("Dur\xC3\xA9e".force_encoding('ASCII-8BIT')) # => "AaüAaß"

Zarby.utf8("Aa\x80Aa\x81".force_encoding('ASCII-8BIT')) # => "AaüAaß"

```

### Anonymize

```ruby
anonymize(input|string, nb_chars|int \ 2, mask_with|string \ '*')
```

Method to anonymize a string.

```ruby
Zarby.anonymize("z") # => "**"
Zarby.anonymize("za") # => "**"
Zarby.anonymize("zar") # => "z*r"
Zarby.anonymize("zarb") # => "z**b"
Zarby.anonymize("zarby") # => "za*by"
Zarby.anonymize("mewtwo") # => "me**wo"
Zarby.anonymize("Ectoplasma") # => "Ec******ma"
```

`anonymize` try to set '\*' between two first and two last letter of the string if lenght greater than 4.
if string length between 1 to 2, return **.
if string length = 3 return a*a.
if string length = 4 return a**a.

if "@" is present, render `anonymize` string before and after "@", and kept "@" symbole.
exemple:

```ruby
Zarby.anonymize("z@z") # => "**@**"
Zarby.anonymize("za@za") # => "**@**"
Zarby.anonymize("zar@zar") # => "z*r@z*r"
Zarby.anonymize("zarb@zarb") # => "z**b@z**b"
Zarby.anonymize("zarby@zarby") # => "za*by@za*by"
Zarby.anonymize("mewtwo@mewtwo") # => "me**wo@me**wo"
Zarby.anonymize("Ectoplasma@Ectoplasma") # => "Ec******ma@Ec******ma"

## Using multiple "@"

Zarby.anonymize("pichu@pikachu@raichu") # => "pi*hu@pi***hu@ra**hu"
Zarby.anonymize("@fantominus@spectrum@ectoplasma@") # => "**@fa******us@sp****um@ec******ma"
```

## Contributing

Bug report and pull request are welcome on GitHub at https://github.com/zarby-ruby/zarby.
