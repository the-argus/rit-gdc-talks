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

### What is Zig *not* good at?

- Safety guarantees (use after free allowed!)
- Shipping generic code over library / team boundaries
- Zig is not 1.0 yet

---

### What it comes down to

- Rust covers a fair bit of Zig's use case but not all
- If you don't like using a complicated language, use Zig

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

## Import syntax

```rust
use std::io;
use mycrate::thing;
```

```zig
const io = @import("std").io;
const thing = @import("relative/path/to/myfile.zig").thing;
```

---

## pub keyword

- Files (structs, they're the same) are the only scope of encapsulation
- Think of it like everything is `static` in C, unless you mark it `pub`

```zig
// fileone.zig ------
const test = 1;
// filetwo.zig ------
const test = @import("fileone.zig").test; // doesn't work without pub
```

---
