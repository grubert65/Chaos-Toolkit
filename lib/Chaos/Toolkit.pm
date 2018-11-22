package Chaos::Toolkit;

use 5.006;
use Moo;
use Types::Standard qw( Str HashRef );
use Time::HiRes     'gettimeofday';
use JSON::XS        'decode_json';
use Log::Log4perl;
use Try::Tiny;

has 'experiment_file' => ( is => 'rw', isa => Str, required => 1 );
has 'experiment' => (
    is      => 'ro',
    isa     => HashRef,
    writer  => '_set_experiment',
    default => sub { {} }
);
has 'log' => (
    is      => 'rw',
    lazy    => 1,
    default => sub { return Log::Log4perl->get_logger( __PACKAGE__ ) }
);


sub BUILD {
    my $self = shift;

    die "Experiment file $self->{experiment_file} not found or not readable\n" 
        unless -f $self->{experiment_file};
    {
        local $/;
        open my $fh, "<$self->{experiment_file}"
            or die "Error opening file $self->{experiment_file}: $!\n";
        my $json_str=<$fh>;
        $self->_set_experiment( decode_json( $json_str ) );
        close $fh;
    }
}

#=============================================================

=head2 run_actions

=head3 INPUT

=head3 OUTPUT

1 or die in case or errors

=head3 DESCRIPTION

Tries to run all actions defined

=cut

#=============================================================
sub run_actions {
    my $self = shift;

    foreach my $action ( @{$self->experiment->{actions}} ) {
        $self->log->info("[".gettimeofday."][ACTION START]: $action->{func}");
        if ( $action->{module} ) {
            $DB::single=1;
            eval "use $action->{module};";
            die "Module $action->{module} not loadable\n" unless ( $@ ne '1');
            my $o = $action->{module}->new( $action->{constructor_attributes} );
            my $func = $action->{func};
            try {
                die "Error: method $func not implemented by class $action->{module}\n"
                    unless $o->can( $func );
                my $attrs = $action->{attributes};
                if (ref $attrs eq 'ARRAY') {
                    if (@$attrs == 1 ) {
                        $o->$func( $attrs->[0] );
                    } else {
                        $o->$func( $attrs );
                    }
                } else {
                    $o->$func( $attrs );
                }
            } catch {
                $self->log->error($_);
            }
        } else {
            my $func = $action->{func};
            eval "$func( @{$action->{attributes}})";
            if ( $@ ) {
                $self->log->error("Error executing $func: $@");
            }
        }
        $self->log->info("[".gettimeofday."][ACTION END]: $action->{func}");
    }

    return 1;
}



1;

__END__

=head1 NAME

Chaos::Toolkit - The great new Chaos::Toolkit!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Chaos::Toolkit;

    my $foo = Chaos::Toolkit->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 function1

=cut

sub function1 {
}

=head2 function2

=cut

sub function2 {
}

=head1 AUTHOR

Marco Masetti, C<< <grubert65 at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-chaos-toolkit at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Chaos-Toolkit>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Chaos::Toolkit


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Chaos-Toolkit>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Chaos-Toolkit>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Chaos-Toolkit>

=item * Search CPAN

L<http://search.cpan.org/dist/Chaos-Toolkit/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2018 Marco Masetti.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of Chaos::Toolkit
