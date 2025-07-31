
view:
	hugo server --disableFastRender --openBrowser

build:
	hugo --cleanDestinationDir

pdf: build
	./cnvt.py

clean:
	rm -fr resources public *pdf

