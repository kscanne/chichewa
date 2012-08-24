NOUNS=n1.txt n2.txt n3.txt n4.txt n5.txt n6.txt n7.txt n8.txt n9.txt n10.txt n12.txt n13.txt n14.txt n15.txt n16.txt n17.txt n18.txt
FILTER=../scripts/filterbad
GEN=../scripts/gen.pl

all.txt: $(NOUNS) verbs.txt verbs-infl.txt adjs.txt preps.txt poss.txt numbers.txt vadjs.txt rel.txt dem.txt interr.txt advs.txt
	cat $(NOUNS) verbs.txt verbs-infl.txt adjs.txt preps.txt poss.txt numbers.txt vadjs.txt rel.txt dem.txt interr.txt advs.txt | LC_ALL=C sort -u > $@

n1.txt: n1-2.txt n1-4.txt n1-6.txt n1-x.txt
	cat n1-2.txt n1-4.txt n1-6.txt n1-x.txt | LC_ALL=C sort -u > $@

n1-2-pl.txt: n1-2.txt
	cat n1-2.txt | sed "s/^m'phera/a&/; s/^m\(khiris\)/a\1/; s/^m\(phunzitsi\)/a\1/; s/^mwanawa/anaa/; s/^mwini/eni/; s/^wakutiw/akuti/; s/^[^aemw]/a&/; s/^muy/a&/; s/^m['u]/a/; s/^m[abo]/a&/; s/^m\([cdfgjlmnsz]\)/a\1/; s/^m\([kpt][^h]\)/a\1/; s/^m[kpt]h/a&/; s/^mwa/a/; s/^mwi/a&/; s/^w[^o]/a&/; s/^wo/o/" > just1-2.txt
	paste n1-2.txt just1-2.txt > $@
	rm -f just1-2.txt

n2.txt: n1-2-pl.txt
	cat n1-2-pl.txt | sed 's/^[^\t]*\t//' | LC_ALL=C sort -u > $@

n3.txt: n3-4.txt n3-x.txt
	cat n3-4.txt n3-x.txt | LC_ALL=C sort -u > $@

n1-4-pl.txt: n1-4.txt
	cat n1-4.txt | sed 's/^m/mi/' > just1-4.txt
	paste n1-4.txt just1-4.txt > $@
	rm -f just1-4.txt

n3-4-pl.txt: n3-4.txt
	cat n3-4.txt | sed "s/^m\([^owui']\)/mi\1/; s/^mw/miy/; s/^mo/miyo/; s/^m[u']/mi/; s/^[^m]/mi&/" > just3-4.txt
	paste n3-4.txt just3-4.txt > $@
	rm -f just3-4.txt

n4.txt: n1-4-pl.txt n3-4-pl.txt
	cat n1-4-pl.txt n3-4-pl.txt | sed 's/^[^\t]*\t//' | LC_ALL=C sort -u > $@

n5.txt: n5-6.txt n5-x.txt
	cat n5-6.txt n5-x.txt | LC_ALL=C sort -u > $@

n6.txt: n1-6.txt n5-6.txt n7-6.txt n14-6.txt nx-6.txt
	(cat nx-6.txt; cat n1-6.txt n5-6.txt n7-6.txt n14-6.txt | sed 's/^/ma/') | LC_ALL=C sort -u > $@

n7.txt: n7-8.txt n7-6.txt n7-x.txt
	cat n7-8.txt n7-6.txt n7-x.txt | LC_ALL=C sort -u > $@

n8.txt: n7-8.txt
	cat n7-8.txt | sed 's/^ch/z/' | LC_ALL=C sort -u > $@

n9.txt: n9-10.txt
	cat n9-10.txt | LC_ALL=C sort -u > $@

n10.txt: n9-10.txt
	cat n9-10.txt | LC_ALL=C sort -u > $@

n12.txt: n12-13.txt
	cat n12-13.txt | LC_ALL=C sort -u > $@

# probably shouldn't use these next three targets
# since they overgenerate wildly
n12-all-pl.txt: n1-2-pl.txt n1-4-pl.txt n3-4-pl.txt
	cat n1-2-pl.txt n1-4-pl.txt n3-4-pl.txt | sed 's/^/ka/; s/\t/&ti/' > $@

n12-all.txt: n12-all-pl.txt
	cat n12-all-pl.txt | sed 's/\t.*//' > $@

n13-all.txt: n12-all-pl.txt
	cat n12-all-pl.txt | sed 's/^[^\t]*\t//' > $@

n13.txt: n12-13.txt nx-13.txt
	(cat nx-13.txt; cat n12-13.txt | sed 's/^ka/ti/') | LC_ALL=C sort -u > $@

n14.txt: n14-6.txt n14-x.txt
	cat n14-6.txt n14-x.txt | LC_ALL=C sort -u > $@

n15.txt: verbs.txt
	cat verbs.txt | sed 's/^/ku/' > $@

n16.txt: n16-x.txt
	cat n16-x.txt | LC_ALL=C sort -u > $@

n17.txt: n17-x.txt
	cat n17-x.txt | LC_ALL=C sort -u > $@

