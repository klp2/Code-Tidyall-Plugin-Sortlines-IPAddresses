use strict;
use warnings;

package Code::TidyAll::Plugin::SortLines::IPAddresses;

use Moo;
extends 'Code::TidyAll::Plugin';

use Net::Works::Address;

sub transform_source {
    my ( $self, $source ) = @_;

    return
        # join( "\n", $collator->sort( grep {/\S/} split( /\n/, $source ) ) )
        # . "\n";
        join( "\n", map { $_->[0] } sort { $a->[1] <=> $b->[1] } map { [ $_, eval { Net::Works::Address->new_from_string( string => $_ )->as_integer } ] } grep {/\S/} split( /\n/, $source ) )
        . "\n";
}

1;
__END__

# ABSTRACT: Sort lines of a file containing IP addresses

=pod

=head1 SYNOPSIS

   # In configuration:

   [SortLines::IPAddresses]
   select = file_with_ips

=head1 DESCRIPTION

Sorts the lines of a file containing ip addresses, one per line. Whitespace lines are
discarded.

=head1 ACKNOWLEDGEMENTS

This code was essentially pilfered from L<Code::TidyAll::Plugin::SortLines>

=cut
