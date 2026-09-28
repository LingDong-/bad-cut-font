all: positive negative
	echo "done"

download:
	curl -L https://github.com/adobe-fonts/source-han-serif/releases/download/2.003R/08_SourceHanSerifK.zip > 08_SourceHanSerifK.zip
	unzip -j 08_SourceHanSerifK.zip OTF/Korean/SourceHanSerifK-Heavy.otf
	if [ -x "$$HOME/.local/bin/uvx" ]; then UVX="$$HOME/.local/bin/uvx"; else UVX=uvx; fi;\
	"$$UVX" otf2ttf -o SourceHanSerifK-Heavy.ttf SourceHanSerifK-Heavy.otf
	rm 08_SourceHanSerifK.zip SourceHanSerifK-Heavy.otf

.DEFAULT:
	dither -xvt c wcut.dh dump cfg.$@.json
	dither -xvt c vectorize.dh
	node --max-old-space-size=8192 makefont.js $@

zip:
	for f in *.ttf; do\
		zip -9 $$f.zip $$f OFL.TXT;\
	done;
