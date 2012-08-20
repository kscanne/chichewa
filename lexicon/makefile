NOUNS=n1.txt n2.txt n3.txt n4.txt n5.txt n6.txt n7.txt n8.txt n9.txt n10.txt n12.txt n13.txt n14.txt n15.txt n16.txt n17.txt n18.txt
FILTER=${HOME}/seal/idirlamha/ny/dictdata/filterbad

all: nouns badclusters.txt

nouns: $(NOUNS)

n1.txt: n1-2.txt n1-4.txt n1-6.txt n1-x.txt
	cat n1-2.txt n1-4.txt n1-6.txt n1-x.txt | LC_ALL=C sort -u > $@

n2.txt: n1-2.txt
	cat n1-2.txt | sed "s/^m'phera/a&/; s/^m\(khiris\)/a\1/; s/^m\(phunzitsi\)/a\1/; s/^mwanawa/anaa/; s/^mwini/eni/; s/^[^aemw]/a&/; s/^muy/a&/; s/^m['u]/a/; s/^m[abo]/a&/; s/^m\([cdfgjlmnsz]\)/a\1/; s/^m\([kpt][^h]\)/a\1/; s/^m[kpt]h/a&/; s/^mwa/a/; s/^mwi/a&/; s/^w[^o]/a&/; s/^wo/o/" | LC_ALL=C sort -u > $@

n3.txt: n3-4.txt n3-x.txt
	cat n3-4.txt n3-x.txt | LC_ALL=C sort -u > $@

n4.txt: n1-4.txt n3-4.txt
	cat n1-4.txt n3-4.txt | sed 's/^m/mi/' | LC_ALL=C sort -u > $@

n5.txt: n5-6.txt n5-x.txt
	cat n5-6.txt n5-x.txt | LC_ALL=C sort -u > $@

n6.txt: n1-6.txt n5-6.txt n14-6.txt nx-6.txt
	(cat nx-6.txt; cat n1-6.txt n5-6.txt n14-6.txt | sed 's/^/ma/') | LC_ALL=C sort -u > $@

n7.txt: n7-8.txt n7-x.txt
	cat n7-8.txt n7-x.txt | LC_ALL=C sort -u > $@

n8.txt: n7-8.txt
	cat n7-8.txt | sed 's/^ch/z/' | LC_ALL=C sort -u > $@

n9.txt: n9-10.txt
	cat n9-10.txt | LC_ALL=C sort -u > $@

n10.txt: n9-10.txt
	cat n9-10.txt | LC_ALL=C sort -u > $@

n12.txt: n12-13.txt
	cat n12-13.txt | LC_ALL=C sort -u > $@

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

suspect.txt: $(NOUNS) verbs.txt $(FILTER)
	cat n*-*.txt verbs.txt | LC_ALL=C sort -u | bash $(FILTER) > $@

badclusters.txt: suspect.txt
	cat suspect.txt | tolow | egrep -o "[^aeiou']{2,}" | LC_ALL=C sort | uniq -c | LC_ALL=C sort -r -n > $@

clean:
	rm -f $(NOUNS) suspect.txt badclusters.txt
