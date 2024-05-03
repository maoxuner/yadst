repo = maoxuner/yadst
tags = latest ubuntu ubuntu-24

all: $(tags)

$(tags):
	docker build -t $(repo):$@ .

test: all clean

clean:
	docker rmi -f $(addprefix $(repo):, $(tags))
