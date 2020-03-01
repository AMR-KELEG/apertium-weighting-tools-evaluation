LANG="kaz"
TAGGED_CORPUS="../../apertium-${LANG}/corpus/kaz.tagged"
BIN="../../apertium-${LANG}/${LANG}.automorf.bin"
FOLDS=$(mktemp -d)
CLEANED_CORPUS=$(mktemp)
UNI_LAPLACE=$(mktemp -d)
UNI_SGT=$(mktemp -d)
RESULTS_FILE="results/uni"
cat "${TAGGED_CORPUS}" | apertium-cleanstream -n > "${CLEANED_CORPUS}"

corpus_split.py "${CLEANED_CORPUS}" -n 5 -o "${FOLDS}"
unigram_fit.py -i "${FOLDS}" -b "${BIN}" -o "${UNI_LAPLACE}"
unigram_fit_sgt.py -i "${FOLDS}" -b "${BIN}" -o "${UNI_SGT}"


echo "UNIGRAM LAPLACE" >> "${RESULTS_FILE}"
metrics_report.py -i "${FOLDS}" -b "${UNI_LAPLACE}" >> "${RESULTS_FILE}"
echo "UNIGRAM SGT" >> "${RESULTS_FILE}"
metrics_report.py -i "${FOLDS}" -b "${UNI_SGT}" >> "${RESULTS_FILE}"

rm -r "${CLEANED_CORPUS}" "$FOLDS" "${UNI_LAPLACE}" "${UNI_SGT}"
