.PHONY: up down test run build

up:
	docker compose up -d postgres

down:
	docker compose down

test:
	mvn test

build:
	mvn clean package

run:
	SPRING_PROFILES_ACTIVE=local mvn spring-boot:run
