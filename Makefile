.PHONY: deploy-build pdf-cv pdf-cv-en pdf-cv-pt pdf-cv-es

deploy-build:
	hugo
	ruby scripts/build_cv.rb all

pdf-cv:
	ruby scripts/build_cv.rb all

pdf-cv-en:
	ruby scripts/build_cv.rb en

pdf-cv-pt:
	ruby scripts/build_cv.rb pt

pdf-cv-es:
	ruby scripts/build_cv.rb es
