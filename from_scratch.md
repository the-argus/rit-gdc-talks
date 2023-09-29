# Making Games from Scratch

Meaning **no game engine.**

---

## Thesis

The point of this talk is that making games from scratch will make you a better
programmer. It will give you more tools in your toolbelt and free you from
engine vendor lock-in.

Note: making your own engine will teach you _every_ engine

---

## Part One

Precedent.

---

### Super Meat Boy

---

### Braid

---

### The Witness

---

### Minecraft

---

### Don't Starve

---

### No Man's Sky

---

### Soma

---

### Guacamelee

---

### Factorio

---

### Prison Architect

---

### Thimbleweed Park

---

### Celeste

---

### Overgrowth

---

### Slay the Spire

---

### Hades

---

### Pyre

---

### FTL: Faster Than Light

---

### Thumper

---

### Papers Please

---

### Stardew Valley

---

### Teardown

---

### Darkest Dungeon

---

## A Few AAA Examples

- Sunset Overdrive
- Spiderman PS4
- Basically all of Insomniac's games
- Super Mario 64
- Pretty much every game made before the year 2000
- Fortnite and any Epic in-house titles, sort of
- EA titles developed in their in-house Frostbite Engine
- Many more

Note: But hey, you say. What about all the new games? Arent't EA, CD Projekt Red,
and Riot all using Unreal Engine?

---

## Yes, a lot of AAA studios use unreal

But they modify it.

Note: the best record of this I could find was from an indie dev, a studio
called The Astronauts. In my references I've linked to an article by their
engine programmer about all the stuff he had to modify to get UE4 working for
their usecase. I can't say for certain but I am pretty sure that there is at least
small modifications being made to the unreal engine by AAA studios using it. So
source: trust me bro. There's no way they call Epic Support every time they have
a rendering problem.
Also my friend did an _internship_ at Iron Galaxy Studios and literally all
they did was mod the Unreal Engine.

---

## Part Two

Artistic Integrity and Control

---

## The Witness's Perfect Physics

- _Killing the Walk Monster_ by Casey Muratori
- There is no jumping in _The Witness_
- Deterministic
- Only known bugs are a level designer oversight and a menu/UI exploit
- Excellent art/level creation tooling

Note: first, an example of control for programmers

---

## "The AAA Promise"

- PBR Pipeline
- Unity URP bloom and default material
- Engine Physics

Note: Unreal Engine feels like it's promising you a AAA-looking product for less
effort, with its deferred renderer and PBR pipeline and well-populated asset
store. This can sometimes prevent an indie project from developing a unique
graphical style. The same is true of Unity and Unreal physics. If you leave
too many values at their defaults, it becomes obvious (at least to me) that the
project was made in one of these engines, which breaks the sense of legitimacy
that I feel comprehensive experiences like games need to hold.

---

## Artistic Integrity and Game Identity

- Avoid the unity default material
- No fighting the engine to look different than the type of games it usually makes
- Artifacts of "bad" programming:
  - Quake/Source strafing
  - All speedrunning ever
  - Wave Dashing
- Limitations may help

---

## Part Three

Challenges

---

## Streaming and 3D Physics

Two very real and difficult problems are:

- open-world content streaming
- Physics, particularly 3D physics

Note: Streaming is the source of the infamous cyberpunk 2077 launch bugs! and
there and many more. These are just two examples of some very difficult problems
in gamedev. There are many others.

---

## Do you need streaming? Do you need 3D physics?

Note: What is appropriate for your game? If you really have a large number of
big assets in an open world, then you should heavily consider using unreal. But
maybe not!

Note: consider the kind of problems you'll need to solve. for the most part, the
logic of what's easy in a game engine applies also to from-scratch: if it's been
done before, many times, it's probably not where you're going to spend most of
your time. Usually elements unique to your game are where you will spend the
most time. You will see less variation in the amount of time you spend on these
game specific elements, ie. doing it in an engine or from scratch will both take
a while. So consider what kind of boilerplate, already-solved problems you will
need to solve. Same thing as before: open world streaming, 3D physics, the
complexity of your asset pipeline.

---

## Systemic vs. Content Driven

- How procedural is your game?
- How much content needs to be in your game?

Consider how composable your mechanics. A game with a lot of emergent gameplay
from a few different, colliding systems may be easier to program than a game
which simply has a lot of induvidual mechanics. Simple but numerous is generally
more suited for a game engine, whereas complex but few is good for from-scratch.

