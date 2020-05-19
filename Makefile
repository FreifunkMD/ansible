# Makefile to run ansible tasks
# FIXME: IDK Makefiles....

# Environment Configuration
DEFAULT_VAULT_PASSWORD_FILE=.vault.passwd
USER=nold

default:
	echo "README"

docker:
	docker build -t ansible-dev .

install-requirements:
	@echo "# Installing External Ansible Dependencies..."
	ansible-galaxy install -r requirements.yml

# Create vault password & test it by generating an encrypted file
create-vault-passwd:
	dd if=/dev/urandom bs=1 count=1024 | base64 > .vault.passwd
	ansible-vault create --vault-password-file=.vault.passwd  vault-test.yml

syntax:
	@echo "# Running Syntax-Check..."
	ansible-playbook -i inventory.ini --syntax-check test.yml
#	${DOCKER} ansible-playbook --syntax-check webservers.yml
#	${DOCKER} ansible-playbook --syntax-check gateways.yml

lint: docker
	@echo "# Ansible Linting..."
	ansible-lint test.yml

check: install-requirements
	@echo "# Dry-Run: Check-Only & Show Diff..."
	ansible-playbook -i inventory.ini -b test.yml --check --diff

test: install-requirements syntax
	ansible-playbook -i inventory.ini -b test.yml
