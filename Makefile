FILES = ffmpeg ffprobe
DST = /usr/local/bin
SRC = local/bin
.PHONY = $(FILES)

all: compile dist

compile: $(addprefix $(DST)/, $(FILES))

$(DST)/%: $(SRC)/%
	sudo cp $? $@

$(SRC)/%:
	./compile-ffmpeg.sh ffmpeg

dist: archive/.stamp

archive/.stamp: $(addprefix $(SRC)/, $(FILES))
	@ version=$$(local/bin/ffmpeg -version | awk '/ffmpeg version/{print $$3}'| cut -c 5-) && echo $$ver && \
	mkdir -p archive && \
	tar -czvf archive/ffmpeg-$${version}.tar.gz -C local/bin $(FILES)
	@touch archive/.stamp


