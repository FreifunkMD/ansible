# Makefile to run ansible tasks
# FIXME: IDK Makefiles....

# Environment Configuration
DEFAULT_VAULT_PASSWORD_FILE=.vault.passwd
USER=nold
RUN=
DOCKER=docker run -ti --rm ansible-dev

default:
	echo "README"

docker:
	docker build -t ansible-dev .

install-requirements:
	ansible-galaxy install -r requirements.yml

# Create vault password & test it by generating an encrypted file
create-vault-passwd:
	dd if=/dev/urandom bs=1 count=1024 | base64 > .vault.passwd
	${DOCKER} ansible-vault create --vault-password-file=.vault.passwd  vault-test.yml

syntax: docker
	${DOCKER} ansible-playbook -i inventory.ini --syntax-check test.yml
#	${DOCKER} ansible-playbook --syntax-check webservers.yml
#	${DOCKER} ansible-playbook --syntax-check gateways.yml

lint: docker
	${DOCKER} ansible-lint test.yml

check: install-requirements
	ansible-playbook -i inventory.ini -u ${USER} -b test.yml --check --diff

test: install-requirements syntax
	ansible-playbook -i inventory.ini -u ${USER} -b test.yml
