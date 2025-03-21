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

### What it comes down to

- Rust covers a fair bit of Zig's use case but not all
- Regardless, if you don't want to lose the simplicity of C, use Zig

---

## Part II: Syntax

---

```zig
const std = @import("std");
const builtin = @import("builtin");

pub fn main() !void {
    std.debug.print("Hello from Zig {}", .{builtin.zig_version});
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
}
```

---

### Files are structs

```zig
// my_struct_as_file.zig

member1: i32,
member2: f32,

// main.zig

const MyStruct = @import("my_struct_as_file.zig");

var instance = MyStruct{};
```

---

### pub keyword

- Structs (so also files) are the only scope of encapsulation
- Think of it like everything is `static` in C, unless you mark it `pub`

```zig
// fileone.zig ------
const test = 1;
pub const pubtest = 1;
// filetwo.zig ------
const test = @import("fileone.zig").test; // doesn't work
const pubtest = @import("fileone.zig").pubtest; // doesn't work
```

---

### Zig language demo

---

### Zig buildsystem / C interop demo

---

## Part III : An argument for the safety of Zig

Not as good as Rust, but remarkably close

Note: This has two parts, arguing that rust is not that safe, or at least that
it has to employ runtime abstractions to be safe, and then arguing that Zig
provides tools to be safe with 90% certainty for 90% of the cases covered by Rust.
Rust still has the 100% guarantee in the single threaded case.

---

### Single-threaded UB

- Buffer overwrite/read
- Integer overflow
- Double free and **Use-after-free**

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

---

### How zig wins in multithreaded UB department

- Situations where allocators handle lifetimes can simplify multithreaded code
- native coroutine support is coming to Zig

Note: This latter one is crazy useful if they handle it well and honestly is one
of my main deciding factors of zig over rust. but it's not in the language yet!

---

### Back to single-threaded

---

### How do we avoid use-after-free

- Borrow checker
- Runtime abstraction (use integers as indices into a vec + generations)
  - `slotmap` crate
  - allows for more than borrow checker allows
- Zig says: this isnt hard, use allocators

### Model lifetimes with ArenaAllocator and MemoryPool

- Grouped lifetimes go into ArenaAllocator
- Different lifetimes of the same type go in MemoryPool
- Possible to replicate `slotmap` crate on top of MemoryPool
  - This makes use after free of these objects defined behavior

Note: basically trust us, when you start to use this method, especially arenas,
you start to realize how the C style method of mallocing and freeing everything
induvidually made everything way, way harder than it needed to be, and rust and
C++ and the concept of RAII is kind of unecessary.

### AND Zig achieves this safety as a simple language

- This may convince some just on preference
