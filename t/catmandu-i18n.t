use strict;
use warnings;
use utf8;
use Test::More;
use Test::Exception;
use File::Spec;

my $pkg;
BEGIN {
    $pkg = 'Catmandu::I18N';
    use_ok $pkg;
}
require_ok $pkg;

{
    my $i;
    my $config = {
        nl => [ Gettext => File::Spec->catfile("t","po","nl.po") ],
        en => [ Gettext => File::Spec->catfile("t","po","en.po") ]
    };

    lives_ok(sub {

        $i = $pkg->new( config => $config );

    },"i18n created");

    is( $i->t( "nl", "mail_subject" ), "Overzicht van uw huidige ontleningen" );
    is( $i->t( "en", "mail_subject" ), "Summary of your current loans at the library" );

    is( $i->t( "nl", "mail_greeting", "Nicolas" ), "Geachte Nicolas" );
    is( $i->t( "en", "mail_greeting", "Nicolas" ), "Dear Nicolas" );

    is( $i->t( "nl", "mail_body", 1 ), "1 boek is nu te laat" );
    is( $i->t( "nl", "mail_body", 2 ), "2 boeken zijn nu te laat" );
    is( $i->t( "nl", "mail_body", 0 ), "0 boeken zijn nu te laat" );

    is( $i->t( "en", "mail_body", 1 ), "1 book is overdue now" );
    is( $i->t( "en", "mail_body", 2 ), "2 books are overdue now" );
    is( $i->t( "en", "mail_body", 0 ), "0 books are overdue now" );

    is( $i->t( "nl", "nonexistant_key" ), undef );

    $i = $pkg->new( config => $config, on_failure => "auto" );

    is( $i->t( "nl", "nonexistant_key" ), "nonexistant_key" );

    $i = $pkg->new( config => $config, on_failure => "die" );

    dies_ok(sub{

        $i->t( "nl", "nonexistant_key" );

    });

}

done_testing 16;
