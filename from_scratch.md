# Making Games from Scratch

Meaning **no game engine.**

---

## Thesis

The point of this talk is that making games from scratch will make you a better
programmer. It will give you more tools in your toolbelt and open your eyes to
how games are made in AAA studios.

Note: And maybe you'll learn to ROMhack along the way. Or make games for an
old console.

---

## Part One

Precedent.

---

## Examples of Such Games

- Super Meat Boy
- Braid
- The Witness
- Minecraft

Note: notice, all indie titles

## More Examples

- Sunset Overdrive
- Spiderman PS4
- Basically all of Insomniac's games
- Super Mario 64
- Pretty much every game made before the year 2000
- Fortnite and any Epic in-house titles, sort of
- EA titles developed in their in-house Frostbite Engine

Note: But hey, you say. What about all the new games? Arent't EA, CD Projekt Red,
and Riot all using Unreal Engine?

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

## The Witness's Perfect Physics

- _Killing the Walk Monster_ by Casey Muratori
- There is no jumping in _The Witness_
- Deterministic
- Only known bugs are a level designer oversight and a menu/UI exploit
- Excellent art/level creation tooling

---

## Failures of From-Scratch Game Development

- Cyberpunk 2077 launch bugs.

Note: Yeah, sorry. So why did it happen? (next slide)

---

## Streaming and 3D Physics

Two very real and difficult problems are:

- open-world content streaming
- Physics, particularly 3D physics

Note: Content streaming is an optimization problem for rendering large
amounts of arbitrary geometry. There are ways to get around this problem, such
as deterministic heightmap or voxel based terrain. If you want to just render
large maps in the style of Just Cause or GTA, an engine is likely of much more
use to you. Additionally, known 3D physics libraries ODE and Bullet are both
pretty annoying to work with and poorly documented, in my experience.
However, such constraints may lead to interesting game quirks, such as quake's
strafing or minecraft's terrain. Or the Witness's physics, for that matter.

---

## The Level Editor Problem

"But you have to make your own level editor!"

Note: In practice, this is basically just adding god mode and pausing the game
while you place stuff down. The hardest part is maybe the file format, but if
you're using a language like C you can just stream out your data directly into
a file a lot of the time.

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
that I feel comprehensive experiences like games need to hold. Might just be me
though, this slide is purely editorial.

---

## Part Two

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
- C#: XNA, AKA Monogame
- Python: Pygame, Arcade
- Javascript and Typescript: PixiJS
- For more check out [https://github.com/Calinou/awesome-gamedev#programming-frameworks-and-libraries](https://github.com/Calinou/awesome-gamedev#programming-frameworks-and-libraries)

Note: And there are many others out there. Main point here is the freedom of
choice, and the fact that all of these are free and open source.

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

## References

- [“You’re on UE4, why do you need an engine programmer?”](https://medium.com/@TheIneQuation/leszek-godlewski-s-blog-you-re-on-ue4-why-do-you-need-an-engine-programmer-1a21ccbc917d)
- [Killing the Walk Monster](https://www.youtube.com/watch?v=YE8MVNMzpbo)
- [CD Projekt Red Video Tweet about streaming](https://twitter.com/CyberpunkGame/status/1349462362764537862)
- [Game Studios That Switched To Unreal Engine For Flexibility and New Hiring Opportunities](https://gameworldobserver.com/2022/03/22/5-game-studios-that-switched-to-unreal-engine-for-flexibility-and-new-hiring-opportunities)
- [Reddit Post Where People Agree With Me, That's It. This Isn't A Legitimate Source](https://www.reddit.com/r/gamedev/comments/7tj8yb/why_do_many_developers_use_inhouse_game_engines/)

Note: sorry for no real bibliography, I am lazy >:)
