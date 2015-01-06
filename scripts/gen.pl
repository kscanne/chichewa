#!/usr/bin/perl

use strict;
use warnings;
use utf8;

binmode STDIN, ":utf8";
binmode STDOUT, ":utf8";
binmode STDERR, ":utf8";

my %morphemes = (
	'NM' => ['','si'], # negative marker
	'SM' => ['a1','a2','chi','i','ka','ku','li','mu','ndi','pa','ti','u','zi'], # subject markers
	'SSM' => ['m','chi','i','ka','ku','li','mu','pa','u'], # singular subject markers for use with numbers (so 'ndi' unnec.)
	'PLSM' => ['m','a','i','ti','zi'], # plural subject markers for use with numbers (so no 'mu' needed); 'm' is for class 1 mass nouns like "buledi msanu"
	'TM' => ['','a','da','dza','dzi','ku','ma','na','nka','ka','kadza','ta','kama','kana','kada','sana','zi'],  # tense marker; TM is omitted in a couple of cases: "present simple"... ndipita = I will go, presently; in wishes: mupite = you should go; ka/kadza mark "future possibilities": "akafika/akadzafika" = "if they arrive"; 'ta' = 'after', so "nditaona" = "after I saw"; 'kama' for "whenever"; 'zi' for "should"
	'LITM' => ['','na'], # tense markers permitted with verb -li
	'NTM' => ['','da','dza','dzi','ku','ma','na','nka','ka','kadza','ta','kama','kana','kada','sana'],  # tense markers for negative verbs (no perfect 'a')
	'DIR' => ['','dza','ka'],
	'OM' => ['','chi','i','ka','li','mu','ti','u','wa','zi'],	# object markers
	# 'VR' => [''],   # verbal roots read from a file
	'AM' => ['a'], # aspect marker; other cases handled with long-distance dependency rules
	'OF' => ['a','cha','ka','kwa','la','mwa','pa','ta','wa','ya','za'],
	'AKU' => ['o','cho','ko','lo','mo','po','to','wo','yo','zo'], # for verbal adjectives, contracted form of OF+ku
	'MWE' => ['nde','we','ye','o','cho','ko','lo','mo','no','po','to','wo','yo','zo'], # for -mwe, -kha, -nse; ones above plus nde, we, ye, no from personal pronouns
	'ANY' => ['aliye','uliwo','chilicho','iliyo','lililo','kaliko','kuliko','palipo','mulimo'], # Maxson p. 165, with -nse meaning "every, all"
	'NA' => ['chi','e','i','ke','kwi','li','mwi','pe','ti','wi','zi'],
	'DBL' => ['wam','aa','wau','yai','lali','chachi','zazi','kaka','tati','kwaku','papa','mwamu'],  # double prefixes (OF+SM) for "pure" adjectives
	);

# kill tone marks, but leave w's alone
sub standardize {
	(my $str) = @_;
	for ($str) {
		tr/áéíóúÁÉÍÓÚâêîôûÂÊÎÔÛǎěǐǒǔǍĚǏǑǓ/aeiouAEIOUaeiouAEIOUaeiouAEIOU/;
	}
	return $str;
}

# Input like "+uuk+an+y+ik++iz+w+a+mo+"
# output is surface string
sub alternations {
	(my $str) = @_;

	my $copy = $str;

	for ($str) {
		s/\++/+/g;
		s/\+\^/^/g;
		s/\^\+/^/g;
		s/\+si\+([aiu][1-9]?[+^])/+s+$1+/;
		s/[12]//g;
	}
	if ($copy eq $str) {
		$str =~	s/[\^+]//g;
		return $str;
	}
	else {
		return alternations($str);
	}
}

sub generate {
	(my $arg) = @_;
	if ($arg =~ m/[\^+]([A-Z]+)[\^+]/) {
			my $code = $1;
			die "Illegal morpheme code: $code" unless (exists($morphemes{$code}));
			foreach my $str ( @{$morphemes{$code}} ) {
				my $copy = $arg;
				# long-distance dependencies
				if ($code eq 'NM' and $str ne '') {
					$copy =~ s/\+TM([+^])/+NTM$1/;
				}
				if ($code eq 'NTM' and $str =~ m/^(sana|[dn]a)$/ or
				    $code eq 'TM' and $str eq 'sana') {
					$copy =~ s/([+^])AM([+^])/$1e$2/; # negative, past tense => final vowel 'e'
				}
				if ($code eq 'TM' and $str eq '') {
					my $copy2 = $copy;
					$copy2 =~ s/([+^])AM([+^])/$1e$2/;
					$copy2 =~ s/([\^+])TM([\^+])/$1$2/;
					generate($copy2);
				}
				# can I do most of these with alternations at the end?
				if ($code eq 'TM' and $str eq 'a') {
					$copy =~ s/\+ndi\+TM([+^])/+nd+a$1/;
					$copy =~ s/\+ti\+TM([+^])/+t+a$1/;
					$copy =~ s/\+u\+TM([+^])/+w+a$1/;  # class 3,14
					$copy =~ s/\+mu\+TM([+^])/mw+a$1/;
					$copy =~ s/\+a1\+TM([+^])/+w+a$1/; # class 1
					$copy =~ s/\+a2\+TM([+^])/+a+$1/;  # class 2,6
					$copy =~ s/\+i\+TM([+^])/+y+a$1/;  # class 4,9
					$copy =~ s/\+li\+TM([+^])/+l+a$1/;
					$copy =~ s/\+chi\+TM([+^])/+ch+a$1/;
					$copy =~ s/\+zi\+TM([+^])/+z+a$1/; # class 8,10
					$copy =~ s/\+ka\+TM([+^])/+k+a$1/;
					$copy =~ s/\+ku\+TM([+^])/+kw+a$1/;  # class 15,17
					$copy =~ s/\+pa\+TM([+^])/+p+a$1/;
				}
				#$copy =~ s/(\+TM\+/$1e+/ if ($code eq 'TM' and $str eq 'a');  # affirmative subjunctive ends in 'e'
				$copy =~ s/([\^+])$code([\^+])/$1$str$2/;
				generate($copy);
			}
		}
	else {  # no more variables...
		my $op = standardize(alternations($arg));
		print "$op ($arg)\n";
	}
}

# input strings look like: NM+SM+TM+OM, etc. - see list above
# or else it's possible to hardcode in particular values for these
# if VR or a specific verb root is included, surround it by ^'s and not +'s
while (<STDIN>) {
	chomp;
	s/^/+/;
	s/$/+/;
	generate($_);
}

exit 0;
