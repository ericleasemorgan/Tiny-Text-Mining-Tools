
Tiny Text Mining Tools

This is the very beginnings of Perl library used to support simple and introductory text mining analysis -- tiny text mining tools.

Presently the library is implemented in a set of subroutines stored in a single file supporting:

  * simple in-memory indexing and single-term searching

  * relevancy ranking through term-frequency inverse document
    frequency (TFIDF) for searching and classification

  * cosine similarity for clustering and "finding more items like
    this one"

I use these subroutines and the associated Perl scripts to do quick & dirty analysis against corpuses of journal articles, books, and websites.

I know, I know. It would be better to implement these thing as a set of Perl modules, but I'm practicing what I preach. "Give it away even if it is not ready." The ultimate idea is to package these things into a single distribution, and enable researchers to have them at their finger tips as opposed to a Web-based application.

-- 
Eric Lease Morgan <emorgan@nd.edu>
April 2, 2014
