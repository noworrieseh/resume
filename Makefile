
view:
	hugo server --disableFastRender --openBrowser

build:
	hugo --cleanDestinationDir

pdf: build
	uv run cnvt.py public/index.html public/resume.pdf

clean:
	rm -fr resources public *pdf
