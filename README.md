# pdftk-alpine
Docker Container with pdftk allows you to protect PDF files against copy/paste and optionally crypt its content.

## How to use the container

### First, you need to build the docker image :

```bash
$ cd pdftk-alpine
$ docker build . -t pdftk-alpine
```

### Then, to run the pdftk container with the supplied script

In order to forbid copy/paste with DRM :

```bash
$ ./path/to/alpine-pdftk/protect-files.sh ./path/to/file.pdf
```

Same thing with a custom key :

```bash
$ ./path/to/alpine-pdftk/protect-files.sh ./path/to/file.pdf xxxxxx
```

In order to crypt the file :

```bash
$ ./path/to/alpine-pdftk/protect-files.sh ./path/to/file.pdf xxxxxx crypt-key
```

### Running the container by hand

If you want to do it yourself, here's how it works :

```bash
$ cd pdftk-alpine
$ docker build . -t my_pdftk_image
$ cd
$ docker run -it --rm --name=my_pdftk_container -v $(pwd):/files my_pdftk_image ./path/to/file.pdf
```

