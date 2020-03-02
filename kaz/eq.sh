LANG="kaz"
TAGGED_CORPUS="../../apertium-${LANG}/corpus/kaz.tagged"
BIN="../../apertium-${LANG}/${LANG}.automorf.bin"
FOLDS=$(mktemp -d)
CLEANED_CORPUS=$(mktemp)
EQ=$(mktemp -d)
RESULTS_FILE="results/eq"
cat "${TAGGED_CORPUS}" | apertium-cleanstream -n > "${CLEANED_CORPUS}"

corpus_split.py "${CLEANED_CORPUS}" -n 5 -o "${FOLDS}"
equalweight_fit.py -i "${FOLDS}" -b "${BIN}" -o "${EQ}"

echo "EQ" >> "${RESULTS_FILE}"
metrics_report.py -i "${FOLDS}" -b "${EQ}" >> "${RESULTS_FILE}"

rm -r "${CLEANED_CORPUS}" "$FOLDS" "${EQ}"
