ASM := nasm
ASMFLAGS := -f elf64
LD := clang
LDFLAGS := -nostdlib -target x86_64-linux-gnu -static -fuse-ld=lld

# Directories
SRC_DIR := src
BIN_DIR := bin

# Find all .asm files in src/
SRC_FILES := $(wildcard $(SRC_DIR)/*.asm)
# Generate corresponding binary names in bin/ (e.g., src/foo.asm → bin/foo)
BIN_TARGETS := $(patsubst $(SRC_DIR)/%.asm, $(BIN_DIR)/%, $(SRC_FILES))

.PHONY: all clean

# Default target: build all binaries
all: $(BIN_TARGETS)

# Rule: Assemble .asm → .o, then link → binary
$(BIN_DIR)/%: $(SRC_DIR)/%.asm
	@mkdir -p $(BIN_DIR)  # Ensure bin/ exists
	$(ASM) $(ASMFLAGS) $< -o $(@).o  # Assemble to .o
	$(LD) $(LDFLAGS) $(@).o -o $@    # Link to binary
	@rm -f $(@).o                    # Clean up .o file

# Clean: Remove all binaries and .o files
clean:
	rm -rf $(BIN_DIR)

%:
	@:
