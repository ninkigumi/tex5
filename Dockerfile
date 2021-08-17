FROM alpine:3.13.5

RUN apk update
RUN apk --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community add texlive-full=20210325-r4
RUN apk --no-cache add python3 make ghostscript git biber

#### TEST TEXLIVE INSTALLATION ####
#RUN mkdir /tmp/texlive-test
#WORKDIR /tmp/texlive-test
#COPY latex-test .
#RUN pdflatex test.tex

#### CLEAN UP ####
#WORKDIR /
#RUN rm -rf /tmp/*

RUN mkdir -p /System/Library/Fonts \
 && touch '/System/Library/Fonts/ヒラギノ明朝 ProN.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ丸ゴ ProN W4.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ角ゴシック W0.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ角ゴシック W1.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ角ゴシック W2.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ角ゴシック W3.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ角ゴシック W4.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ角ゴシック W5.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ角ゴシック W6.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ角ゴシック W7.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ角ゴシック W8.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ角ゴシック W9.ttc'

#RUN tlmgr repository add http://contrib.texlive.info/current tlcontrib
#RUN tlmgr pinning add tlcontrib '*'
#RUN tlmgr install japanese-otf-nonfree japanese-otf-uptex-nonfree ptex-fontmaps-macos cjk-gs-integrate-macos cjk-gs-integrate adobemapping
#RUN tlmgr path add
#RUN cjk-gs-integrate --link-texmf --cleanup
#RUN cjk-gs-integrate-macos --link-texmf --fontdef-add=cjkgs-macos-highsierra.dat
#RUN mktexlsr
#RUN kanji-config-updmap-sys --jis2004 hiragino-highsierra-pron

RUN curl -fsSL https://www.preining.info/rsa.asc | tlmgr key add -
RUN tlmgr repository add http://contrib.texlive.info/current tlcontrib
RUN tlmgr pinning add tlcontrib '*'
RUN tlmgr repository status
RUN tlmgr install japanese-otf-nonfree japanese-otf-uptex-nonfree ptex-fontmaps-macos cjk-gs-integrate-macos
RUN cjk-gs-integrate --link-texmf --cleanup
RUN cjk-gs-integrate-macos --link-texmf
RUN kanji-config-updmap-sys status


#RUN cjk-gs-integrate --link-texmf --fontdef-add cjkgs-macos-highsierra.dat \
# && cjk-gs-integrate-macos --link-texmf \
# && kanji-config-updmap-sys --jis2004 hiragino-highsierra-pron \
# && mktexlsr \

RUN rm -f /System/Library/Fonts/*.ttc \
 && apk del .build-deps && \
    rm -fr /tmp/install-tl-unx


WORKDIR /data

CMD ["sh"]

