# IAC IMAGEM DADOS ABERTOS DA FEIRA

Este repositório se destina a criar uma imagem para boot de instancias de VM no GCP, sendo que o conteudo desta imagem é a role-iac do projeto Dados Abertos da Feira de Santana.

## Requisitos

| Nome      	| Versao 	|
|--------------	|---------	|
|   Packer      |  >=1.7    |
|   [gcloud CLI](https://cloud.google.com/sdk/docs/install)  |  >=344.0.0    |

### Ambiente no GCP

Para rodar o packer no google cloud é necessário ter uma service account com privilégios no projeto gcp em questão. O projeto utiliza docker para rodar o packer, portanto também é necessário ter um arquivo de credencial para ser compartilhado com a imagem.

#### Passos para gerar arquivo de credencial

```bash
make generate-credentials
```

## Variáveis

> PENDENTE! não estamos em uso ainda
Todas as variáveis que são necessárias no arquivo variables.pkr.hcl para executar o template: 

| Variable     	| Default 	| Required 	| Description                                                                            	|
|--------------	|---------	|----------	|----------------------------------------------------------------------------------------	|
|               |           |           |                                                                                           |

## Como Testar Localmente

1- Editar os arquivos no diretório ``packer/`` de acordo com as variáveis, source e provisioners necessários.

2- Executar comando ``make validate`` para o validate e formating da imagem.

3- (Opcional) ``make build`` faz o build da imagem na plataforma configurada no arquivo ``packer/source.pkr.hcl``

## Observações

- Motivo do uso de HCL2 ao invés de json: As of version 1.7.0, HCL2 support is no longer in beta and is the **preferred way to write Packer configuration(s)** - [Hashicorp Docs](https://www.packer.io/guides/hcl/from-json-v1)
