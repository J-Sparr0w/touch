const std = @import("std");

fn usage() !void {
    // var usage_str = "";
    var stderr = std.io.getStdErr().writer();
    try stderr.print("Usage: touch [FILE]", .{});
}

pub fn main() !u8 {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var allocator = gpa.allocator();
    var args = try std.process.argsWithAllocator(allocator);
    defer args.deinit();
    _ = args.skip();
    if (args.next()) |arg| {
        if (std.mem.eql(u8, arg, ".")) {
            try usage();
            return 0x7f;
        } else {
            const file = try std.fs.cwd().createFile(
                arg,
                .{},
            );
            defer file.close();
        }
    } else {
        try usage();
        return 0x7f;
    }
    return 0;
}

test "simple test" {}
