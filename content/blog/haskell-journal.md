+++
title = "My first Haskell experience"
date = 2025-09-03
+++

The other day I was searching through my notes and found this half-complete blog. I wrote it multiple years ago, around 2021-2022, before I became a professional software developer. It was very enlightening (and amusing) to read this so many years later. So, I decided to release this after making some redaction adjustments. I also added some *retrospective notes* about things I find interesting now, so many years later.

Take this as a "Professional programmer reads through his old student FP notes" blog. I hope you find it useful or amusing in any way!

---


A few months ago, I heard about a programming language named *Haskell*, which was said to be *purely functional*. I didn't know much about functional programming at the time, so learning that a language is completely functional caught my attention.
  
Since that day, I started learning Haskell through videos and exercises. The journey was so interesting that I decided to document my experience in this article. Some chapters consist of my personal understanding mechanisms of Haskell's fundamental concepts, while others are about my opinion of specific topics. Needless to say, this journal is subjective and I made it mainly to to consolidate my learning. I hope the reader finds this useful in any way :) .

I want to say thanks to [James Hobson](https://www.youtube.com/channel/UCof1BUiJk7llGSwjl8z27FA) for making his [Haskell tutorial series](https://www.youtube.com/playlist?list=PLNLIbsKl8RYmu_NaSvpvj74MPy8qZSNd8), which I used as my main learning resource throughout this journey.
  
# 0. Prelude
  
  So I'm going to start out by telling you a bit about myself. As at the time of writing, I am a self-taught *hobbyist* developer in the process of becoming a *professional* self-taught developer, whatever that ("professional") means (\*note: this was written around 2021-2022). Right now, I mostly use Python (Django) and Typescript, but I've also used most other popular languages, like C, C++ and Java. Also, I plan on investing a lot of time to learn Rust, as I've had a really good time using it.
  
Before starting to learn Haskell, I had very little experience and knowledge about functional programming. To be honest, I didn't even understand what *imperative* programming really meant! I did know about some of the features of functional programming, though, like anonymous functions and immutability.
  
So, why did I start learning Haskell? Well, a company I was interested in working at was hiring Haskell/functional programmers (which seemed weird to me, as Haskell is not even in the [top 10 most in-demand languages](https://bootcamp.berkeley.edu/blog/most-in-demand-programming-languages/)). So, I decided to take on the challenge, and that led me to Youtube, where there were a lot of talks about how functional programming makes systems more stable and reliable. After watching some of those FP introductory talks, I decided it was time to get my hands dirty with some programming.

# 1. Setup
  
The first video on Hobson's Haskell-tutorial series is about downloading and setting up the tools to work with Haskell. These include Cabal and GHC. So I went to [Haskell's website](https://www.haskell.org/) and downloaded GHCup, which, in turn, installed Cabal, GHC and Stack. This reminded me of [Rustup](https://rustup.rs/), the official Rust toolchain installer,  so I was really happy that a similar tool existed for Haskell.
  
At first, I tried to use Stack because of its "isolated GHC" feature (similar to virtual envs for Python), but it was kind of weird and decided to stick with Cabal.
  
As recommended by Hobson, I typed `cabal v2-repl` to open the interactive mode, which is really nice and useful. At first, I was kind off annoyed to type `v2` before every Cabal command, but after a quick look at `cabal --help`, I noticed I can just use `cabal repl` for development and `cabal v2-repl` when I needed some back-compatibility features.
  
After this, the next step was configuring my favorite editor, [NeoVim](https://neovim.io/), to work with Haskell. I use [coc.nvim](https://github.com/neoclide/coc.nvim) as my auto-completion/IntelliSense plugin, so I was expecting to find a coc.nvim Haskell plugin or something similar that I could install easily with the `:CocInstall` command. Unfortunately, that was not the case. After searching in the coc.nvim docs, I found a [config sample](https://github.com/neoclide/coc.nvim/wiki/Language-servers#haskell) that I could easily copy and paste into my `coc-settings.json` file. After doing that, autocompletion and formatting were working like a charm.

With my environment ready, I dove into what makes Haskell special: everything is a function!
  
# 2. Functions, functions and more functions
  
A *function*, in a mathematical sense, is a relationship that maps a value from a set `A` to a value from a set `B`. According to this definition, values from `A` must have **only one** value from `B` associated to them, so each time you apply the function on the same value, you get the same result (determinism).
  
This notion of function is equally applied to *Haskell functions*, with the special feature that **Haskell functions only take one parameter**. This was the first *weird thing* that I had to understand about Haskell.

> *retrospective note:* In reality, Haskell functions are not really deterministic. The point I was trying to make here is that functions calculate their result using the parameters they are given, as opposed to being able to access state in an effectful manner (e.g. global variables).
  
So, let's take a simple `multiply` function written in C:
  
```c
int multiply(int a, int b) {
  return a * b;
}
```
  
If we wanted to write a `double` function, using our previous `multiply` function, we could do:
  
```c
int double(int a) {
  return multiply(2, a);
}
```
  
Makes sense, right? Now, let's do the same in Haskell:
  
```haskell
multiply a b = a * b
double a = multiply 2 a
```
  
It looks right, and *it works*! We have a (seemingly) pure two-parameter `multiply` function. But, remember what I said about Haskell functions: *they all take one parameter only*; so, what is going on here? Well, it turns out that the C `multiply` function is a function that maps *two `int`s* to another `int`, but the Haskell `multiply` function is a **function that maps an `Int` to a function that maps an (I didn't make a mistake there) `Int` to another `Int`**. The type signature looks like `Int -> Int -> Int` (you can check any function's type signature using the `:t [function]` command from Cabal's REPL). What does this imply? Well, whereas in C, if you try to call `multiply` like `multiply(2)`, you get an error for not sending the right amount of parameters (2); in Haskell, however, **you just get another function**. So, just like that, you can define your `double` function as follows:
  
```haskell
double = multiply 2
-- previous redundant version: double a = multiply 2 a
```
  
So, comparing our two Haskell `double` functions, `double a = multiply 2 a` and `double = multiply 2`, we notice the the former is *redundant*. And this is something that happened to me a lot in the following days, because I usually tried to use typical non-functional patterns that could be simplified using functional patterns. Thankfully, Haskell's language server is very good at detecting these redundancies and pointing them out, which greatly helped in my learning process.

> *retrospective note:* Currying completely amazed me when I first learned it, as you can see from my writing. It soon became one of my favorite techniques to make my code more expressive and elegant.

# 3. Side observations
  
Here are some other observations up to this point that I couldn't fit in the previous sections.

- Lists were really easy to grasp. In a sense, I found Haskell lists like a sort-of merge between C arrays and Python lists, in the way that they are homogeneous (every element must have the same type) but of variable length. Also, there are list comprehensions, really similar to Python's.
- Pattern matching is a really nice feature that allows to change a function's behavior depending on some boolean value. It also was easy to grasp, as it's similar to Rust's `match` and the new Python pattern matching feature..

> *retrospective note:* I think it's interesting how I missed the "strangest" feature of Haskell's lists: they' linked lists!

# 4. Recursion
  
I decided to take a whole chapter on the topic of recursion, as it's one of the parts I most struggled with in Haskell.
  
Recursion means **defining a function in terms of itself**. Quite a simple definition. When I first started learning programming it was a bit hard to understand, but then it became pretty intuitive. In most cases, I've learned to avoid recursion if possible, trying to convert recursive solutions to iterative ones. This is because common programming languages have a *maximum recursion depth*, which limits the amount of recursion you can do. Also, [recursion is slower in some languages](https://softwareengineering.stackexchange.com/questions/237883/is-recursive-code-slower-than-non-recursive-code) and iteration often "feels more natural" to write in imperative languages.
  
In Haskell, however, you don't have iteration. There are no `while` or `for` statements which you can use as naturally do in other languages. You only have recursion. And this is one of the most difficult things to grasp in Haskell and functional languages, as you might so used to imperative iterations that it is really hard to think about recursive solutions.
  
But this is also one of the things **I love** about Haskell! It makes you think in ways you are not used to, which often leads to solutions that are more elegant and "fun", that you wouldn't have thought of when using imperative languages. And, recursion is really optimized in functional-programming languages, so you don't have to worry about the limitations I mentioned before.

# 5. Weird classes: Foldable, Functors, Monads, Monoids...
  
Now we get to an event stranger topic i(and even more fun!). Haskell, being a "mathematical" language, tries to abstract common programming elements/patterns into "classes" (typeclasses, not OOP classes) that you can "instantiate". This is also really difficult to understand at first, as these often have mathematical names and descriptions. Thankfully, the more basic (and elemental) classes are quite easy to understand, once you get over the vocabulary. I'll write my personal explanation of my favorite of the basic typeclasses next: Monoid and Monad.

## Monoid
  
According to [Hackage](https://hackage.haskell.org/package/base-4.16.0.0/docs/Data-Monoid.html):
  
> A type `a` is a Monoid if it provides an associative function (`<>`) that lets you combine any two values of type `a` into one, and a neutral element (`mempty`) such that:
> `a <> mempty == mempty <> a == a`
> 
> A Monoid is a Semigroup with the added requirement of a neutral element. Thus any Monoid is a Semigroup, but not the other way around.
  
Okay, so that explains it pretty well if you ignore the whole "Semigroup" part. But true understanding comes from practical application. For that purpose, let's derive our own Monoid using `Int` and the sum function `(+)`.

### `Int`s can be Monoids
  
From the description above, we get that we need two things: an "associative function" and a "neutral element". Let's suppose our associative function is an `Int` sum. You will notice that the neutral element of sum is 0, because if we add 0 to a number, we get the same number: `a + 0 = 0 + a = a`. That's exactly what is described in the Monoid definition! (`a <> mempty == mempty <> a == a`) So, that means we can define an `Int` as a Monoid whose neutral element is 0:
  
```haskell
instance Monoid Int where
mempty = 0
mappend = (+)
```
  
This will give us an error, as `Int` must be an instance of Semigroup first (Semigroups are just Monoids without the neutral element). So let's define that:
  
```haskell
instance Semigroup Int where
(<>) = (+)

instance Monoid Int where
mempty = 0
```
  
That's it! Now, if we run `(5 :: Int) <> (3 :: Int)`, it will return `8`, meaning we just defined a `Monoid` instance for `Int`.
  
If we wanted to do this with multiplication, we would set `1` as the neutral element (`mempty`).
  
Haskell is based upon these kinds of "*abstracions*" through typeclasses, making code simpler, more "generic", and elegant. A more practical example of how Monoids (and typeclasses in general) can be useful is in Tsoding's video "[How Monoids are useful in Programming?](https://youtu.be/BovTQeDK7XI)". Just another example of how beautiful functional-programming is.

## So, what even are Monads?
  
Monads are perhaps the strangest concept in functional programming. In fact, I've noticed there's a recurring joke that states "Monads cannot be explained". Going back to the definition of Monoid in Hackage, we can say it was pretty self-explanatory even if you're not too used to mathematical language. By contrast, here is the [definition for Monad in Hackage](https://hackage.haskell.org/package/base-4.16.0.0/docs/Control-Monad.html#t:Monad):
  
> The Monad class defines the basic operations over a *monad*, a concept from a branch of mathematics known as *category theory*. From the perspective of a Haskell programmer, however, it is best to think of a monad as an *abstract datatype* of actions. Haskell's `do` expressions provide a convenient syntax for writing monadic expressions.
>
> Instances of Monad should saisfy the following:
> ...
  
From that snippet you can see how even Hackage doesn't bother trying to explain Monads. But this shouldn't be an issue in the long run, as, from what I've seen in some forums, you will eventually get used to Monads, even if you can't define them or explain them properly. So don't get discouraged if you don't understand Monads at first, as it is something most Haskell programmers have gone through.

> *retrospective note:* On Hackage, Monads are defined purely through their behavior (functions), which makes them a bit "cryptic". However, since I wrote that paragraph, I learned a lot of useful analogies and metaphors that bring Monads back to the "real world". It's more a question of vocabulary and the "succintness" of some of the official documentation.

> At this point I got bored of writing and left the journal unfinished (^_^;).

# Retrospective 

Reading this so many years after makes me notice how many things I take for granted nowadays. Say, the language setup section is a bit funny to me now, as I'm so used to installing and uninstalling languages that this is more of an afterthought.

Recursiveness has also become much more intuitive to me now. In fact, I now lean to recursive solutions most of the time, when I'm not constrained by performance or stack sizes.

You can also note, from my writing, the "awe" I felt when talking about the basic typeclasses. I understood them more in a "mathematical sense", just trying to ignore what I didn't understand and go along until I got to do it. And, now, I can happily say it worked! Through a lot of reading and learning from multiple sources, I now understand the basic typeclasses not only as simple "mathematical definitions", but as useful metaphors and analogies that help make code more reusable and elegant.

In conclusion, it was very fun and insightful looking back to the past to see my learning process, especially of this paradigm that I truly feel completely changed the way I write code and see programming in general. It also leaves me as a lesson to write more often so I can do more exercises like this in the future :) .

If you are starting your own FP journey, I encourage you to embrace the confusion and keep trying and learning until things start to "click". And why not keep a journal too? You might thank yourself later ;)

Well, congrats on getting to the end of the article! Thank you for reading, I hope it was fun and somewhat productive! Keep learning!
