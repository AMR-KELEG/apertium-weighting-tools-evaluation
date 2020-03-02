LANG="kaz"
TAGGED_CORPUS="../../apertium-${LANG}/corpus/kaz.tagged"
BIN="../../apertium-${LANG}/${LANG}.automorf.bin"
CG='../../apertium-kaz/kaz.rlx.bin'
FOLDS=$(mktemp -d)
CLEANED_CORPUS=$(mktemp)
UNTAGGED_CORPUS=$(mktemp)
CG_LAPLACE=$(mktemp -d)
CG_SGT=$(mktemp -d)
RESULTS_FILE="results/cg"
cat "${TAGGED_CORPUS}" | apertium-cleanstream -n > "${CLEANED_CORPUS}"

cat ../../apertium-kaz/texts/texts2/*.raw.txt > "${UNTAGGED_CORPUS}"

corpus_split.py "${CLEANED_CORPUS}" -n 5 -o "${FOLDS}"
constraintgrammar_fit.py -i "${FOLDS}" -b "${BIN}" -corpus "${UNTAGGED_CORPUS}" -cg "${CG}" -o "${CG_LAPLACE}"
constraintgrammar_fit_sgt.py -i "${FOLDS}" -b "${BIN}" -corpus "${UNTAGGED_CORPUS}" -cg "${CG}" -o "${CG_SGT}"

echo "CG LAPLACE" >> "${RESULTS_FILE}"
metrics_report.py -i "${FOLDS}" -b "${CG_LAPLACE}" >> "${RESULTS_FILE}"
echo "CG SGT" >> "${RESULTS_FILE}"
metrics_report.py -i "${FOLDS}" -b "${CG_SGT}" >> "${RESULTS_FILE}"

rm -r "${CLEANED_CORPUS}" "${UNTAGGED_CORPUS}" "$FOLDS" "${CG_LAPLACE}" "${CG_SGT}"
