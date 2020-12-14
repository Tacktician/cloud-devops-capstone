## The Makefile includes instructions on environment setup and lint tests
# Create and activate a virtual environment
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint
# app.py should pass pylint
# (Optional) Build a simple integration test

setup:
	# Create python virtualenv & source it
	# source ~/.devops/bin/activate
	python3 -m venv ~/.capstone

install:
	# Install Dependencies:
	pip install --upgrade pip && \
	pip install -r requirements.txt
	# Install hadolint
	curl -sSL https://get.haskellstack.org/ | sh
	git clone https://github.com/hadolint/hadolint
	cd hadolint
	stack install

lint:
	# This is linter for Dockerfiles
	hadolint Dockerfile
	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	pylint --disable=R,C,W1203,W1309,E0401 app.py


all: setup install lint