def _transition_impl(settings, attr):
    # Read the platform attribute from the current rule and set it to the upstream platform. See cc_toolchain_config attrs.
    return {"//command_line_option:platforms": str(attr.base_platform)}

base_toolchain_transition = transition(
    implementation = _transition_impl,
    inputs = [],
    outputs = ["//command_line_option:platforms"],
)

def _base_impl(ctx):
    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = "k8-toolchain",
        host_system_name = "local",
        target_system_name = "local",
        target_cpu = "k8",
        target_libc = "unknown",
        compiler = "clang",
        abi_version = "unknown",
        abi_libc_version = "unknown",
    )

cc_toolchain_base_config = rule(
    implementation = _base_impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)

def _config_impl(ctx):
    # TODO: Modify the CcToolchainConfigInfo from "parent_config" and add flags for  linking against system libs.
    # return modified CcToolchainConfigInfo.
    fail("unimplemented")

cc_toolchain_config = rule(
    implementation = _config_impl,
    attrs = {
        "parent_config": attr.label(),
        "base_platform": attr.label(),
        "libc": attr.label(
            cfg = base_toolchain_transition,
        ),
        "_allowlist_function_transition": attr.label(
            default = "@bazel_tools//tools/allowlists/function_transition_allowlist",
        ),
    },
    provides = [CcToolchainConfigInfo],
)
