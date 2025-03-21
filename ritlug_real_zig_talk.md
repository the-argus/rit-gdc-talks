# Zig

> Zig is a general-purpose programming language and toolchain for maintaining
> robust, optimal and reusable software.

---

## Part I : Overview

---

### What's the appeal?

- Just functions and variables.
- Good if you always need to know exactly what your code is doing
- All about readability and not about writeability

---

### What's the appeal, cont'd

From ziglang.org:

> Focus on debugging your application rather than debugging your programming language
> knowledge.

- No hidden control flow.
- No hidden memory allocations.
- No preprocessor, no macros.

---

### The down low

- Zig is a "domain specific language for generating assembly code"
- Good for extremely robust and reliable software with few dependencies
- Replaces C tooling (autotools, make, cmake, etc)
- Seamless C interop, including ABI compatibility

---

### Examples of projects which might like zig

- Stuff where codegen matters:
  - OS kernel, videogames, other RT software
- One-shot "tasks":
  - file compression library
  - CLI tool
- Everything you would have written in C before you knew about Zig

---

### What is Zig _not_ good at?

- Safety guarantees (use after free allowed!)
- Shipping generic code over library / team boundaries
- Zig is not 1.0 yet

---

### What might you prefer about Zig

- All about being simple, easy for even newcomers to understand
- Minimal departure from C
- Metaprogramming with simple rules, duck typing instead of traits

Note: this is a few things which induvidually have impact on the strengths of
Zig and the domains it is best suited for, but I'm listing them here to point
out that they are all subjective reasons you might like Zig. So if this sounds
like your style, try Zig!

---

## Part II: Syntax

---

```zig
const std = @import("std");

pub fn main() !void {
    std.debug.print("Hello, World", .{});
}
```

---

### Import syntax

```rust
use std::io;
use mycrate::thing;
```

```zig
const io = @import("std").io;
const thing = @import("relative/path/to/myfile.zig").thing;
```

Note: notice that nothing is global in the zig example, no universally accessible
mycrate symbol. The only "global" things are the compiler builtins like @import
which always start with that @ symbol, and "std" and "builtin".

---

### Meaning of `const`

If the type of the `const` variable is a type or it can be determined at compile
time, it is compile time.

If `const` is dependant on something that is `var`, it just means it can't be
reassigned but is runtime known.

---

### `struct` keyword

```zig
const MyStruct = struct {
    member1: i32,    
    member2: f64,    
};
```

---

### Files are structs

```zig
// my_struct_as_file.zig
member1: i32,
member2: f32,
```

```zig
// main.zig
const MyStruct = @import("my_struct_as_file.zig");
var instance = MyStruct{ .member1 = 42, .member2 = 42 };
```

---

### `pub` keyword

- Structs (so also files) are the only scope of encapsulation
- Think of it like everything is `static` in C, unless you mark it `pub`

```zig
// fileone.zig ------
const test = 1;
pub const pubtest = 1;

// filetwo.zig ------
const pubtest = @import("fileone.zig").pubtest;
const test = @import("fileone.zig").test; // doesn't work
```

---

### Catch vs. try vs. Rust

```rust
while ... {
    let something = potentially_failing()?;
    let Ok(something_else) = potentially_failing else {
        break; // or panic etc
    }
}
```

```zig
while (...) {
    const something = try potentiallyFailing();
    const something_else = potentiallyFailing() catch break;
    // OR
    const something_else = potentiallyFailing() catch {
        break;
    };
}
```

---

### .? vs. Rust unwrap

```rust
// this function returns option
let something = potentially_null()?;
let Some(something_else) = potentially_null else {
    return None;
}
// unwrap is subtly different from zig
// because it consumes the Option
let something_or_panic = potentially_null().unwrap();
```

```zig
const something = potentiallyNull() orelse return null;
const something_else = potentiallyNull() orelse {
    return null;
};
// could also be a default value
const defaulted = potentiallyNull() orelse 0;
const thing_or_panic = potentiallyFailing().?;
```

---

### Dereference operator

```rust
(*get_reference_to_thing()).doSomething();
*get_mut_reference_to_thing() = Thing::new();
```

```zig
getPointerToThing().*.doSomething();
getNonconstPointerToThing().* = Thing.init();
```

Note: zig dereference operator is right hand side, similar to rust's `await`
keyword.

---

### Loop captures

```rust
for (item, index) in myvec.enumerate() {
    //...
}
```

```zig
for (mylist.items, 0..) |item, index| {
    // ...
}
```

---

### Optional captures

```rust
let some_opt = None;
if let Some(opt) = some_opt {
    println!("{opt}");
}
```

```zig
const some_opt: ?u64 = null;
if (some_opt) |opt| {
    std.debug.print("{}\n", .{opt});
}
```

---

### Error handling

```zig
pub fn read(file: File) !?NetPacket {
    var last_command_header: CommandHeader = undefined;

    while (true) {
        // error return path
        last_command_header = try CommandHeader.read(file);

        if (reached_end_of_file) {
            return null;
        } else if (some_other_condition) {
            break;
        }
    }
    // cont'd
```

---

### Error handling, cont'd

```zig
    // only partially initialize packet
    var packet: NetPacket = undefined;

    packet.from = .{
        .type = NetAddressType.NA_LOOPBACK,
        .ip = undefined,
        .port = undefined,
    };

    return packet
}
```

---

### debug print anything

```zig
const std = @import("std");

// anonymous structs here
// could also do `const Thing = struct{ ... }; var instance = Thing{...};
var instance = .{ .member1 = 42, .member2 = 42 };
var ref_instance = .{ .member = 60, .ptr = &instance };