n18.txt: n18-x.txt
	cat n18-x.txt | LC_ALL=C sort -u > $@

verbs.txt: vi.txt vt.txt
	cat vi.txt vt.txt | LC_ALL=C sort -u > $@

verbs-multi.txt: verbs.txt
	egrep -v '^[^aeiou]*[aeiou]+$$' verbs.txt > $@

verbs-infl.txt: vi.txt vt.txt $(GEN)
	(cat vt.txt | egrep 'a$$' | sed 's/a$$//' | sed 's/.*/NM+SM+TM+OM^&^AM/'; cat vi.txt | egrep 'a$$' | sed 's/a$$//' | sed 's/.*/NM+SM+TM^&^AM/') | perl $(GEN) > $@

vadjs.txt: verbs-multi.txt verbs.txt $(GEN)
	(cat verbs-multi.txt | sed 's/^/AKU+/'; cat verbs-multi.txt | sed 's/^/AKU+sa+/'; cat verbs.txt | sed 's/^/OF+ku/') | perl $(GEN) | sed 's/ .*//' | LC_ALL=C sort -u > $@

other.txt: $(GEN)
	echo "NA+na" | perl $(GEN) | sed 's/ .*//' | LC_ALL=C sort -u > $@

actual.txt: other.txt
	cat other.txt | sed 's/^ina$$/yina/' | sed 's/i/e/' | sed 's/a/i/' | sed 's/.*/&&/' | LC_ALL=C sort -u > $@

any.txt: $(GEN)
	echo "ANY+nse" | perl $(GEN) | sed 's/ .*//' | LC_ALL=C sort -u > $@

irreg-adjs.txt: $(GEN) other.txt actual.txt
	(cat any.txt other.txt actual.txt; (echo "MWE+kha"; echo "MWE+nse") | perl $(GEN) | sed 's/ .*//') | LC_ALL=C sort -u > $@

adjs.txt: irreg-adjs.txt adj-pure.txt adj-stems.txt $(GEN)
	(cat adj-stems.txt | sed 's/^/OF+/'; cat adj-pure.txt | sed 's/^/DBL+/') | perl $(GEN) | sed 's/ .*//' | sed 's/^wammuna$$/wamwamuna/' | LC_ALL=C sort -u > $@

poss.txt: poss-stems.txt $(GEN)
	cat poss-stems.txt | sed 's/^/OF+/' | perl $(GEN) | sed 's/ .*//' | LC_ALL=C sort -u > $@

preps.txt: preps-in.txt $(GEN)
	(cat preps-in.txt; echo "OF" | perl $(GEN) | sed 's/ .*//') | LC_ALL=C sort -u > $@

rel.txt: $(GEN)
	(echo "SM+mene"; echo "MWE+mwe") | perl $(GEN) | sed 's/ .*//' | sed "s/womwe/yemwe/; s/mumene/m'mene/" | LC_ALL=C sort -u > $@

this1.txt: $(GEN)
	echo "SM" | perl $(GEN) | sed 's/ .*//' | sed 's/^..*\(.\)$$/\1&/; s/^a$$/awa/; s/^i$$/iyi/; s/^u$$/uwu/' | sed 's/indi/uyu/' | LC_ALL=C sort -u > $@

this2.txt: $(GEN)
	echo "SM+no" | perl $(GEN) | sed 's/ .*//' | egrep -v 'ndino' | LC_ALL=C sort -u > $@

that1.txt: this1.txt
	cat this1.txt | sed 's/.$$/o/' > $@

that2.txt: this2.txt
	cat this2.txt | sed 's/no$$/ja/' > $@

dem.txt: this1.txt this2.txt that1.txt that2.txt
	cat this1.txt this2.txt that1.txt that2.txt | LC_ALL=C sort -u > $@

interr.txt: interr-stems.txt
	cat interr-stems.txt | sed 's/^/SM+/' | perl $(GEN) | sed 's/ .*//' | LC_ALL=C sort -u > $@

# kamodzi, kawiri, etc. for "once", "twice", ...
numbers.txt: numbers-in.txt number-stems.txt $(GEN)
	(cat numbers-in.txt; cat number-stems.txt | sed '/^modzi/!s/^/PLSM+/; /^modzi$$/s/^/SSM+/' | perl $(GEN) | sed 's/ .*//'; cat numbers-in.txt number-stems.txt | sed 's/^/ka/') | LC_ALL=C sort -u > $@

suspect.txt: all.txt $(FILTER)
	cat all.txt | LC_ALL=C sort -u | bash $(FILTER) > $@

badclusters.txt: suspect.txt
	cat suspect.txt | tolow | egrep -o "[^aeiou']{2,}" | LC_ALL=C sort | uniq -c | LC_ALL=C sort -r -n > $@

clean:
	rm -f $(NOUNS) suspect.txt badclusters.txt n*-pl.txt adjs.txt verbs.txt preps.txt poss.txt numbers.txt vadjs.txt verbs-multi.txt verbs-infl.txt this*.txt that*.txt dem.txt interr.txt irreg-adjs.txt rel.txt
