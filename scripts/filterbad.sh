#!/bin/bash
# assume this is applied to a word list, one word per line
# Additional allowable noun cluster beyond those in the Chichewa orthography
# handbook (verified by EK): my, mz, mts, mps, mdz, mn, mkh, nk[^h], 
# tw, nt[^ch], nch, mbz, ty, nthw, mth, msw, mj, mdy, mny
egrep "$@" -i "([^aeiou]$|[^'abcdefghijklmnoprstuvwyzŵŴ]|b[^aeiouwz]|bz[wy]|c[^h]|ch[^aeiou]|d[^aeiouwyz]|dz[^aeiouw]|[fj][^aeiouw]|g[^aeiouw']|[^n]g'|[^mng]'|k[^aeiouhw]|kh[^aeiouw]|l[^aeiouwy]|m[hmr]|mb[^aeiouwz]|mbz[^aeiou]|mg[^aeiouw]|m[flvz][^aeiou]|md[^aeiouyz]|mdz[^aeiou]|mj[^aeiou]|mk[^aeiouh]|mkh[^aeiou]|mn[^aeiouy]|mp[^aeiouhsw]|mph[^aeiouw]|mps[^aeiou]|ms[^aeiouw]|mt[^aeioush]|mt[sh][^aeiou]|n[bfhlmnprv]|nd[^aeiouwy]|ng[^aeiouw']|nk[^aeiouh]|nkh[^aeiouw]|ns[^aeiouw]|nt[^aeiouch]|nth[^aeiouwy]|ng'[^aeiouw]|p[^aeiouhswy]|ph[^aeiouw]|ps[^aeiou]|^r|r[^aeiouw]|s[^aeiouhw]|sh[^aeiou]|t[^aeiouchswy]|th[^aeiouwy]|ts[^aeiouw]|v[^aeiouwy]|[wy][^aeiou]|z[^aeiouwy])"

# no r at start
# [aou]r
# [ie]l  (but chi-l ok?)

# triple letter
# three vowels in a row
# ea (one word, makeadafa), ua
# ae, ee  (ie in just one word: namwiengeza)
# oi, ui, (ei in two words)
# eo
# ou

# m[kg][ei]
