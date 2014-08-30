use strict;
use Test::Lib;
use Test::Most;
use Minion;

{
    package Alpha;

    our %__Meta = (
        role => 1,
        roles => [qw( Bravo Charlie )]
    );

    sub alpha { 'alpha' }
}

{
    package Bravo;

    our %__Meta = (
        role => 1,
        roles => [qw( Delta )]
    );

    sub bravo { 'bravo' }
}

{
    package Charlie;

    our %__Meta = (
        role => 1,
    );

    sub charlie { 'charlie' }
}

{
    package Delta;

    our %__Meta = (
        role => 1,
    );

    sub delta { 'delta' }
}

{
    package Alphabet;

    our %__Meta = (
        interface => [qw( alpha bravo charlie delta )],
        roles => [qw( Alpha )],
    );
    Minion->minionize;
}

package main;

my $ab = Alphabet->new;
can_ok($ab, qw( alpha bravo charlie delta ));
is($ab->alpha,   'alpha');
is($ab->bravo,   'bravo');
is($ab->charlie, 'charlie');
is($ab->delta,   'delta');

ok($ab->DOES('Alpha'),   'does Alpha role');
ok($ab->DOES('Bravo'),   'does Bravo role');
ok($ab->DOES('Charlie'), 'does Charlie role');
ok($ab->DOES('Delta'),   'does Delta role');

ok((ref $ab)->DOES('Alpha'),   'does Alpha role');
ok((ref $ab)->DOES('Bravo'),   'does Bravo role');
ok((ref $ab)->DOES('Charlie'), 'does Charlie role');
ok((ref $ab)->DOES('Delta'),   'does Delta role');

done_testing();
