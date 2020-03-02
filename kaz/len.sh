LANG="kaz"
TAGGED_CORPUS="../../apertium-${LANG}/corpus/kaz.tagged"
BIN="../../apertium-${LANG}/${LANG}.automorf.bin"
FOLDS=$(mktemp -d)
CLEANED_CORPUS=$(mktemp)
LEN=$(mktemp -d)
RESULTS_FILE="results/len"
cat "${TAGGED_CORPUS}" | apertium-cleanstream -n > "${CLEANED_CORPUS}"

corpus_split.py "${CLEANED_CORPUS}" -n 5 -o "${FOLDS}"
analysis_length_fit.py -i "${FOLDS}" -b "${BIN}" -o "${LEN}"

echo "LEN" >> "${RESULTS_FILE}"
metrics_report.py -i "${FOLDS}" -b "${LEN}" >> "${RESULTS_FILE}"

rm -r "${CLEANED_CORPUS}" "$FOLDS" "${LEN}"