---

## Experimental-ness

Do you have a known core gameplay loop?

Note: If you're making a top-down bullet hell rougelike, I would say that's a
great candidate for making from scratch. If you're making an experimental first
person shooter with no guns and a character who can only walk backwards, you
probably don't want to dive headfirst into that only to discover ten hours in
that your game idea isn't fun at all. But, if you only need that initial pass,
consider prototyping in unity and then restarting from scratch if things work
out. Sound tedious, but it is much easier to make a game once you've already
made it once.

---

## Do you like it?

Note: this is the real reason I program games from scratch. I just... like it.
I like the control. I like my whole game being text files. I like systems
programming. If you don't like it, then go ahead and never do it, that's fine.
Don't feel like you have to if you've got a game idea which would be a good fit
for the method. Just do what you like. But please, try making a game from scratch
at least once.

---

## Part Four

Actually doing it.

Note: So, enough about existing examples. Let's talk about why you, indie dev,
probably a Unity user, would want to write their games from scratch.

---

## Simplicity

- No engine means gigabytes less of an installation, getting up and running
  faster
- Fewer existing systems means less stuff to understand
- Better and simpler languages than C++ and C#. Or maybe also use those
  languages! up to you.

Note: My apologies to both C++ and C#. I actually am employed to write C++ so
also please don't tell anyone I said that.

---

## Options

