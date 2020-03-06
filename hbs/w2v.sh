WORD2VEC_MODEL=$1
WINDOW=$2
SIZE=$3
IS_WIKI_DUMP=$4
IS_C_FORMAT_BIN=$5
WIKI_DUMP=$6

LANG="hbs"
TAGGED_CORPUS="../../apertium-${LANG}/hbs-tagger-data/hbs.tagged"
BIN="../../apertium-${LANG}/${LANG}.automorf.bin"
FOLDS=$(mktemp -d)
CLEANED_CORPUS=$(mktemp)
UNTAGGED_CORPUS=$(mktemp)
W2V_LAPLACE=$(mktemp -d)
W2V_SGT=$(mktemp -d)
RESULTS_FILE="results/w2v"
cat "${TAGGED_CORPUS}" | apertium-cleanstream -n > "${CLEANED_CORPUS}"
cat ../../apertium-hbs/hbs-tagger-data/hbs.tagged.txt > "${UNTAGGED_CORPUS}"


if [ ! -z "${WIKI_DUMP}" ]
then
    WORD2VEC_MODEL="../w2v-models/${LANG}-window-${WINDOW}-vector-${SIZE}"
    echo "${WORD2VEC_MODEL}"
fi

corpus_split.py "${CLEANED_CORPUS}" -n 5 -o "${FOLDS}"

if [ ! -z "${WIKI_DUMP}" ]
then
# WIKI DUMP
    w2v_fit.py -i "${FOLDS}" -b "${BIN}" -corpus "${UNTAGGED_CORPUS}" -corpus_word2vec "${WIKI_DUMP}" -o "${W2V_LAPLACE}" --word2vec_model "${WORD2VEC_MODEL}" --is_wiki_dump -window "${WINDOW}" -size "${SIZE}"

    w2v_fit_sgt.py -i "${FOLDS}" -b "${BIN}" -corpus "${UNTAGGED_CORPUS}" -corpus_word2vec "${WIKI_DUMP}" -o "${W2V_SGT}" --word2vec_model "${WORD2VEC_MODEL}" --is_wiki_dump -window "${WINDOW}" -size "${SIZE}"
elif [ -z "${WIKI_DUMP}" ]
then
# C FORMAT
	# TODO: Remove the un-needed corpus_word2vec
    w2v_fit.py -i "${FOLDS}" -b "${BIN}" -corpus "${UNTAGGED_CORPUS}" -corpus_word2vec "${UNTAGGED_CORPUS}" -o "${W2V_LAPLACE}" --word2vec_model "${WORD2VEC_MODEL}" --is_c_format
    echo 'C FORMAT'

    w2v_fit_sgt.py -i "${FOLDS}" -b "${BIN}" -corpus "${UNTAGGED_CORPUS}" -corpus_word2vec "${UNTAGGED_CORPUS}" -o "${W2V_SGT}" --word2vec_model "${WORD2VEC_MODEL}" --is_c_format
else
# INVALID
    echo "INVALID"
    exit
fi

echo "W2V LAPLACE ${WORD2VEC_MODEL}" >> "${RESULTS_FILE}"
metrics_report.py -i "${FOLDS}" -b "${W2V_LAPLACE}" >> "${RESULTS_FILE}"
echo "W2V SGT ${WORD2VEC_MODEL}" >> "${RESULTS_FILE}"
metrics_report.py -i "${FOLDS}" -b "${W2V_SGT}" >> "${RESULTS_FILE}"

rm -r "${CLEANED_CORPUS}" "${UNTAGGED_CORPUS}" "$FOLDS" "${W2V_LAPLACE}" "${W2V_SGT}"
