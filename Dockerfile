FROM alpine:3.13.5

RUN apk update
RUN apk --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community add texlive-full=20210325-r2
RUN apk --no-cache add python3 make ghostscript git biber

#### TEST TEXLIVE INSTALLATION ####
RUN mkdir /tmp/texlive-test
WORKDIR /tmp/texlive-test
COPY latex-test .
RUN pdflatex test.tex

#### CLEAN UP ####
WORKDIR /
RUN rm -rf /tmp/*

WORKDIR /data


