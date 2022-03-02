unit module DateTime::Math:ver<0.6.1>:auth<zef:raku-community-modules>;

my subset DurationUnits of Str where -> $unit { $unit ~~ /^<[smhdwMy]>$/ }

## to-seconds: takes a value and a unit string, and converts the value
#    into seconds.
#
#    The value must be a number, the unit string must be one of:
#
#     's'  Seconds, this is redundant it returns the string without the 's'.
#     'm'  Minutes, so 1m will return 60.
#     'h'  Hour,    so 1h will return 3600.
#     'd'  Day,     so 1d will return 86400.
#     'w'  Week,    so 1w will return 604800.
#     'M'  Month,   so 1M will return 2592000. This is based on 30 days.
#     'y'  Year,    so 1y will return 31449600. Uses a round 365 days.
#
#    The Month estimation is not very accurate as it assumes 30 days regardless
#    of month, if you need more accuracy, use a day count instead.
#
# The Year estimation is based on a round 365 days, and does not take into
# account leap years or anything else. Again, if you need more accuracy,
# use a smaller unit.
#
#
sub to-seconds ( Numeric $value, DurationUnits $in ) is export {
    do given $in {
        when 's' { $value }
        my $minute := $value * 60;
        when 'm' { $minute }
        my $hour := $minute * 60;
        when 'h' { $hour }
        my $day := $hour * 24;
        when 'd' { $day }
        when 'w' { $day * 7   }
        when 'M' { $day * 30  }
        when 'y' { $day * 365 }
    }
}

## from-seconds: takes a value in seconds and converts it into the
#    specified unit.
#
# The value and unit must be specified using the same rules as to-seconds().
#
sub from-seconds ( Numeric $value, DurationUnits $to ) is export {
    do given $to {
        when 's' { $value }
        my $minute := $value / 60;
        when 'm' { $minute }
        my $hour := $minute / 60;
        when 'h' { $hour }
        my $day := $hour / 24;
        when 'd' { $day }
        when 'w' { $day / 7   }
        when 'M' { $day / 30  }
        when 'y' { $day / 365 }
    }
}

## duration-from-to: takes a value, the unit string the value is currently in,
## and the unit string you want to covert the value to.
sub duration-from-to(
  Numeric:D $value, DurationUnits:D $in, DurationUnits:D $to
) is export {
    from-seconds to-seconds($value, $in), $to;
}

multi infix:<+>(DateTime:D $dt, Numeric:D $x) is export {
    $dt.WHAT.new($dt.Numeric + $x,
      :timezone($dt.timezone), :formatter($dt.formatter))
}

multi infix:<+>(Numeric:D $x, DateTime:D $dt) is export {
    $dt + $x
}

multi infix:«-»(DateTime:D $dt, Numeric:D $x) is export {
    $dt.WHAT.new($dt.Numeric - $x,
      :timezone($dt.timezone), :formatter($dt.formatter))
}

=begin pod

=head1 NAME

Datetime::Math - Add common math operations to DateTime objects

=head1 SYNOPSIS

=begin code :lang<raku>

use Datetime::Math;

# Given $dt1 and $dt2 are both DateTime objects.
my $days = from-seconds($dt2 - $dt1, 'd');
say "The events where $days days apart";

my $target = $dt1 + to-seconds(1, 'M');
say "One month after $dt1 would be $target";

my $hours = duration-from-to(3, 'y', 'h');
say "3 years contains $hours hours.";

=end code

=head1 DESCRIPTION

Provides C<to-seconds()>, C<from-seconds()>, C<duration-from-to()> and the ability
to perform certain math operations on DateTime objects.

The math functions allowed are:

=item Seconds = DateTime + DateTime
=item Seconds = DateTime - DateTime
=item DateTime = DateTime + Seconds
=item DateTime = DateTime - Seconds

=head1 AUTHOR

Timothy Totten

=head1 CONTRIBUTIONS BY

Clifton Wood

=head1 COPYRIGHT AND LICENSE

Copyright 2013 - 2017 Timothy Totten

Copyright 2018 - 2022 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
