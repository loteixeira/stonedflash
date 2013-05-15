# WINDOWS WORK-AROUND (don't ask me)
# if you're not using windows you can comment the line below
SHELL=c:/windows/system32/cmd.exe

# external applications
SWF_COM=mxmlc
SWC_COM=compc

# project paths
SOURCE_PATH=src/

# test stuff
TEST_BIN=bin/stonedflash-test.swf
TEST_MAIN=src/StonedTest.as
TEST_FLAGS=-debug=false -static-link-runtime-shared-libraries=true -library-path+=lib/

# library stuff
LIB_PATH=src/stoned
LIB_BIN=bin/stonedflash.swc
LIB_FLAGS=-debug=false


all: test library

test:
	$(SWF_COM) $(TEST_FLAGS) -source-path+=$(SOURCE_PATH) -output=$(TEST_BIN) -- $(TEST_MAIN)

library:
	$(SWC_COM) $(LIB_FLAGS) -include-sources=$(LIB_PATH) -output=$(LIB_BIN)