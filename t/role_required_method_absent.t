use strict;
use Test::Lib;
use Test::Most;
use Minion;

{
    package SorterRole;

    our %__Meta = (
        role => 1,
        requires => { methods => ['cmp'] }
    );

    sub sort {
        my ($self, $items) = @_;
        my $cmp = sub { $self->cmp(@_) };
        return sort $cmp @$items;
    }
}

{
    package SorterImpl;

    our %__Meta = (
    );
}

{
    package Sorter;

    our %__Meta = (
        interface => [qw( sort )],
        roles => [qw( SorterRole )],
    );
}

package main;

throws_ok {
    Minion->minionize(\ %Sorter::__Meta);
} qr/Method 'cmp', required by role SorterRole, is not implemented./;

done_testing();