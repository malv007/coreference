# Coreference

This Gem provides coreference resolution for various languages (en, es, it, nl,
de, fr).

The CorefGraph module provides an implementation of the Multi-Sieve Pass system
for for Coreference Resolution system originally proposed by the Stanford NLP
Group (Lee et al., 2013). This system proposes a number of deterministic passes,
ranging from high precision to higher recall, each dealing with a different
manner in which coreference manifests itself in running text.

Although more sieves are available, in order to facilitate the integration of
the coreference system for the 6 languages of OpeNER we have included here 4
sieves: Exact String Matching, Precise Constructs, Strict Head Match and Pronoun
Match (the sieve nomenclature follows Lee et al (2013). Furthermore, as it has
been reported, this sieves are responsible for most of the performance in the
Stanford system.

The implementation is a result of a collaboration between the IXA NLP
<http://ixa.si.ehu.es> and LinguaMedia Groups <http://linguamedia.deusto.es>.

## Confused by some terminology?

This software is part of a larger collection of natural language processing
tools known as "the OpeNER project". You can find more information about the
project at [the OpeNER portal](http://opener-project.github.io). There you can
also find references to terms like KAF (an XML standard to represent linguistic
annotations in texts), component, cores, scenario's and pipelines.

## Quick Use Example

Installing the coreference can be done by executing:

    gem install opener-coreference

Please keep in mind that all components in OpeNER take KAF as an input and
output KAF by default.

### Command line interface

You should now be able to call the coreference as a regular shell command: by
its name. Once installed the gem normalyl sits in your path so you can call it
directly from anywhere.

This aplication reads a text from standard input in order to identify the
language.

    cat some_kind_of_kaf_file.kaf | coreference

This will output:

    <coref coid="co5">
      <!--Her father-->
      <span>
        <target id="t45"/>
        <target id="t46"/>
      </span>
      <!--him-->
      <span>
        <target id="t58"/>
      </span>
      <!--his-->
      <span>
        <target id="t54"/>
      </span>
    </coref>

### Webservices

You can launch a language identification webservice by executing:

    coreference-server

This will launch a mini webserver with the webservice. It defaults to port 9292,
so you can access it at <http://localhost:9292>.

To launch it on a different port provide the `-p [port-number]` option like
this:

    coreference-server -p 1234

It then launches at <http://localhost:1234>

Documentation on the Webservice is provided by surfing to the urls provided
above. For more information on how to launch a webservice run the command with
the `--help` option.

### Daemon

Last but not least the coreference comes shipped with a daemon that can read
jobs (and write) jobs to and from Amazon SQS queues. For more information type:

    coreference-daemon -h

## Description of dependencies

This component runs best if you run it in an environment suited for OpeNER
components. You can find an installation guide and helper tools in the
[OpeNER installer](https://github.com/opener-project/opener-installer) and an
[installation guide on the Opener Website](http://opener-project.github.io/getting-started/how-to/local-installation.html)

At least you need the following system setup:

### Depenencies for normal use:

* Ruby (MRI) 1.9.3 or newer
* Python 2.6

## Adapting CorefGraph-en to your language

There are a number of changes needed to be made to make CorefGraph works for
other languages. Although we have try to keep the language dependent features to
a minimum, you will still need to create some dictionaries for your own language
and make some very minor changes in the code. Here is the list of very file in
the Corefgraph module that needs to be changed. Every change except one (see
below) to be done in the `$project/core/corefgraph/resources` directory:

* `dictionaries/$lang_determiners.py`
* `dictionaries/$lang_pronouns.py`
* `dictionaries/$lang_verbs.py`
* `dictionaries/$lang_stopwords.py`
* `dictionaries/$lang_temporals.py`

* `tagset/$TAGSETNAME_pos.py`
* `tagset/$TAGSETNAME_constituent.py`

* `files/animate/$lang.animate.txt`
* `files/animate/$lang.inanimate.txt`

* `files/demonym/$lang.txt`

* `files/gender/$lang.male.unigrams.txt`
* `files/gender/$lang.female.unigrams.txt`
* `files/gender/$lang.neutral.unigrams.txt`
* `files/gender/$lang.namegender.combine.txt`
* `files/gender/$lang.gender.data`

* `files/number/$lang.plural.unigrams.txt`
* `files/number/$lang.singular.unigrams.txt`

## The Core

The component is a fat wrapper around the actual language technology core. You
can find the core technolies in the following repositories:

* [Coreference-base](https://github.com/opener-project/coreference-base)

## Where to go from here

* [Check the project website](http://opener-project.github.io)
* [Checkout the webservice](http://opener.olery.com/coreference)

## Report problem/Get help

If you encounter problems, please email <support@opener-project.eu> or leave an
issue in the
[issue tracker](https://github.com/opener-project/coreference/issues).

## Contributing

1. Fork it <http://github.com/opener-project/coreference/fork>
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
