load(":cc_toolchain_config.bzl", "cc_toolchain_base_config", "cc_toolchain_config")

constraint_setting(
    name = "system_libs",
)

constraint_value(
    name = "not_included",
    constraint_setting = "system_libs",
)

platform(
    name = "linux_x86_64_no_system_libs",
    constraint_values = [
        ":not_included",
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
)

toolchain(
    name = "linux_x86_64_cc_base_toolchain",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
        # IMPORTANT need a more specific toolchain to avoid ambiguous toolchain resolution.
        ":not_included",
    ],
    toolchain = ":k8_base_toolchain",
    toolchain_type = "@rules_cc//cc:toolchain_type",
)

filegroup(name = "empty")

cc_toolchain(
    name = "k8_base_toolchain",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
    toolchain_config = ":k8_toolchain_base_config",
    toolchain_identifier = "k8-toolchain",
)

cc_toolchain_base_config(name = "k8_toolchain_base_config")

cc_library(
    name = "libc",
    # ...
)

cc_toolchain_config(
    name = "k8_toolchain_config",
    base_platform = ":linux_x86_64_no_system_libs",
    libc = ":libc",
    parent_config = ":k8_toolchain_base_config",
)

cc_toolchain(
    name = "k8_toolchain",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
    toolchain_config = ":k8_toolchain_config",
    toolchain_identifier = "k8-toolchain",
)

toolchain(
    name = "linux_x86_64_cc_toolchain",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    toolchain = ":k8_toolchain",
    toolchain_type = "@rules_cc//cc:toolchain_type",
)
