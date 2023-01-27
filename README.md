# Docker Truecrypt

Imagem Docker para executar a ferramenta Truecrypt em linha de comando.

## Motivação

Esta imagem docker foi criada para que fosse possível utilizar a ferramenta **truecrypt** dentro do linux, sem a necessidade de instalá-lo. Como a ferramenta foi descontinuada e já não tem suporte pela maioria das distribuições, esta é uma forma de utilizá-la em linha de comando.

## Build

```zsh
docker build -t truecrypt:1.0 .
docker build -t truecrypt:latest .
```

## Uso

### Execução do container

```zsh
docker run -d --privileged --rm --name truecrypt -v /tmp/Crypt:/crypt truecrypt:latest
```

* `-d`: Executa o container em background.
* `-v`: Mapeia um volume para o container.
* `--privileged`: Permite acesso a recursos do sistema hospedeiro (/dev/loop).
* `--rm`: Remove container ao pará-lo.
* `--name`: Define um nome para o container.

### Volumes

* `/tmp/Crypt:/crypt`: Diretório onde ficam os arquivos gerenciados pelo Truecrypt.
