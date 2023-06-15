# Multicloud Azure

Trabalho para o MBA em Arquitetura de Soluções sobre Terraform na Azure para a disciplina Multicloud Architecture na faculdade Impacta

## Integrantes

Nome: Leonardo Silva dos Santos
RA: 2300465

Nome: Julio Cesar de Sousa Gonzales
RA: 2302051

Nome: Fabio Júnior da Silva
RA: 2301637

Nome: Felipe Marcelo Albuquerque Sartori
RA: 2300751

## Atividade

Subir uma máquina virtual no Azure, AWS ou GCP instalando o Apache2/nginx e que esteja acessível no host da máquina na porta 80, usando Terraform.

Enviar a URL GitHub do código.

O código enviado deve satisfazer exatamente o que foi pedido no enunciado, caso haja código faltando ou sobrando terá desconto de nota. 
Atividade pode ser feita em grupo ou individual.

## Sobre o projeto

* Cria os recursos na região eastus (uma região bem barata)
* Cria um resource group com nome aleatório
* Virtual network com a CIDR 10.0.0.0/16
* Subnet na rede 10.0.1.0/24
* IP Público para vm
* Network security group com 2 regras
  * Regra para acesso a porta 80 a partir de qualquer origem
  * Regra de acesso ssh restrita ao ip que está executando o projeto
    * utilizando data http para obter o endereço público em https://ipv4.icanhazip.com/
* Cria interface de rede
* Anexa o network security group a interface de rede
* Cria storage account com nome aleatório para diagnóstico de boot da vm
* Cria uma chave ssh para a vm usando o resource "tls_private_key"
* Cria a vm linux com o Ubuntu
* Executa script para validação e instalação do serviço nginx (arquivo script.sh)

## Troubleshooting

Para conectar manualmente na vm:

```bash
terraform output -raw tls_private_key > id_rsa && chmod 600 id_rsa
```
```bash
ssh -i id_rsa azureuser@`terraform output -raw public_ip_address`
```

Para validar manualmente se o nginx está em execução:

```bash
curl -I `terraform output -raw public_ip_address`
```

Caso o nginx não tenha sido inicializado ou instalado. O script é enviado para o path:

```bash
/var/lib/waagent/custom-script/download/0/script.sh
```
## Pré requisitos

* Conta na azure
* cli instalada e autenticada

Para saber mais: 

https://learn.microsoft.com/en-us/cli/azure/install-azure-cli
https://learn.microsoft.com/pt-br/cli/azure/authenticate-azure-cli

## Como usar?

1. Para iniciar o projeto
```bash
make init
```

2. Para validar se há algum erro de sintaxe:
```bash
make validate
```

3. Para executar o terraform plan:
```bash
make plan
```

4. Para aplicar o projeto:
```bash
make apply
```

5. Para conectar na vm:
```bash
make connect
```

6. Para validar se o nginx foi instalado corretamente:
```bash
make check
```

## Referências

https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-terraform

https://jakewalsh.co.uk/automating-nsg-rules-with-an-external-ip-in-terraform/