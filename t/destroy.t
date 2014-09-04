use strict;
use Test::Lib;
use Test::Most;
use Minion;

{
    package ProcessImpl;

    our %__Meta = (
        role => 1,
        has => { id => { reader => 1 } }
    );
    
    our $Count = 0;

    sub BUILD {
        my (undef, $self) = @_;

        $self->{__id} = ++$Count;
    }
    
    sub DESTROY {
        my ($self) = @_;
        --$Count;
    }
}

{
    package Process;

    our %__Meta = (
        interface => [qw( id )],
        implementation => 'ProcessImpl',
    );
    Minion->minionize;
}

package main;

for ( 1 .. 3 ) {
    my $proc = Process->new();
    is($proc->id, 1);
}
is($ProcessImpl::Count, 0);

done_testing();