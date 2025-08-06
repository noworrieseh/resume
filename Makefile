
view:
	hugo server --disableFastRender --openBrowser

uv:
	curl -LsSf https://astral.sh/uv/install.sh | sh

build:
	@echo Generate website...
	@hugo --cleanDestinationDir

pdf: build
	@echo Generate PDF...
	@uv run cnvt.py public/index.html public/resume.pdf

testgh:
	act

clean:
	@echo Clean folder...
	@rm -fr resources public *pdf
