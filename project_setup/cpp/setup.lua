local config = {}

config.PROJECT_TYPE = "cpp"
config.CPP_BUILD_DIR = "build"
config.CPP_STANDARD = "-std=c++23"
config.CPP_CONFIG_CMD = "cmake -S . -B " .. config.CPP_BUILD_DIR
config.CPP_BUILD_CMD = "cmake --build " .. config.CPP_BUILD_DIR
config.CPP_RUN_CMD = config.CPP_BUILD_DIR .. "/a.out"
config.CPP_TEST_CMD = "ctest " .. config.CPP_BUILD_DIR

return config
