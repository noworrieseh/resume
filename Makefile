
view:
	hugo server --disableFastRender --openBrowser

uv:
	 curl -LsSf https://astral.sh/uv/install.sh | sh

build:
	hugo --cleanDestinationDir

pdf: build
	uv run cnvt.py public/index.html public/resume.pdf

testgh: .secrets
	act

clean:
	rm -fr resources public *pdf
