BASE_CFG := hugo.toml
COVER_CFG := $(BASE_CFG),hugo-cover.toml
CONFIG := $(BASE_CFG)
NAME := resume.pdf
SIZE := 13

ifdef COVER
    _setup := $(shell [ ! -d $(COVER) ] && mkdir $(COVER) && cp cover-default.yaml $(COVER)/content.yaml)
    _cover := $(shell [ -e cover ] && rm cover)
    _ln := $(shell ln -sf $(COVER) cover)
    CONFIG := $(COVER_CFG)
    NAME := $(COVER)-cover.pdf
    SIZE := 11
endif

.PHONY: cover

view:
	hugo server --config $(CONFIG) --disableFastRender --openBrowser

uv:
	curl -LsSf https://astral.sh/uv/install.sh | sh

build:
	@echo Generate website...
	@hugo --cleanDestinationDir --config $(CONFIG)

pdf: build
	@echo Generate PDF...
	@uv run cnvt.py public/index.html public/$(NAME) $(SIZE)in

testgh:
	act

clean:
	@echo Clean folder...
	@rm -fr resources public *pdf
	@rm -f cover
