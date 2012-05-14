# JSLint TextMate Bundle

Another [JSLint] Bundle for [TextMate].

<!--
[![Build Status](https://secure.travis-ci.org/monolar/jslint-tmbundle.png?branch=master)](http://travis-ci.org/monolar/jslint-tmbundle)
-->

## Why?

There are many JSLint Bundles out there which may be prettier but they all lack functionality.
Most Bundles only report on errors on lines and thats it.
This bundle takes advantage of the full returned data by JSLint, incl. listed globals and more.
It also has `.jslintrc` support which makes it compatible with the [jslint.vim] vim-plugin.
This is important for teams working on stuff.

Example Session:

![Example Session](https://github.com/artcom/jslint-tmbundle/raw/master/Support/images/screenshots/errors.png)

## Features

* Allows jslinting saved files with Crockford's JSLint.

* Activate by using `CTRL+ALT+C`

* `.jslintrc`-support

* Also generates reports on full data returned by JsLint

  ![Functions](https://github.com/artcom/jslint-tmbundle/raw/master/Support/images/screenshots/functions.png)

## Installation

Install by cloning:

    $ cd ~/Library/Application\ Support/TextMate/Bundles/
    $ git clone git://github.com/artcom/jslint-tmbundle.git JSLINT.tmbundle
    $ osascript -e 'tell app "TextMate" to reload bundles'

or cloning somewhere else and symlinking it there.

## TextMate & rvm

It is possible to create an environment for rvm in textmate by following the
instructions on [rvm homepage].

The TM_RUBY will then be used automatically by the bundle. Otherwise the 
system ruby will be used.

## Syntax highlighting support

The gem [coderay] can be used (optionally) to highlight code.

![Highlighted Source](https://github.com/artcom/jslint-tmbundle/raw/master/Support/images/screenshots/source.png)

## .jslintrc support

This bundle supports using '~/.jslintrc'. Recommended Settings:

    /*jslint infixin: true, nomen:true, sloppy: true, vars: true, white: true, forin: true, plusplus: true, continue: true, bitwise: true */

![Settings](https://github.com/artcom/jslint-tmbundle/raw/master/Support/images/screenshots/settings.png)

## References & Attributions

* This bundle uses a [fork] of jslint.

  *Note*: `infixin` is a custom setting disabling the 'in' operator checks.

* Uses Jquery and Jquery-ui

* Uses [Silk Icon Set] 1.3

* Uses [qtip]

## Development setup

The bundle uses [rspec] and [guard] for development. The required gems can be
installed by [bundler] with the supplied Gemfile.

- - -
*Copyright (c) [ART+COM AG](http://www.artcom.de/), Berlin Germany 2012 - Author: Andreas Marr (andreas.marr@artcom.de)*

  [JSLint]: https://github.com/douglascrockford/JSLint
  [jslint.vim]: https://github.com/hallettj/jslint.vim.git
  [TextMate]: http://macromates.com/
  [rvm homepage]: https://rvm.io/integration/textmate/
  [fork]: https://github.com/artcom/JSLint
  [coderay]: https://github.com/rubychan/coderay
  [Silk Icon Set]: http://www.famfamfam.com/lab/icons/silk/
  [qtip]: http://craigsworks.com/projects/qtip/
  [rspec]: http://rspec.info/
  [guard]: https://github.com/guard/guard
  [bundler]: http://gembundler.com/
