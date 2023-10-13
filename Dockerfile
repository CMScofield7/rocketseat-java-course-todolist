# Imagem
FROM ubuntu:latest AS build

# Instalação de dependências
RUN apt-get update
RUN apt-get install openjdk-17-jdk -y

# Copia o diretório local para o diretório do container
COPY . .  

# Instalação do Maven
RUN apt-get install maven -y
RUN mvn clean install

# Imagem base
FROM openjdk:17-jdk-slim

# Expor a porta 8080
EXPOSE 8080

# Copia o todolist-1.0.0.jar para o app.jar
COPY --from=build /target/todolist-1.0.0.jar app.jar

# Executa o comando java -jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]