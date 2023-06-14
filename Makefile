init:
	@echo "Inicializando o Terraform..."
	terraform init

plan:
	@echo "Planejando a infraestrutura..."
	terraform plan

validate:
	@echo "Planejando a infraestrutura..."
	terraform validate

apply:
	@echo "Aplicando a infraestrutura..."
	terraform apply --auto-approve

destroy:
	@echo "Destruindo a infraestrutura..."
	rm -vf id_rsa
	terraform destroy --auto-approve

connect:
	@echo "Conectando na vm..."
	terraform output -raw tls_private_key > id_rsa && chmod 600 id_rsa
	ssh -i id_rsa azureuser@`terraform output -raw public_ip_address`

check:
	@echo "Validando se o nginx está em execução (requer o curl)..."
	curl -I `terraform output -raw public_ip_address`

.PHONY: init plan apply destroy
