PROJECT := thesis
WORKDIR := $(CURDIR)

# list below your targets and their recipies
all: manuscript.pdf

manuscript.pdf: manuscript.tex

apa.csl:
	curl -sL https://raw.githubusercontent.com/citation-style-language/styles/master/apa.csl > $@

publish/: manuscript.pdf

include .repro/Makefile_publish

papers/: papers/workflow.pdf papers/tutorial.pdf papers/prereg.pdf

papers/workflow.pdf:
	mkdir -p papers
	curl -sL https://qcmb.psychopen.eu/index.php/qcmb/article/download/3763/3763.pdf/ > $@

papers/tutorial.pdf:
	mkdir -p papers
	curl -sL https://edoc.hu-berlin.de/bitstream/handle/18452/26135/psych-03-00053.pdf > $@

papers/prereg.pdf:
	mkdir -p papers
	curl -sL https://aaronpeikert.github.io/bayes-prereg/manuscript.pdf > $@


### Wrap Commands ###
# if a command is to be send to another process e.g. a container/scheduler use:
# $(RUN1) mycommand --myflag $(RUN2)
RUN1 = $(QRUN1) $(SRUN) $(DRUN)
RUN2 = $(QRUN2)

### Rmd's ###
include .repro/Makefile_Rmds

### Docker ###
# this is a workaround for windows users
# please set WINDOWS=TRUE and adapt WINPATH if you are a windows user
# note the unusual way to specify the path
WINPATH = //c/Users/someuser/Documents/myproject/
include .repro/Makefile_Docker

