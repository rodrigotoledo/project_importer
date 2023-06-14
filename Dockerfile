# Define a imagem base
FROM ruby:3.0.3

# Define o diretório de trabalho
WORKDIR /app

# Instala as dependências do sistema
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs

# Copia os arquivos do projeto
COPY Gemfile* ./

# Instala as dependências do projeto
RUN bundle install

# Copia o código-fonte do projeto
COPY . .

# Define o comando para iniciar o servidor
CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3001"]
