repo = maoxuner/yadst
tags = latest ubuntu ubuntu-22

all: $(tags)

$(tags):
	docker build -t $(repo):$@ .

clean:
	@docker rmi -f $(addprefix $(repo):, $(tags))
