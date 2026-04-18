# TypeSpec Extended — Zed

A **TypeSpec** language extension for [Zed](https://zed.dev/) with a
forgiving grammar. Works on standard TypeSpec, and keeps working on the
quirky dialects that real codegen toolchains generate — including the
[ADI Family](https://github.com/adi-family) plugin protocol.

## Highlights

- **Full TypeSpec syntax** — models, scalars, enums, unions, interfaces,
  operations, templates, decorators, namespaces.
- **Dialect-tolerant parser** — accepts three flavors strict TypeSpec
  rejects:
  - `interface Foo { field: string; }` — interfaces used as data holders
    (distinct `interface_property` node, highlighted as fields not
    methods).
  - `@decorator({ k: "v" })` — plain-brace object/array literals in
    decorator arguments, not just the strict `#{ }` / `#[ ]` forms.
  - `int64[][]` — nested array types.
- **ADI plugin protocol ready** — highlights `@plugin`, `@llm.tool`,
  `@llm.trigger`, `@llm.tool.field`, `@llm.trigger.field`, `@validate`,
  and any future decorator naturally as attributes.
- **Proper property highlighting** — fields show up as `@property`,
  keywords as `@keyword`, builtins (`string`, `int32`, `utcDateTime`,
  `Record`, `Array`, ...) as `@type.builtin`, calibrated for Zed's
  theme vocabulary.

## Install

From Zed:

```
cmd-shift-p  →  zed: extensions  →  search "TypeSpec Extended"
```

Or as a dev extension while developing:

```
cmd-shift-p  →  zed: install dev extension  →  pick this folder
```

## Files

- `extension.toml` — manifest, grammar pin.
- `languages/typespec/config.toml` — file association (`.tsp`),
  brackets, indent, comments.
- `languages/typespec/highlights.scm` — syntax highlighting.
- `languages/typespec/indents.scm` — auto-indent rules.
- `languages/typespec/brackets.scm` — bracket matching.

## Grammar

Powered by [mgorunuch/tree-sitter-typespec](https://github.com/mgorunuch/tree-sitter-typespec),
a fork of [happenslol/tree-sitter-typespec](https://github.com/happenslol/tree-sitter-typespec)
with three parse-rule relaxations (documented above). Upstream tests
still pass; the relaxations are additive.

## License

MIT.
