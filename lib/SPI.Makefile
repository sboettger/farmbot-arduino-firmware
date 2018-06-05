DEP_SPI_BUILD_DIR := $(FBARDUINO_FIRMWARE_LIB_BUILD_DIR)/SPI
DEP_SPI := $(DEP_SPI_BUILD_DIR)/SPI.a
DEP_SPI_SRC_DIR := $(ARDUINO_INSTALL_DIR)/hardware/arduino/avr/libraries/SPI/src

DEP_SPI_CFLAGS := \
	-I$(DEP_SPI_SRC_DIR)

DEP_SPI_LDFLAGS :=

DEP_SPI_CFLAGS := -I$(DEP_SPI_SRC_DIR)
DEP_SPI_LDFLAGS := $(DEP_SPI_BUILD_DIR)/SPI.a -L$(DEP_SPI_BUILD_DIR) -lm

DEP_SPI_ASM_SRC := $(call rwildcard, $(DEP_SPI_SRC_DIR), *.S)
DEP_SPI_ASM_OBJ := $(DEP_SPI_ASM_SRC:.S=.o)

DEP_SPI_C_SRC   := $(call rwildcard, $(DEP_SPI_SRC_DIR), *.c)
DEP_SPI_C_OBJ   := $(DEP_SPI_C_SRC:.c=.o)

DEP_SPI_CXX_SRC := $(call rwildcard, $(DEP_SPI_SRC_DIR), *.cpp)
DEP_SPI_CXX_OBJ := $(DEP_SPI_CXX_SRC:.cpp=.o)

DEP_SPI_ALL_OBJ := $(DEP_SPI_ASM_OBJ) $(DEP_SPI_C_SRC) $(DEP_SPI_CXX_OBJ)

DEP_SPI_SRC := $(DEP_SERVO_ASM_SRC) $(DEP_SERVO_C_SRC) $(CXX_SRC)
DEP_SPI_OBJ := $(patsubst $(DEP_SPI_SRC_DIR)/%,$(DEP_SPI_BUILD_DIR)/%,$(DEP_SPI_ALL_OBJ))

DEP_SPI_DIRS := $(sort $(dir $(DEP_SPI_OBJ)))

ARDUINO_DEP_SPI_CXX_FLAGS_P := $(DEP_CORE_CXX_FLAGS_P) $(DEP_SPI_CFLAGS)

$(DEP_SPI): $(DEP_CORE) $(DEP_SPI_BUILD_DIR) $(DEP_SPI_OBJ)
	$(AR) rcs $(DEP_SPI) $(DEP_SPI_OBJ)

$(DEP_SPI_BUILD_DIR)/%.o: $(DEP_SPI_SRC_DIR)/%.cpp
	$(CXX) $(ARDUINO_DEP_SPI_CXX_FLAGS_P) $< -o $@

$(DEP_SPI_BUILD_DIR):
	$(MKDIR_P) $(DEP_SPI_DIRS)

dep_SPI: $(DEP_SPI)

dep_SPI_clean:
	$(RM) $(DEP_SPI_OBJ)
	$(RM) $(DEP_SPI)
