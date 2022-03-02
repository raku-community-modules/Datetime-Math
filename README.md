[![Actions Status](https://github.com/raku-community-modules/Datetime-Math/workflows/test/badge.svg)](https://github.com/raku-community-modules/Datetime-Math/actions)

NAME
====

Datetime::Math - Add common math operations to DateTime objects

SYNOPSIS
========

```raku
use Datetime::Math;

# Given $dt1 and $dt2 are both DateTime objects.
my $days = from-seconds($dt2 - $dt1, 'd');
say "The events where $days days apart";

my $target = $dt1 + to-seconds(1, 'M');
say "One month after $dt1 would be $target";

my $hours = duration-from-to(3, 'y', 'h');
say "3 years contains $hours hours.";
```

DESCRIPTION
===========

Provides `to-seconds()`, `from-seconds()`, `duration-from-to()` and the ability to perform certain math operations on DateTime objects.

The math functions allowed are:

  * Seconds = DateTime + DateTime

  * Seconds = DateTime - DateTime

  * DateTime = DateTime + Seconds

  * DateTime = DateTime - Seconds

SUBROUTINES
===========

to-seconds
----------

Takes a value and a unit indicator and converts the value to seconds.

The value must be a number, the unit string must be one of:

    's'  Seconds, this is redundant it returns the string without the 's'.
    'm'  Minutes, so 1m will return 60.
    'h'  Hour,    so 1h will return 3600.
    'd'  Day,     so 1d will return 86400.
    'w'  Week,    so 1w will return 604800.
    'M'  Month,   so 1M will return 2592000. This is based on 30 days.
    'y'  Year,    so 1y will return 31449600. Uses a round 365 days.

The Month estimation is not very accurate as it assumes 30 days regardless of month, if you need more accuracy, use a day count instead.

The Year estimation is based on a round 365 days, and does not take into account leap years or anything else. Again, if you need more accuracy, use a smaller unit.

from-seconds
------------

Takes a value in seconds and converts it into the specified unit.

The value and unit must be specified using the same rules as `to-seconds()`.

duration-from-to
----------------

Takes a value, the unit string the value is currently in, and the unit string you want to covert the value to. The value and units must be specified using the same rules as `to-seconds()`.

AUTHOR
======

Timothy Totten

CONTRIBUTIONS BY
================

Clifton Wood

COPYRIGHT AND LICENSE
=====================

Copyright 2013 - 2017 Timothy Totten

Copyright 2018 - 2022 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

