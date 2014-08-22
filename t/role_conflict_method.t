use strict;
use Test::Lib;
use Test::Most;
use Minion;

{
    package Camper;

    our %__Meta = (
        role => 1,
    );

    sub pitch {
        my ($self) = @_;
    }
}

{
    package BaseballPro;

    our %__Meta = (
        role => 1,
    );

    sub pitch {
        my ($self) = @_;
    }
}

{
    package BusyDude;

    our %__Meta = (
        interface => [qw( pitch )],
        roles => [qw( Camper BaseballPro )],
    );
}
package main;

throws_ok {
    Minion->minionize(\ %BusyDude::__Meta);
} qr/Cannot have 'pitch' in both BaseballPro and Camper/;

done_testing();