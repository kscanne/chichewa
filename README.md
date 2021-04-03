
This repository contains some basic NLP resources for the Chichewa
language. Currently, all that's here is a basic lexicon
(in the folder `lexicon`) and a simple script for doing
morphological generation of verb forms: `scripts/gen.pl`.

Also potentially useful is the `makefile` in the `lexicon` directory,
which was a quick and dirty attempt to generate a very large
Chichewa word list as part of another project.

These scripts were written by @kscanne, with linguistic
advice from @ceekays.

There are better ways of doing all of this. A proper
morphological transducer would allow generation and
analysis and would be much faster as well.

The lexicon files are organized by part of speech.
A file named `nA-B.txt` should contain nouns from class A
whose plurals are in class B.  If B==x, then the noun
has no plural form.

The script `gen.pl` is designed to work in a pipeline. It reads
in lines that look like this:

	NM+SM+TM+OM^kangaz^AM

and outputs all possible surface forms with the given root:

	akangaza (++a1++^kangaz^a+)
	achikangaza (++a1++chi^kangaz^a+)
	aikangaza (++a1++i^kangaz^a+)
	akakangaza (++a1++ka^kangaz^a+)
	alikangaza (++a1++li^kangaz^a+)
	amukangaza (++a1++mu^kangaz^a+)
	...

The morphological elements NM,SM,TM, etc. are documented
in the script. Look at the various makefile targets to see
how it's used in practice.
