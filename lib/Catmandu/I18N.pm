package Catmandu::I18N;
use Catmandu::Sane;
use Catmandu::Util qw(:check :is :array);
use Catmandu;
use Data::Dumper;
use Catmandu::Error;
use Moo;

has config => (
    is => "ro",
    isa => sub { check_hash_ref( $_[0] ); },
    lazy => 1,
    coerce => sub {
        my $c = $_[0];
        return $c if is_hash_ref($c);
        if( is_string($c) ){

            $c = Catmandu::Util::data_at( $c, Catmandu->config() );

        }
        $c;
    },
    required => 1
);

has on_failure => (
    is => "ro",
    isa => sub {
        check_string( $_[0] ) && array_includes([qw(undef auto die)],$_[0]) ||
        die("should be either 'undef','auto' or 'die'");
    },
    lazy => 1,
    default => sub { "undef"; }
);

has handle => (
    is => "lazy",
    init_arg => undef
);

our $IDX = 0;

sub _build_handle {

    my $self = $_[0];

    my $c = Data::Dumper->new( [$self->config()] )->Deepcopy(1)->Indent(0)->Dump();
    $c = substr( $c, index($c, "{" ) );
    $c =~ s/;$//o;
    my $package_name = "Catmandu::I18N::_Handle::$IDX";
    my $perl = <<EOF;
package $package_name;
use Catmandu::Sane;
use parent "Locale::Maketext";
use Locale::Maketext::Lexicon $c;
EOF
    if($self->on_failure() eq "auto"){

        $perl .= <<EOF;
our %Lexicon;
\$Lexicon{_AUTO} = 1;
EOF

    }

    $perl .= "1;";

    eval $perl or Catmandu::Error->throw( $@ );

    $IDX++;

    $package_name;

}

sub t {
    my( $self, $lang, @args ) = @_;
    Catmandu::Error->throw( "no lang provided" ) unless is_string( $lang );
    my $lh = $self->handle()->get_handle( $lang );
    Catmandu::Error->throw( "unable to find handle for language $lang" ) unless defined( $lh );
    $lh->fail_with(sub {}) if $self->on_failure() eq "undef";
    $lh->maketext( @args );
}

our $VERSION = "0.01";

=encoding utf8

=head1 NAME

Catmandu::I18N - tools for text localisation

=begin markdown

# STATUS

[![Build Status](https://travis-ci.org/LibreCat/Catmandu-I18N.svg?branch=master)](https://travis-ci.org/LibreCat/Catmandu-I18N)
[![Coverage](https://coveralls.io/repos/LibreCat/Catmandu-I18N/badge.png?branch=master)](https://coveralls.io/r/LibreCat/Catmandu-I18N)
[![CPANTS kwalitee](https://cpants.cpanauthors.org/dist/Catmandu-I18N.png)](https://cpants.cpanauthors.org/dist/Catmandu-I18N)

=end markdown

=head1 SYNOPSIS

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

=head1 CONSTRUCTOR ARGUMENTS

=over

=item config

Configuration for Locale::Maketext.

Must be either:

* hash reference

* string (e.g. "i18n")

When the config is a string, it is interpreted as the path to the I18N configuration in Catmandu config.

Required

=item on_failure

What to do when a lookup does not give a result.

Possible values:

* "undef" : return undef

* "auto" : return key itself. Always a result.

* "die" : die

Default: "undef"

Note: "undef" should be a string, as opposed to undef.

=back

=head1 AUTHORS

Nicolas Franck C<< <nicolas.franck at ugent.be> >>

=head1 SEE ALSO

L<Catmandu::Fix::i18n>, L<Catmandu>, L<Locale::Maketext>

=head1 LICENSE AND COPYRIGHT

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See L<http://dev.perl.org/licenses/> for more information.

=cut

1;
