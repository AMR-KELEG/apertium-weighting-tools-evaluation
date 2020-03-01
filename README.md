# apertium-weighting-tools-evaluation
This repository contains the scripts required to reproduce the results published in `An unsupervised method for weighting finite-state morphological analyzers` as an oral paper for LREC 2020.

## Dependencies
- `lttoolbox` (version: 3.5.1)
- `hfst` (version: 3.15.2)

## Directories organisation
- Clone this repository
- Clone apertium-weighting-tools: `git clone https://github.com/apertium/apertium-weighting-tools.git` (go to branch: evaluation)
- Clone the following repositories at the same directory as that of the evaluation repository:
  - apertium-eng: `git clone https://github.com/apertium/apertium-eng.git`
  (commit SHA1: 076aaa3920eb78432d431541672219d455198f86)
  - apertium-kaz: `git clone https://github.com/apertium/apertium-kaz.git`
  (commit SHA1: 51fc4e532eb61e589a796116ab973069f26b7145)
  - apertium-hbs: `git clone https://github.com/apertium/apertium-hbs.git`
  (commit SHA1: a34d0d5eff6b03239c5bcf9fd49207645444f485)
- Make sure all the repositories share the same root directory
```
|
|-- apertium-weighting-tools-evaluation/
|-- apertium-weighting-tools/
|-- apertium-eng/
|-- apertium-kaz/
|-- apertium-hbs/
```

## Running the experiments
1) Add the `apertium-weighting-tools` and `apertium-weighting-tools/eval` to the `PATH` variable.
e.g: `export PATH="$PATH:ABSOLUTE_DIR_TO_WEIGHTING_TOOLS:ABSOLUTE_DIR_TO_WEIGHTING_TOOLS/eval"`
2) Choose a language
3) cd to the directory of this language
4) Run the script 
5) The results will be generated in the `LANG/results` directory
