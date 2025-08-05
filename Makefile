
view:
	hugo server --disableFastRender --openBrowser

build:
	hugo --cleanDestinationDir

pdf: build
	pip install -r requirements.txt
	./cnvt.py

clean:
	rm -fr resources public *pdf

