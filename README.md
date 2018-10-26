# NAME

Catmandu::I18N - tools for text localisation

# STATUS

[![Build Status](https://travis-ci.org/LibreCat/Catmandu-I18N.svg?branch=master)](https://travis-ci.org/LibreCat/Catmandu-I18N)
[![Coverage](https://coveralls.io/repos/LibreCat/Catmandu-I18N/badge.png?branch=master)](https://coveralls.io/r/LibreCat/Catmandu-I18N)
[![CPANTS kwalitee](https://cpants.cpanauthors.org/dist/Catmandu-I18N.png)](https://cpants.cpanauthors.org/dist/Catmandu-I18N)

# SYNOPSIS

    use Catmandu::Sane;

    use Catmandu::I18N;

    my $i = Catmandu::I18N->new(
        config => {
            en => [
              "Gettext",
              "/path/to/en.po"
            ],
            nl => [
              "Gettext",
              "/path/to/nl.po"
            ]
        }
    );

    $i->t( "my-lang", "my-key" );
    $i->t( "my-lang", "my-key2", "arg-1", "arg-2" );

# CONSTRUCTOR ARGUMENTS

- config

    Configuration for Locale::Maketext.

    Must be either:

    \* hash reference

    \* string (e.g. "i18n")

    When the config is a string, it is interpreted as the path to the I18N configuration in Catmandu config.

    Required

- on\_failure

    What to do when a lookup does not give a result.

    Possible values:

    \* "undef" : return undef

    \* "auto" : return key itself. Always a result.

    \* "die" : die

    Default: "undef"

    Note: "undef" should be a string, as opposed to undef.

- fallback\_languages

    array of fallback language codes

    \* must be array reference

    \* default is \[ "i-default","en","en-US" \] as determined by [Locale::Maketext](https://metacpan.org/pod/Locale::Maketext)

    When [Locale::Maketext](https://metacpan.org/pod/Locale::Maketext) does not find the specified language in your config, it
    will fallback to one of these, and then load the handle for that.

    Only if that fallback language does not exist in the config, will it fail.

    Example 1:

    fallback\_languages is \[ "en" \]

    you have only language "en" in your config, but you request language "nl",
    then you'll get the message in English.

    Example 2:

    fallback\_languages is \[ "en" \]

    you have only language "nl" in your config, but you request language "fr",
    then the creation of the message will fail

    You can set this to an empty array for consistent behaviour.

# NOTES

\* the lexicon implementation determines the format of the message.

e.g. only [Locale::Maketext::Lexicon::Gettext](https://metacpan.org/pod/Locale::Maketext::Lexicon::Gettext) supports placeholders like %1.

For other implementations you need to use placeholders like \[\_1\]

# AUTHORS

Nicolas Franck `<nicolas.franck at ugent.be>`

# SEE ALSO

[Catmandu::Fix::i18n](https://metacpan.org/pod/Catmandu::Fix::i18n), [Locale::Maketext::Lexicon::CatmanduConfig](https://metacpan.org/pod/Locale::Maketext::Lexicon::CatmanduConfig), [Catmandu](https://metacpan.org/pod/Catmandu), [Locale::Maketext](https://metacpan.org/pod/Locale::Maketext)

# LICENSE AND COPYRIGHT

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See [http://dev.perl.org/licenses/](http://dev.perl.org/licenses/) for more information.
