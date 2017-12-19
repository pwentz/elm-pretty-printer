# elm-pretty-printer

A pretty printing library based off of the [paper by Philip Wadler](https://homepages.inf.ed.ac.uk/wadler/papers/prettier/prettier.pdf).

```
$ cd example
$ elm-make --output=elm.js Example.elm && node run.js
```


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
