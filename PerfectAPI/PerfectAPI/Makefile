TARGET = PerfectAPI
OS = $(shell uname)
SRC = \
	AccountCreateHandler.swift\
	DefaultHandler.swift\
	PGConnectionExtension.swift\
	AccountGetListHandler.swift\
	PerfectHandler.swift\
	ResponseStatus.swift

PERFECT_ROOT = ../PerfectLib
SWIFTC = swift

SWIFTC_FLAGS = -frontend -c -module-cache-path $(MODULE_CACHE_PATH) -emit-module -I /usr/local/lib -I $(PERFECT_ROOT)/linked/LibEvent \
	-I ../PerfectLib/linked/OpenSSL_Linux -I ../PerfectLib/linked/ICU -I ../PerfectLib/linked/SQLite3 -I ../PerfectLib/linked/LinuxBridge

MODULE_CACHE_PATH = /tmp/modulecache
Linux_SHLIB_PATH = $(shell dirname $(shell dirname $(shell which swiftc)))/lib/swift/linux
SHLIB_PATH = -L$($(OS)_SHLIB_PATH)
LFLAGS = $(SHLIB_PATH) -lFoundation -lswiftCore -lswiftGlibc /usr/local/lib/PerfectLib.so -lpq -Xlinker -rpath -Xlinker $($(OS)_SHLIB_PATH) -shared

all: $(TARGET)

modulecache:
	@mkdir -p $(MODULE_CACHE_PATH)

$(TARGET): modulecache
	$(SWIFTC) $(SWIFTC_FLAGS) $(SRC) -o $@.o -module-name $(TARGET) -emit-module-path $(TARGET).swiftmodule
	clang++ $(LFLAGS) PostgreSQL.o $@.o -o $@.so

clean:
	@rm *.o

restart:
	cd .. && make restart
