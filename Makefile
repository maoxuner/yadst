repo = registry.cn-shanghai.aliyuncs.com/maoxuner/yadst
tags = latest ubuntu ubuntu-24

cri := $(shell command -v podman || command -v docker)

all: $(tags)

$(tags):
	$(cri) build -t $(repo):$@ .
	$(cri) push $(repo):$@

test: all clean

clean:
	$(cri) rmi -f $(addprefix $(repo):, $(tags))
