# Alternate options for ligaturize.py.
# Run `fontforge -lang=py ligaturize.py --help` for details.
LIGATURIZE_OPTS=--prefix=FiraCode+
# LIGATURIZE_OPTS+=" --copy-character-glyphs"
# LIGATURIZE_OPTS+=" --scale-character-glyphs-threshold=0.0"
# LIGATURIZE_OPTS+=" --scale-character-glyphs-threshold=2.0"

TTF_SRCS=$(wildcard input-fonts/*.ttf)
OTF_SRCS=$(wildcard input-fonts/*.otf)

TTF_OUTS=$(patsubst input-fonts/%,output-fonts/FiraCode+%,${TTF_SRCS})
OTF_OUTS=$(patsubst input-fonts/%.otf,output-fonts/FiraCode+%.ttf,${OTF_SRCS})

all: ${TTF_OUTS} ${OTF_OUTS}

output-fonts/FiraCode+%.ttf: input-fonts/%.* ligatures.py ligaturize.py
	fontforge -lang=py ligaturize.py $(LIGATURIZE_OPTS) "$<" "$@" 2>&1 \
	| fgrep -v 'This contextual rule applies no lookups.'
