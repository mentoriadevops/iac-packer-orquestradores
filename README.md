# IAC IMAGEM PACKER ORQUESTRADORES

Este repositório se destina a criar uma imagem para boot de instancias de VM no GCP.

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

## Variaveis de Pipeline

- GCP_KEY -> Conteudo completo do JSON de credenciais do GCP.

A variavel secret do Actions deve ter o conteúdo completo do JSON conforme exemplo abaixo.

```json

{
  "type": "service_account",
  "project_id": "project_id",
  "private_key_id": "3acc6c457asdasdasdasdasd5df2d4d4a3d1a3d62b086d7de9308c2",
  "private_key": "-----BEGIN PRIVATE KEY-----\ashduashduahsduhasudhasudhasduahsdahsduhasd@!@&*#HGSHGD\n-----END PRIVATE KEY-----\n",
  "client_email": "terraform@project-id.iam.gserviceaccount.com",
  "client_id": "1231231256546456456",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/terraform%40project_id.iam.gserviceaccount.com"
}


```

- GCP_PROJECT_ID -> Project ID da GCP onde será rodado a criação da imagem do Packer.
