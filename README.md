⚠️⚠️⚠️ **THIS PROJECT HAS NOT BEEN UPDATED FOR ELM 0.19 AND WILL NOT FUNCTION** ⚠️⚠️⚠️


# elm-pretty-printer

A pretty printing library based off of the [paper by Philip Wadler](https://homepages.inf.ed.ac.uk/wadler/papers/prettier/prettier.pdf).


# Releases
### 1.0.0

Initial release.

### 2.0.0

Change rendering functions to return "success" value instead of a Result type. Add `hardline`.

### 3.0.0

- Remove use of `Formatter` type alias from `Color`, `Underline`, and `Bold` constructors in favor of applying the formatting to the content during the rendering process (`display`). This allows the `Doc` and ` data structure itself to remain uncoupled from the ANSI console.
- `Color` type constructors now have a `ColorBrightness` sum type (`Standard` | `Dark`).
- `RestoreFormat` and `best` now take `isBold` and `isUnderline` bool types over `Maybe Formatter` types.
- `WithFormat` and `WithBold` (`TextFormat`) no longer take `Formatter` arg.
- Fn's from `Console` moved to `consoleFormatting` and `toAnsiColor`, and `ansiBrightness` functions.
- `ConsoleLayer` -> `DocLayer`
- Remove `Formatter` type alias
