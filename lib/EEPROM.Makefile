DEP_EEPROM_BUILD_DIR := $(FBARDUINO_FIRMWARE_LIB_BUILD_DIR)/EEPROM
DEP_EEPROM := $(DEP_EEPROM_BUILD_DIR)/EEPROM.a
DEP_EEPROM_SRC_DIR := $(ARDUINO_INSTALL_DIR)/hardware/arduino/avr/libraries/EEPROM/src

DEP_EEPROM_CFLAGS := \
	-I$(DEP_EEPROM_SRC_DIR)

DEP_EEPROM_LDFLAGS :=

DEP_EEPROM_CFLAGS := -I$(DEP_EEPROM_SRC_DIR)
DEP_EEPROM_LDFLAGS := $(DEP_EEPROM_BUILD_DIR)/EEPROM.a -L$(DEP_EEPROM_BUILD_DIR) -lm

DEP_EEPROM_ASM_SRC := $(call rwildcard, $(DEP_EEPROM_SRC_DIR), *.S)
DEP_EEPROM_ASM_OBJ := $(DEP_EEPROM_ASM_SRC:.S=.o)

DEP_EEPROM_C_SRC   := $(call rwildcard, $(DEP_EEPROM_SRC_DIR), *.c)
DEP_EEPROM_C_OBJ   := $(DEP_EEPROM_C_SRC:.c=.o)

DEP_EEPROM_CXX_SRC := $(call rwildcard, $(DEP_EEPROM_SRC_DIR), *.cpp)
DEP_EEPROM_CXX_OBJ := $(DEP_EEPROM_CXX_SRC:.cpp=.o)

DEP_EEPROM_ALL_OBJ := $(DEP_EEPROM_ASM_OBJ) $(DEP_EEPROM_C_SRC) $(DEP_EEPROM_CXX_OBJ)

DEP_EEPROM_SRC := $(DEP_SERVO_ASM_SRC) $(DEP_SERVO_C_SRC) $(CXX_SRC)
DEP_EEPROM_OBJ := $(patsubst $(DEP_EEPROM_SRC_DIR)/%,$(DEP_EEPROM_BUILD_DIR)/%,$(DEP_EEPROM_ALL_OBJ))

ARDUINO_DEP_EEPROM_CXX_FLAGS_P := $(DEP_CORE_CXX_FLAGS_P) $(DEP_EEPROM_CFLAGS)

$(DEP_EEPROM): $(DEP_CORE) $(DEP_EEPROM_BUILD_DIR) $(DEP_EEPROM_OBJ)
	$(AR) rcs $(DEP_EEPROM) $(DEP_EEPROM_OBJ)

$(DEP_EEPROM_BUILD_DIR)/%.o: $(DEP_EEPROM_SRC_DIR)/%.cpp
	$(CXX) $(ARDUINO_DEP_EEPROM_CXX_FLAGS_P) $< -o $@

$(DEP_EEPROM_BUILD_DIR):
	$(MKDIR_P) $(DEP_EEPROM_BUILD_DIR)

dep_EEPROM: $(DEP_EEPROM)

dep_EEPROM_clean:
	$(RM) $(DEP_EEPROM_OBJ)
	$(RM) $(DEP_EEPROM)
