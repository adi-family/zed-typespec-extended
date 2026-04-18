; Derived from happenslol/tree-sitter-typespec (@395bef1e), with capture
; names adjusted to match Zed's highlight vocabulary (e.g. @property for
; model fields instead of upstream's @variable.member, and @keyword
; instead of the @keyword.type/function/import variants Zed doesn't
; always theme).
;
; ADI decorators (@plugin, @llm.tool, @llm.trigger, @validate, ...) are
; captured by the generic `(decorator ... @attribute)` rule.
;
; This extension uses a fork of the grammar
; (mgorunuch/tree-sitter-typespec, branch adi-dialect) which accepts:
;   - bare data-style members in `interface { ... }` bodies
;     (emitted as `interface_property`)
;   - `{...}` / `[...]` in decorator argument values (in addition to
;     strict `#{...}` / `#[...]`)
;   - nested array types like `int64[][]`.

(identifier_or_member_expression) @type

[
  "is"
  "extends"
  "valueof"
  "typeof"
] @keyword

[
  "namespace"
  "model"
  "scalar"
  "interface"
  "enum"
  "union"
  "alias"
] @keyword

[
  "op"
  "fn"
  "dec"
] @keyword

"extern" @keyword

[
  "import"
  "using"
] @keyword

"const" @keyword

[
  "("
  ")"
  "{"
  "}"
  "<"
  ">"
  "["
  "]"
  "#{"
  "#["
] @punctuation.bracket

[
  ","
  ";"
  "."
  ":"
] @punctuation.delimiter

[
  "|"
  "&"
  "="
  "..."
] @operator

"?" @punctuation.special

[
  (single_line_comment)
  (multi_line_comment)
] @comment

[
  (quoted_string_literal)
  (triple_quoted_string_literal)
] @string

(boolean_literal) @boolean

[
  (decimal_literal)
  (hex_integer_literal)
  (binary_integer_literal)
] @number

(escape_sequence) @string.escape

(builtin_type) @type.builtin

(decorator
  "@" @attribute
  name: (identifier_or_member_expression) @attribute)

(augment_decorator_statement
  name: (identifier_or_member_expression) @attribute)

(using_statement
  module: (identifier_or_member_expression) @type)

(namespace_statement
  name: (identifier_or_member_expression) @type)

(model_statement
  name: (identifier) @type)

(model_property
  name: (identifier) @property)

(union_statement
  name: (identifier) @type)

(union_variant
  name: (identifier) @property)

(scalar_statement
  name: (identifier) @type)

(interface_statement
  name: (identifier) @type)

(interface_member
  name: (identifier) @function.method)

; ADI-dialect addition: interface bodies used as data holders.
(interface_property
  name: (identifier) @property)

(enum_statement
  name: (identifier) @type)

(enum_member
  name: (identifier) @constant)

(operation_statement
  name: (identifier) @function)

(template_parameter
  name: (identifier) @type)

(alias_statement
  name: (identifier) @type)

(decorator_declaration_statement
  name: (identifier) @attribute)

(function_parameter
  name: (identifier) @variable.parameter)

(operation_arguments
  (model_property
    name: (identifier) @variable.parameter))

(const_statement
  name: (identifier) @variable)

(object_member
  key: (identifier) @property)
