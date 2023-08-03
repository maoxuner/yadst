TAGS = latest ubuntu ubuntu-22

all: $(TAGS)

$(TAGS):
	docker build -t maoxuner/yadst:$@ .

clean:
	@docker rmi -f $(addprefix maoxuner/yadst:, $(TAGS))
