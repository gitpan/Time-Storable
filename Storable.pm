package Time::Storable;
use Time::JulianDay;
use Time::Local;
use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qw(Exporter AutoLoader);
@EXPORT = qw(storable local_storable );
$VERSION = '0.1';

sub storable	{
	my ($sec, $min, $hour, $day, $month, $year) = @_;
	my ($jd, $timestamp, $storable);

	$jd = julian_day($year, $month, $day);
	$timestamp = timelocal($sec, $min, $hour, 1,0,0);
	$storable = $jd . '.' . $timestamp;
	return $storable;
}

sub local_storable {
	my ($timestamp)	= @_;
	$timestamp ||= time;
	my ($sec, $min, $hour, $day, $month, $year) =
		 (localtime($timestamp))[0,1,2,3,4,5];
	$month++;
	return storable($sec, $min, $hour, $day, $month, $year);
}
1;
__END__

=head1 NAME

Time::Storable - Store times in a portable format

=head1 SYNOPSIS

  use Time::Storable;

=head1 DESCRIPTION

The idea is to provide some format for storing dates - particularly
dates that fall outside of the epoch - that is, either before 1970,
or after 2038. This is a combination of Time::JulianDay type dates,
and regular epoch time type time stamps.

The time is stored in a single format, rather than in two numbers,
for simplicity of putting this in a database. This module
provides a full set of tools for getting useful information out
of this time storage format, so that it is not a burden to put it
in this format.

The time format used here is just experimental. I'm not sure if this
is the best way do to things or not. It's susceptible to rounding
error if you treat it like a number. But the whole point of making
it look like a number was specifically so that you can put it in
numerical database fields, rather than having to put it in a string
field.

Please let me know what you think about this, and I'll incorporate
ideas into the next version.

Eventually there will be convenient ways to get seconds, minutes,
hours, days, months, years out of a Time::Storable string. Perhaps
even this evening.

=head1 AUTHOR

Rich Bowen <rbowen@rcbowen.com>

=head1 SEE ALSO

perl(1).

=cut
