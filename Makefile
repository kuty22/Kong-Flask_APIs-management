BUILD=build
DC=docker-compose
DOWN=down
UP=up -d
RM=rm -rf

all: down build up

build:
	$(DC) $(BUILD)

up:
	$(DC) $(UP)

down:
	$(DC) $(DOWN)

# Utils rules
ps:
	$(DC) ps

logs:
	$(DC) logs -f
