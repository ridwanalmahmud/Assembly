ASM := nasm
ASMFLAGS := -f elf64
LD := clang
LDFLAGS := -nostdlib -target x86_64-linux-gnu -static -fuse-ld=lld

SRC_DIR := src
BIN_DIR := bin

SRC_FILES := $(wildcard $(SRC_DIR)/*.asm)
BIN_TARGETS := $(patsubst $(SRC_DIR)/%.asm, $(BIN_DIR)/%, $(SRC_FILES))

.PHONY: all clean

all: $(BIN_TARGETS)

$(BIN_DIR)/%: $(SRC_DIR)/%.asm
	@mkdir -p $(BIN_DIR)
	$(ASM) $(ASMFLAGS) $< -o $(@).o
	$(LD) $(LDFLAGS) $(@).o -o $@
	@rm -f $(@).o

clean:
	rm -rf $(BIN_DIR)

%:
	@:
