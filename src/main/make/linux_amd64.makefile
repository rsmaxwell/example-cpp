
CC = g++

CFLAGS    = -g -Wall
DEFINES   = 
INCLUDES = -I $(SOURCE)
SOURCES = $(wildcard $(SOURCE)/*.cpp)
HEADERS = $(wildcard $(SOURCE)/*.h) 

NAME = example-cpp
ARTIFACTID = ${NAME}_amd64-linux
VERSION = ${BUILD_ID:-SNAPSHOT}
PACKAGING = zip
ZIPFILE = ${ARTIFACTID}_${VERSION}.${PACKAGING}

all : $(ZIPFILE)

$(NAME): $(SOURCES) $(HEADERS)
	$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) $(SOURCES) -o $(NAME)

$(ZIPFILE): $(NAME)
	$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) $(SOURCES) -o $(NAME)

clean::
	-@rm $(NAME)
