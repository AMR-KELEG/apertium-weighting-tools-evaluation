# WINDOW =2 , VECTOR = 100, 200, 300
./w2v.sh NA 2 100 T F ../../datafiles/enwiki-20200220-pages-articles-multistream14.xml-p6197595p7697594.bz2
./w2v.sh NA 2 200 T F ../../datafiles/enwiki-20200220-pages-articles-multistream14.xml-p6197595p7697594.bz2
./w2v.sh NA 2 300 T F ../../datafiles/enwiki-20200220-pages-articles-multistream14.xml-p6197595p7697594.bz2

# WINDOW =2, 5, 10, VECTOR=100
./w2v.sh NA 2 100 T F ../../datafiles/enwiki-20200220-pages-articles-multistream14.xml-p6197595p7697594.bz2
./w2v.sh NA 5 100 T F ../../datafiles/enwiki-20200220-pages-articles-multistream14.xml-p6197595p7697594.bz2
./w2v.sh NA 10 100 T F ../../datafiles/enwiki-20200220-pages-articles-multistream14.xml-p6197595p7697594.bz2

# Pretrained model
./w2v.sh ../w2v-models/18/model.bin NA NA F T
./w2v.sh ../w2v-models/40/model.bin NA NA F T
