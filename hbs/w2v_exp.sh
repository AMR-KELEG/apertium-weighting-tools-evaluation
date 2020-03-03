# WINDOW =2 , VECTOR = 100, 200, 300
./w2v.sh NA 2 100 T F ../../datafiles/shwiki-20200220-pages-articles-multistream.xml.bz2
./w2v.sh NA 2 200 T F ../../datafiles/shwiki-20200220-pages-articles-multistream.xml.bz2
./w2v.sh NA 2 300 T F ../../datafiles/shwiki-20200220-pages-articles-multistream.xml.bz2

# WINDOW =2, 5, 10, VECTOR=300
./w2v.sh NA 2 300 T F ../../datafiles/shwiki-20200220-pages-articles-multistream.xml.bz2
./w2v.sh NA 5 300 T F ../../datafiles/shwiki-20200220-pages-articles-multistream.xml.bz2
./w2v.sh NA 10 300 T F ../../datafiles/shwiki-20200220-pages-articles-multistream.xml.bz2
