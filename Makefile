# Makefile to run ansible tasks

# Environment Configuration
DEFAULT_VAULT_PASSWORD_FILE=.vault.passwd
RUN=

default:
	echo "Hallo"

# Create vault password & test it by generating an encrypted file
create-vault-passwd:
	dd if=/dev/urandom bs=1 count=1024 | base64 > .vault.passwd
	ansible-vault create --vault-password-file=.vault.passwd  vault-test.yml

