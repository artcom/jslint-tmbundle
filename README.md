# JSLint TextMate Bundle

* Allows jslinting saved files with Crockford's JSLint.

* Activate by using `CTRL+ALT+C`

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

The gem `coderay` can be used (optionally) to highlight code.

## .jslintrc support

This bundle supports using '~/.jslintrc'. Recommended Settings:

    /*jslint infixin: true, nomen:true, sloppy: true, vars: true, white: true, forin: true, plusplus: true, continue: true, bitwise: true */

## References & Attributions

* This bundle uses a [fork] of jslint.

  *Note*: `infixin` is a custom setting disabling the 'in' operator checks.

* Uses Jquery and Jquery-ui

## Development setup

The bundle uses rspec and guard for development. The requires gems can be
installed by bundler with the supplied Gemfile.

  [rvm homepage]: https://rvm.io/integration/textmate/
  [fork]: https://github.com/artcom/JSLint