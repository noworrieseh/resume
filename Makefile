BASE_CFG := hugo.toml
COVER_CFG := $(BASE_CFG),hugo-cover.toml
CONFIG := $(BASE_CFG)

ifeq ($(filter cover,$(MAKECMDGOALS)),cover)
    # If 'cover' is requested, override CONFIG
    CONFIG := $(COVER_CFG)
endif

.PHONY: cover

view:
	hugo server --config $(CONFIG) --disableFastRender --openBrowser

uv:
	curl -LsSf https://astral.sh/uv/install.sh | sh

build:
	@echo Generate website...
	@hugo --cleanDestinationDir

pdf: build
	@echo Generate PDF...
	@uv run cnvt.py public/index.html public/resume.pdf 11in

testgh:
	act

clean:
	@echo Clean folder...
	@rm -fr resources public *pdf
