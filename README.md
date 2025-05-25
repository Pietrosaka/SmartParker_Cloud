SmartParker_Cloud: API de Gerenciamento para Pátios de Motos

📝 Descrição do Projeto
A SmartParker_Cloud é a API backend do sistema SmartParker, desenvolvida em Java com o framework Spring Boot. Ela atua como o coração do gerenciamento do pátio de motos, fornecendo uma camada robusta para controle de usuários, motos, pátios, setores e localizações.

Esta API implementa todas as funcionalidades de um CRUD (Create, Read, Update, Delete) e vai além, oferecendo recursos avançados como:

Buscas parametrizadas para consultas flexíveis e eficientes.

Paginação e ordenação para otimização da exibição e manipulação de grandes volumes de dados.

Cache para otimizar requisições repetidas, reduzindo a carga no banco de dados e melhorando significativamente a performance e a escalabilidade.

Integração com sistemas de reconhecimento de placas (ex: SmartParker_OCR) e sistemas frontend.

🎓 Alunos
2tdspx:

Caio Cesar – rm556331

Guilherme Grizão – rm557958

2tdspy:

Pietro Cougo – rm555839

🚀 Tecnologias e Recursos Utilizados
Java 17

Spring Boot

H2 Database

Maven

Spring Cache

Bean Validation

JPA Specifications

Pageable e ordenação

@ControllerAdvice

DTOs

Docker

Azure CLI

📦 Instruções para Executar o Projeto Localmente
✅ Requisitos
JDK 17+

Apache Maven 3.6+

▶️ Passos para Rodar Localmente
Clone o repositório:

bash
Copiar
Editar
git clone https://github.com/SEU_USUARIO_GITHUB/SmartParker_Cloud.git
cd SmartParker_Cloud
Execute a aplicação:

bash
Copiar
Editar
./mvnw spring-boot:run # Linux/macOS
# Ou no Windows:
mvnw.cmd spring-boot:run
Acesse a API em:

arduino
Copiar
Editar
http://localhost:8080
☁️ Implantação na Nuvem (Azure VM com Docker)
Este projeto pode ser implantado em uma Máquina Virtual (VM) do Azure com Docker para execução em ambiente de produção.

📌 Pré-requisitos
Conta no Azure

Azure CLI instalado e autenticado (az login)

Docker instalado na VM

🔧 Etapa 1: Criar e Configurar a Máquina Virtual no Azure
Execute no seu terminal local:

bash
Copiar
Editar
#!/bin/bash

RESOURCE_GROUP="smartparker-rg"
VM_NAME="smartparker-vm"
LOCATION="eastus"
IMAGE="UbuntuLTS"
SIZE="Standard_DS1_v2"
ADMIN_USERNAME="mottuadmin"
ADMIN_PASSWORD="Fiap@2tdsvms"
HTTP_PORT=80
HTTPS_PORT=443
APP_PORT=8080

az group create --name "$RESOURCE_GROUP" --location "$LOCATION"

az vm create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM_NAME" \
  --image "$IMAGE" \
  --size "$SIZE" \
  --admin-username "$ADMIN_USERNAME" \
  --admin-password "$ADMIN_PASSWORD" \
  --output tsv

az vm show --resource-group "$RESOURCE_GROUP" --name "$VM_NAME" --show-details --query publicIps -o tsv

az vm run-command \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM_NAME" \
  --command-id RunShellScript \
  --scripts "sudo apt-get update && sudo apt-get install -y docker.io && sudo systemctl start docker && sudo systemctl enable docker && sudo usermod -aG docker $ADMIN_USERNAME"

az vm open-port --resource-group "$RESOURCE_GROUP" --name "$VM_NAME" --priority 1002 --port "$HTTP_PORT"
az vm open-port --resource-group "$RESOURCE_GROUP" --name "$VM_NAME" --priority 1003 --port "$HTTPS_PORT"
az vm open-port --resource-group "$RESOURCE_GROUP" --name "$VM_NAME" --priority 1004 --port "$APP_PORT"
🐳 Etapa 2: Implantação com Docker na VM
1. Criar o JAR localmente
bash
Copiar
Editar
cd /caminho/para/SmartParker_Cloud
mvn clean install
2. Copiar o JAR para a VM
bash
Copiar
Editar
scp target/<NOME_DO_JAR>.jar mottuadmin@<IP_PUBLICO_DA_VM>:/home/mottuadmin/app.jar
3. Acessar a VM via SSH
bash
Copiar
Editar
ssh mottuadmin@<IP_PUBLICO_DA_VM>
4. Criar o Dockerfile na VM
dockerfile
Copiar
Editar
# Dockerfile
FROM openjdk:17-jdk-slim
VOLUME /tmp
COPY app.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
Salve com Ctrl+O e Ctrl+X se estiver usando nano.

5. Construir a imagem Docker
bash
Copiar
Editar
docker build -t smartparker-api .
6. Executar o container
bash
Copiar
Editar
docker run -d -p 8080:8080 --name smartparker smartparker-api
✅ Verificação
Acesse no navegador:

cpp
Copiar
Editar
http://<IP_PUBLICO_DA_VM>:8080
📮 Contato
Em caso de dúvidas, sugestões ou melhorias, entre em contato com os desenvolvedores mencionados ou abra uma Issue no repositório.

