package Locale::Maketext::Lexicon::CatmanduConfig;
use Catmandu::Sane;
use Catmandu;
use Catmandu::Util qw(data_at);
use Catmandu::Expander;

sub parse {
    my ($self, $key) = @_;say STDERR "reached ".__PACKAGE__;
    my $hash = Catmandu::Util::data_at( $key, Catmandu->config() );
    Catmandu::Expander->collapse_hash(
        is_hash_ref($hash) ? $hash : +{}
    );
}

1;

__END__

=pod

=head1 NAME

Locale::Maketext::Lexicon::CatmanduConfig - Use Catmandu config files as a Maketext lexicon

=head1 SYNOPSIS

    Catmandu->{config}{locale}{en} = {
        hello => "Hello",
    };

    package MyI18N;
    use parent 'Locale::Maketext';
    use Locale::Maketext::Lexicon {
        en => [ CatmanduConfig => "locale.en" ],
    };

=cut
