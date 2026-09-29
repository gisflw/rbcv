.PHONY: deploy-build pdf-cv resume

RESUME ?=

deploy-build:
	hugo
	ruby scripts/build_cv.rb

pdf-cv:
	ruby scripts/build_cv.rb

resume:
	ruby scripts/build_resume.rb $(if $(RESUME),"$(RESUME)")
