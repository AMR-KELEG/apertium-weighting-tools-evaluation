LANG="kaz"
TAGGED_CORPUS="../../apertium-${LANG}/corpus/kaz.tagged"
BIN="../../apertium-${LANG}/${LANG}.automorf.bin"
FOLDS=$(mktemp -d)
CLEANED_CORPUS=$(mktemp)
UNTAGGED_CORPUS=$(mktemp)
RAND_LAPLACE=$(mktemp -d)
RAND_SGT=$(mktemp -d)
RESULTS_FILE="results/rand"
cat "${TAGGED_CORPUS}" | apertium-cleanstream -n > "${CLEANED_CORPUS}"

cat ../../apertium-kaz/texts/texts2/*.raw.txt > "${UNTAGGED_CORPUS}"

corpus_split.py "${CLEANED_CORPUS}" -n 5 -o "${FOLDS}"
random_fit.py -i "${FOLDS}" -b "${BIN}" -corpus "${UNTAGGED_CORPUS}" -o "${RAND_LAPLACE}"
random_fit_sgt.py -i "${FOLDS}" -b "${BIN}" -corpus "${UNTAGGED_CORPUS}" -o "${RAND_SGT}"

echo "RAND LAPLACE" >> "${RESULTS_FILE}"
metrics_report.py -i "${FOLDS}" -b "${RAND_LAPLACE}" >> "${RESULTS_FILE}"
echo "RAND SGT" >> "${RESULTS_FILE}"
metrics_report.py -i "${FOLDS}" -b "${RAND_SGT}" >> "${RESULTS_FILE}"

rm -r "${CLEANED_CORPUS}" "${UNTAGGED_CORPUS}" "$FOLDS" "${RAND_LAPLACE}" "${RAND_SGT}"
