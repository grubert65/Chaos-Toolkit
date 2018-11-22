# Chaos-Toolkit
A very simple chaos toolkit engine

# Description
This module provides a cli (chaos.pl) to run simple Chaos Engineering experiments declared in a JSON file.

# Installation

To install this module, run the following commands:

	perl Makefile.PL
	make
	make test
	make install

# Support and documentation

After installing, you can find documentation for this module with the
perldoc command.

    perldoc Chaos::Toolkit



# Experiment file description
The JSON file data model is loosely based on the chaos-toolkit project, basically eacy experiment is split into 3 sections:

- A steady_state section where the steady state conditions for your system are declared
- A list of actions/probes to be executed at a given time
- A list of rollback actions in case the experiment is is aborted


# Releases
Release 0.0.1 is only able to run actions based on perl functions, attributes description:

-   actions: the list of actions
-   type: the action provider, for this release only "perl" is accepted
-   module: the perl module to use, defaults to undef for core Perl functions
-   module_attributes: attributes to pass at object construction time ( a scalar/HashRef/ArrayRef)
-   func: the module function to call
-   attributes: attributes to pass to the function ( a scalar/HashRef/ArrayRef)



# LICENSE AND COPYRIGHT

Copyright (C) 2018 Marco Masetti

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

http://www.perlfoundation.org/artistic_license_2_0



