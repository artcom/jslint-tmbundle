# JSLint TextMate Bundle

![Example Session](jslint-tmbundle/blob/master/Support/images/screenshots/errors.png "Listing hurt feelings")

* Allows jslinting saved files with Crockford's JSLint.

* Activate by using `CTRL+ALT+C`

* Also generates reports on full data returned by JsLint

  ![Functions](jslint-tmbundle/blob/master/Support/images/screenshots/functions.png "Functions")

## Installation

Install by cloning into:

    ~/Library/Application Support/TextMate/Bundles/JSLINT.tmbundle
  
or cloning somewhere else and symlinking it there.

## TextMate & rvm

It is possible to create an environment for rvm in textmate by following the
instructions on [rvm homepage].

The TM_RUBY will then be used automatically by the bundle. Otherwise the 
system ruby will be used.

## Syntax highlighting support

The gem [coderay] can be used (optionally) to highlight code.

![Highlighted Source](jslint-tmbundle/blob/master/Support/images/screenshots/source.png "Example source listing")

## .jslintrc support

This bundle supports using '~/.jslintrc'. Recommended Settings:

    /*jslint infixin: true, nomen:true, sloppy: true, vars: true, white: true, forin: true, plusplus: true, continue: true, bitwise: true */

![Settings](jslint-tmbundle/blob/master/Support/images/screenshots/settings.png "Detected Settings")

## References & Attributions

* This bundle uses a [fork] of jslint.

  *Note*: `infixin` is a custom setting disabling the 'in' operator checks.

* Uses Jquery and Jquery-ui

## Development setup

The bundle uses rspec and guard for development. The requires gems can be
installed by bundler with the supplied Gemfile.

- - -
*Copyright (c) ART+COM AG, Berlin Germany 2012 - Author: Andreas Marr (andreas.marr@artcom.de)*

  [rvm homepage]: https://rvm.io/integration/textmate/
  [fork]: https://github.com/artcom/JSLint
  [coderay]: https://github.com/rubychan/coderay