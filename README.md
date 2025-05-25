# SmartParker_Cloud: API de Gerenciamento para Pátios de Motos

**SmartParker API**

<p align="center">
  <img src="Capa.png" alt="Banner SmartParker Cloud - API de Gestão" style="width: 100%; max-height: 250px; object-fit: cover;">
</p>

## 📝 Descrição do Projeto

A **SmartParker_Cloud** é a API backend do sistema SmartParker, desenvolvida em Java com o framework Spring Boot. Ela atua como o coração do gerenciamento do pátio de motos, fornecendo uma camada robusta para controle de usuários, motos, pátios, setores e localizações.

Esta API implementa todas as funcionalidades de um CRUD (Create, Read, Update, Delete) e vai além, oferecendo recursos avançados como:
* Buscas parametrizadas para consultas flexíveis e eficientes.
* Paginação e ordenação para otimização da exibição e manipulação de grandes volumes de dados.
* Cache para otimizar requisições repetidas, reduzindo a carga no banco de dados e melhorando significativamente a performance e a escalabilidade.
* É projetada para ser o ponto de integração para dados de reconhecimento de placas (provenientes de módulos como o SmartParker_OCR) e para sistemas de frontend.

## 🎓 Alunos

**2tdspx:**
* Caio Cesar – rm556331
* Guilherme Grizão – rm557958

**2tdspy:**
* Pietro Cougo – rm555839

## 🚀 Tecnologias e Recursos Utilizados

* **Java 17:** Linguagem de programação principal para o backend.
* **Spring Boot:** Framework líder para desenvolvimento rápido e robusto de aplicações Java baseadas em microsserviços.
* **H2 Database:** Banco de dados relacional em memória, ideal para desenvolvimento, testes e prototipagem rápida.
* **Maven:** Ferramenta padrão de automação de build e gerenciamento de dependências para projetos Java.
* **Spring Cache:** Módulo do Spring para fácil implementação de cache em métodos e endpoints, otimizando o desempenho.
* **Bean Validation:** API para validação de dados de entrada, garantindo a integridade dos dados.
* **JPA Specifications:** Usado para construir consultas dinâmicas e tipadas ao banco de dados.
* **Pageable e ordenação de endpoints:** Funcionalidades do Spring Data para fácil implementação de paginação e ordenação em respostas de API.
* **Manipulação de erros com `@ControllerAdvice`:** Para um tratamento centralizado e consistente de exceções na API.
* **DTOs (Data Transfer Objects):** Objetos utilizados para transportar dados entre as camadas da aplicação, otimizando a comunicação e a segurança.
* **Docker:** Para conteinerização da aplicação, facilitando a implantação e escalabilidade.
* **Azure CLI:** Linha de comando para gerenciamento de recursos no Microsoft Azure, incluindo Máquinas Virtuais.

## 📦 Instruções para Executar o Projeto Localmente

### Requisitos

* Java Development Kit (JDK) 17 ou superior.
* Apache Maven 3.6+ (geralmente incluído com o `mvnw.cmd` no projeto Spring Boot).

### Passos para Rodar

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/](https://github.com/)[SEU_USUARIO_GITHUB]/SmartParker_Cloud.git # Ajuste para o link correto do seu repositório da API
    cd SmartParker_Cloud # Ou o nome da pasta raiz do seu projeto API
    ```
2.  **Execute a aplicação com Maven:**
    ```bash
    ./mvnw spring-boot:run # No Linux/macOS
    # Ou no Windows:
    mvnw.cmd spring-boot:run
    ```
3.  **Acesse a API em:**
    ```
    http://localhost:8080
    ```
    (Ou a porta configurada no `application.properties`, se for diferente.)

---

## ☁️ Implantação e Gerenciamento na Nuvem (Azure VM)

Este projeto pode ser implantado em uma Máquina Virtual (VM) no Microsoft Azure. Abaixo estão os comandos do Azure CLI para criar, configurar e gerenciar a VM, bem como para implantar a aplicação usando Docker.

### Pré-requisitos para o Azure

* Uma conta Azure ativa.
* Azure CLI instalado e configurado (faça login com `az login`).

### 1. Criar e Configurar a Máquina Virtual (VM)

**Arquivo `create_vm.sh`:**

Crie um arquivo chamado `create_vm.sh` na raiz do seu repositório da API e cole o seguinte conteúdo:

```bash
#!/bin/bash

RESOURCE_GROUP="smartparker-rg"
VM_NAME="smartparker-vm"
LOCATION="eastus" # Escolha uma região, ex: "brazilsouth" ou "westus"
IMAGE="UbuntuLTS"
SIZE="Standard_DS1_v2" # Tamanho da VM (ajuste conforme necessidade)
ADMIN_USERNAME="mottuadmin"
ADMIN_PASSWORD="Fiap@2tdsvms" # <<<<<<<< ATENÇÃO: Altere esta senha para algo seguro!

echo "Criando o grupo de recursos $RESOURCE_GROUP na região $LOCATION..."
az group create --name "$RESOURCE_GROUP" --location "$LOCATION"

echo "Criando a máquina virtual $VM_NAME..."
az vm create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM_NAME" \
  --image "$IMAGE" \
  --size "$SIZE" \
  --admin-username "$ADMIN_USERNAME" \
  --admin-password "$ADMIN_PASSWORD" \
  --output tsv # Output em formato tsv para facilitar extração de dados

echo "VM criada com sucesso! Anote o IP público para acesso SSH."
az vm show --resource-group "$RESOURCE_GROUP" --name "$VM_NAME" --show-details --query publicIps -o tsv

echo "Aguardando alguns segundos para a VM inicializar e instalar o Docker..."
sleep 30 # Dá um tempo para a VM subir completamente

echo "Instalando Docker na VM..."
# Comandos para executar na VM via SSH para instalar Docker
az vm run-command \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM_NAME" \
  --command-id RunShellScript \
  --scripts "sudo apt-get update && sudo apt-get install -y docker.io && sudo systemctl start docker && sudo systemctl enable docker && sudo usermod -aG docker $ADMIN_USERNAME"

echo "Docker instalado. Você pode precisar se reconectar via SSH para as permissões do Docker entrarem em vigor."
