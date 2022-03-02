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

