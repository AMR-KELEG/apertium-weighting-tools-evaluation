LANG="hbs"
TAGGED_CORPUS="../../apertium-${LANG}/hbs-tagger-data/hbs.tagged"
BIN="../../apertium-${LANG}/${LANG}.automorf.bin"
CG='../../apertium-hbs/hbs.rlx.bin'
FOLDS=$(mktemp -d)
CLEANED_CORPUS=$(mktemp)
UNTAGGED_CORPUS=$(mktemp)
CG_LAPLACE=$(mktemp -d)
CG_SGT=$(mktemp -d)
RESULTS_FILE="results/cg"
cat "${TAGGED_CORPUS}" | apertium-cleanstream -n > "${CLEANED_CORPUS}"

cat ../../apertium-hbs/hbs-tagger-data/hbs.tagged.txt > "${UNTAGGED_CORPUS}"

corpus_split.py "${CLEANED_CORPUS}" -n 5 -o "${FOLDS}"
constraintgrammar_fit.py -i "${FOLDS}" -b "${BIN}" -corpus "${UNTAGGED_CORPUS}" -cg "${CG}" -o "${CG_LAPLACE}"
constraintgrammar_fit_sgt.py -i "${FOLDS}" -b "${BIN}" -corpus "${UNTAGGED_CORPUS}" -cg "${CG}" -o "${CG_SGT}"

echo "CG LAPLACE" >> "${RESULTS_FILE}"
metrics_report.py -i "${FOLDS}" -b "${CG_LAPLACE}" >> "${RESULTS_FILE}"
echo "CG SGT" >> "${RESULTS_FILE}"
metrics_report.py -i "${FOLDS}" -b "${CG_SGT}" >> "${RESULTS_FILE}"

rm -r "${CLEANED_CORPUS}" "${UNTAGGED_CORPUS}" "$FOLDS" "${CG_LAPLACE}" "${CG_SGT}"
