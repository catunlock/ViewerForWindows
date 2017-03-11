TEMPLATE    = lib
TARGET      = core
DEFINES     += CORE_LIBRARY  # See Qt Ref doc, "Creating Shared Libraries"

CONFIG      += release plugin
CONFIG      += build_all
CONFIG      *= opengl
QT          += opengl

INCLUDEPATH += include

DESTDIR     = $$(PWD)/../bin

CONFIG(debug, debug|release) {
    TARGET  = $$join(TARGET,,,d)
    MOC_DIR = build/debug
    OBJECTS_DIR = build/debug
    RCC_DIR = build/debug
} else {
    TARGET = $$join(TARGET,,,)
    MOC_DIR = build/release
    OBJECTS_DIR = build/release
    RCC_DIR = build/release
}

# GLEW
#unix:LIBS +=  -lGLU
win32:INCLUDEPATH += J:\LIBRERIAS\glew-2.0.0\include
win32:LIBS += -LJ:/LIBRERIAS/glew-2.0.0/lib/Release/Win32
win32:LIBS += -lglew32

macx:LIBS +=  -install_name $$DESTDIR/libcore.dylib

HEADERS	+= include/*.h
SOURCES	+= src/*.cpp
