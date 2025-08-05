
view:
	hugo server --disableFastRender --openBrowser

build:
	hugo --cleanDestinationDir

pdf: build
	uv run cnvt.py public/index.html public/resume.pdf

test: build .secrets
	act 

clean:
	rm -fr resources public *pdf