pub fn main() !void {
    std.debug.print("Hello, World, {}", .{ref_instance});
}
```

```txt
Hello, World, tmp_GnnbwbWq7fb_rL1w.ref_instance__struct_23135{ .member = 60, .ptr = tmp_GnnbwbWq7fb_rL1w.instance__struct_23130{ .member1 = 42, .member2 = 42 } }
```

---

### Json serialize and deserialize anything

```zig
const TemplateConfig = struct {
    file_name_replacement_index: u64 = 0,
    replacements: []const []const u8,
    sets: []const []const []const u8,
};

// elsewhere, to read that struct from a file
const file_contents = try json_file.readToEndAlloc(allocator, 999999999);
const template_config = try std.json.parseFromSlice(
    TemplateConfig,
    allocator,
    file_contents,
    std.json.ParseOptions{},
);
```

---

### An interesting data structure: `SegmentedList`

- Ordered, like ArrayList
- O(1) `append` and `pop` and lookup
- Noncontiguous elements
- Stable pointers (not invalidated after append)
- Less memory fragmentation than ArrayList

---

### procedural type logic

```zig
const builtin = @import("builtin");

// has different type in debug mode
read: if (builtin.mode == .Debug) bool else void,
string_slice: []u8,

pub fn readFromBuffer(self: *@This(), buf: *NetworkBitBuffer) !void {
    self.string_slice = try buf.readStringInto(&self.command_buffer);

    if (builtin.mode == .Debug) {
        self.read = true;
    }
}
```

---

### logging

```zig
const log = std.log.scoped(.libdemo);

sequence_number_in: i32,
sequence_number_out: i32,

pub fn read(file: File) !SequenceInfo {
    log.debug("Reading sequence info...", .{});
    // ...
}
```

---

### custom logging callback

```zig
pub fn libdemo_logger(
    comptime level: std.log.Level,
    comptime scope: @TypeOf(.EnumLiteral),
    comptime format: []const u8,
    args: anytype,
) void {
    const leveltext = switch (level) {
        .warn => "WARN",
        .err => "FATAL",
        .info => "INFO",
        .debug => "DEBUG",
    };

    const scope_prefix = if (scope == .libdemo) "" else ("<" ++ @tagName(scope) ++ ">");
    const prefix = "[" ++ leveltext ++ "] " ++ scope_prefix;

    // Print the message to stderr, silently ignoring any errors
    std.debug.getStderrMutex().lock();
    defer std.debug.getStderrMutex().unlock();
    const stderr = std.io.getStdErr().writer();
    nosuspend stderr.print(prefix ++ format ++ "\n", args) catch return;
}

// reserved name
pub const std_options = struct {
    pub const logFn = libdemo_logger;
};
```

---

### Zig language demo

---

### Zig buildsystem / C interop demo

---

## Part III : An argument for the safety of Zig

Not as safe as Rust, but remarkably close

Note: This has two parts, arguing that rust is not that safe, or at least that
it has to employ runtime abstractions to be safe, and then arguing that Zig
provides tools to be safe with 90% certainty for 90% of the cases covered by Rust.
Rust still has the 100% guarantee in the single threaded case.

---

### Single-threaded UB

- Buffer overwrite/read
- Integer overflow
- Double free and **Use-after-free**
- Pointer aliasing

Note: So the big concern here is the use after free. The other two can be solved
with checking etc at the call site, when accessing slices or performing numeric
operations. Also note that I am leaving out stuff like NULL pointer dereference
because those can be fixed with compiler guarantees. These are the bits of UB
which require some overhead to address in both Zig and Rust, either in the program
or in the mind of the programmer.

---

### Multi-threaded UB

- Hardware data race
- Double free and use-after-free, again
- Application level data race (not UB, technically)

Note: This slide is about why I will not be comparing Rust and Zig in regards to
multi-threaded UB. I do think Rust wins out overall in this regard, though.
Once you graduate to multi threaded, the problem of lifetimes becomes
complex enough that you probably need runtime abstraction. Even in a sufficiently
complex single threaded case you might need Cell or RefCell, and when multiple
threads own data then you often need ARCs. Hardware data race can be solved with
atomics and Mutexes and ReadWriteLocks. Neither zig nor rust can solve the
application level data race

---

### How zig loses in multithreaded UB department

- Multithreaded is hard and borrow checker guarantees really help in this case
- No Sync or Send traits
- Worse mutex API, its not a smart pointer
- No ARC in standard lib

---

### How zig wins in multithreaded UB department

- All the runtime abstractions such as ARCs, mutexes, semaphores, thread pool,
  wait groups, atomics, and RWLocks exist in Zig
- Situations where allocators handle lifetimes can simplify multithreaded code
- native coroutine support is coming to Zig

Note: This latter one is crazy useful if they handle it well and honestly is one
of my main deciding factors of zig over rust. but it's not in the language yet!

---

### Back to single-threaded

---

### How do we avoid use-after-free

- Borrow checker
- Runtime abstraction (indices and generations into vec)
  - `slotmap` crate
  - allows for more than the borrow checker, minimal overhead
- Zig says: this isnt hard, use allocators

---

### Model lifetimes with ArenaAllocator and MemoryPool

- Grouped lifetimes go into ArenaAllocator
- Different lifetimes of the same type go in MemoryPool
- Possible to replicate `slotmap` crate on top of MemoryPool
  - Use after free of these objects is then defined behavior

Note: basically trust us, when you start to use this method, especially arenas,
you start to realize how the C style method of mallocing and freeing everything
induvidually made everything way, way harder than it needed to be, and rust and
C++ and the concept of RAII is kind of unecessary.

---

### Thanks for listening

- Try out Zig sometime :)
- [ziglang.org/learn](https://ziglang.org/learn)
- [ziglang.org/documentaiton/master](https://ziglang.org/documentation/master/)