- C and C++: Raylib (my personal favorite)
- C#: Monogame
- Python: Pygame, Arcade
- Javascript and Typescript: PixiJS
- For more check out [https://github.com/Calinou/awesome-gamedev#programming-frameworks-and-libraries](https://github.com/Calinou/awesome-gamedev#programming-frameworks-and-libraries)

Note: And there are many others out there. Main point here is the freedom of
choice, and the fact that all of these are free and open source.

---

## Seriously, you can use whatever language you want

Meet Nim, Rust, Zig, Jai, and Odin.

---

## Nim

```nim
import std/strformat

type
  Person = object
    name: string
    age: Natural # Ensures the age is positive

let people = [
  Person(name: "John", age: 45),
  Person(name: "Kate", age: 30)
]

for person in people:
  # Type-safe string interpolation,
  # evaluated at compile time.
  echo(fmt"{person.name} is {person.age} years old")
```

Note: nim is a compiled language. In fact, it transpiles to C, so in theory it
should be just as fast. Sort of like C++. However, nim gets rid of many archaic
features from C-family languages, and replaces them with python-like niceties.
Nim notably supports hot reloading. This means you can edit your code and watch
your game change, without having to restart it. Extremely productive tool to have
if you have two monitors.

---

## Rust

```rs
// A struct with two fields
struct Point {
    x: f32,
    y: f32,
}

// Structs can be reused as fields of another struct
struct Rectangle {
    // A rectangle can be specified by where the top left and bottom right
    // corners are in space.
    top_left: Point,
    bottom_right: Point,
}

fn main() {
    // Create struct with field init shorthand
    let name = String::from("Peter");
    let age = 27;
    let peter = Person { name, age };

    // Print debug struct
    println!("{:?}", peter);

    // Instantiate a `Point`
    let point: Point = Point { x: 10.3, y: 0.4 };

    // Access the fields of the point
    println!("point coordinates: ({}, {})", point.x, point.y);
}
```

Note: Rust is another option. It is known for being memory safe, thanks to the
concept of the borrow checker. The borrow checker is a difficult concept to
learn for beginner programmers, but once you figure it out it can be an
incredible aid for writing bug-free code. Some say: "if Rust compiles, it works."
Rust can be difficult to use for quick iteration workflows due to both its
slow compile times and strict rules for code. However, for those of you who like
writing "correct" code, Rust is probably for you. It can be very fast and has
a large library ecosystem.

---

## Zig

```ts
const std = @import("std");
const parseInt = std.fmt.parseInt;

test "parse integers" {
    const input = "123 67 89,99";
    const ally = std.testing.allocator;

    var list = std.ArrayList(u32).init(ally);
    // Ensure the list is freed at scope exit.
    // Try commenting out this line!
    defer list.deinit();

    var it = std.mem.tokenize(u8, input, " ,");
    while (it.next()) |num| {
        const n = try parseInt(u32, num, 10);
        try list.append(n);
    }

    const expected = [_]u32{ 123, 67, 89, 99 };

    for (expected, list.items) |exp, actual| {
        try std.testing.expectEqual(exp, actual);
    }
}
```

Note: don't be fooled by the "const" and imports. This is Zig, not javascript.
Zig is an extremely fast systems programming language which looks to replace
C. Unlike Rust, there are few rules and iteration is quick. The language revolves
around the comptime keyword, which enables you to run code that does crazy stuff
like iterate over a bunch of types and choose the smallest one, or something.
Such evaluation occurs at compile time and does not slow down your program with
any dynamic execution.
Notable features are builtin vector types (no need to import a math library)
and upcoming hot code reload! Exciting. This one's my favorite.

---

## Jai

```txt
generate_linear_srgb :: () -> [] float {
     srgb_table: float[SRGB_TABLE_SIZE];
     for srgb_table {
         << it = real_linear_to_srgb(cast(float)it_index / SRGB_TABLE_SIZE)
     }
     return srgb_table;
}

srgb_table: [] float = #run generate_linear_srgb(); // #run invokes the compile time execution

real_linear_to_srgb :: (f: float) -> float {
    table_index := cast(int)(f * SRGB_TABLE_SIZE);
    return srgb_table[table_index];
}
```

Note: Jai is a C-like language developed by Jonathan Blow, the creator of The Witness
and Braid. It supports arbitrary compile-time code execution, just like Zig.
Currently it is closed source and in a closed beta, but keep your eye on it.
It is specifically designed for programming games.

---

## Odin

```odin
package main

import "core:fmt"

main :: proc() {
 program := "+ + * 😃 - /"
 accumulator := 0

 for token in program {
  switch token {
  case '+': accumulator += 1
  case '-': accumulator -= 1
  case '*': accumulator *= 2
  case '/': accumulator /= 2
  case '😃': accumulator *= accumulator
  case: // Ignore everything else
  }
 }

 fmt.printf("The program \"%s\" calculates the value %d\n",
            program, accumulator)
}
```

Note: Odin is yet another low level programming language which has convenient
bindings for graphics drivers like OpenGL, Vulkan, DirectX, etc. I am unfamiliar
with it but it is supposedly designed for game development (or at least, 3D
application development).

---

## Modularity

Load libraries when you need them.

Note: If you don't want to do 2D physics yourself, just load Chipmunk2D. Don't
want to do GUI? Just load ImGui. So on an so forth. You can bring in libraries
in a way that is appropriate for your project so as to reduce bloat and increase
code maintainability.

---

## On C

Please try it. It seems intimidating, but once you learn what pointers are, you
pretty much have the whole world at your command. You _will_ come out a much
better programmer on the other side.

Note: those of you who are CS students, please pay attention in your MOPS
course. It's a really good class, even though it's known to "mops" the floor
with people.

---

## Installation Walkthrough

I'll put my money where my mouth is.

Note: So, just to prove that I think this process is simple, I'm going to walk
all of you installing Raylib.
SET TIMER FOR 30 MINUTES
we'll install raylib and a C compiler on all of your computers, as well as a
simple template project. I'm setting a timer for 30 minutes. Once that's up,
we'll spend the rest of the time talking about a game I'm currently working on
and how writing it from scratch has helped me.

---

## References

- [“You’re on UE4, why do you need an engine programmer?”](https://medium.com/@TheIneQuation/leszek-godlewski-s-blog-you-re-on-ue4-why-do-you-need-an-engine-programmer-1a21ccbc917d)
- [Killing the Walk Monster](https://www.youtube.com/watch?v=YE8MVNMzpbo)
- [CD Projekt Red Video Tweet about streaming](https://twitter.com/CyberpunkGame/status/1349462362764537862)
- [Game Studios That Switched To Unreal Engine For Flexibility and New Hiring Opportunities](https://gameworldobserver.com/2022/03/22/5-game-studios-that-switched-to-unreal-engine-for-flexibility-and-new-hiring-opportunities)
- [Make Your Own Game Engine](https://www.anthropicstudios.com/2023/09/13/make-your-own-game-engine/)
- [Reddit Post Where People Agree With Me, That's It. This Isn't A Legitimate Source](https://www.reddit.com/r/gamedev/comments/7tj8yb/why_do_many_developers_use_inhouse_game_engines/)

Note: sorry for no real bibliography, I am lazy >:)
