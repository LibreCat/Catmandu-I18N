# NAME

Catmandu::I18N - tools for text localisation

# STATUS

[![Build Status](https://travis-ci.org/LibreCat/Catmandu-I18N.svg?branch=master)](https://travis-ci.org/LibreCat/Catmandu-I18N)
[![Coverage](https://coveralls.io/repos/LibreCat/Catmandu-I18N/badge.png?branch=master)](https://coveralls.io/r/LibreCat/Catmandu-I18N)
[![CPANTS kwalitee](http://cpants.cpanauthors.org/dist/Catmandu-I18N.png)](http://cpants.cpanauthors.org/dist/Catmandu-I18N)

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

    Must be hash reference.

    Required

- on\_failure

    What to do when a lookup does not give a result.

    Possible values:

    \* "undef" : return undef

    \* "auto" : return key itself. Always a result.

    \* "die" : die

    Default: "undef"

    Note: "undef" should be a string, as opposed to undef.

# AUTHORS

Nicolas Franck `<nicolas.franck at ugent.be>`

# SEE ALSO

[Catmandu](https://metacpan.org/pod/Catmandu), [Locale::Maketext](https://metacpan.org/pod/Locale::Maketext)

# LICENSE AND COPYRIGHT

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See [http://dev.perl.org/licenses/](http://dev.perl.org/licenses/) for more information.
