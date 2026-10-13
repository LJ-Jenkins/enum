# Create read-only enum objects

Create an enum object with named members that cannot be modified after
creation.

## Usage

``` r
enum(..., unique = FALSE, class = NULL)

enum_lgl(..., unique = FALSE, class = NULL)

enum_bool(..., unique = FALSE, class = NULL)

enum_num(..., unique = FALSE, class = NULL)

enum_int(..., unique = FALSE, class = NULL)

enum_dbl(..., unique = FALSE, class = NULL)

enum_nmbr(..., unique = FALSE, class = NULL)

enum_chr(..., unique = FALSE, class = NULL)

enum_str(..., unique = FALSE, class = NULL)

enum_fn(..., unique = FALSE, class = NULL)
```

## Arguments

- ...:

  Named members of the enum.

- unique:

  Logical indicating if member values must be unique.

- class:

  Optional custom class to assign to the enum object.

## Value

A locked environment of class `"enum"` containing the read-only named
members.

## Details

The enum object is implemented as an environment with active bindings
for each member, ensuring that the values cannot be modified after
creation.

The strongly typed variants enforce specific types for the enum members,
such as logical (`_lgl`), numeric (`_num`), integer (`_int`), double
(`_dbl`), character (`_chr`), and function (`_fn`).

`enum_bool` enforces that all enum members are either a single `TRUE` or
`FALSE` value.

`enum_str` enforces that all enum members are single, non-`NA`,
non-empty strings.

`enum_nmbr` enforces that all enum members are single, finite numeric
values.

## Note

Members of the enum object will be printed in sorted order by their
names, not in the order they were defined.

## Examples

``` r
enum(a = 1, b = TRUE, c = "text", d = list(x = 1), e = mean)
#> Enum with members:
#>  $a : num 1
#>  $b : logi TRUE
#>  $c : chr "text"
#>  $d :List of 1 $ x: num 1
#>  $e :function (x, ...)  

# enforce type
enum_lgl(yes = TRUE, no = FALSE, unknown = NA)
#> Enum with <lgl> members:
#>  $no      : logi FALSE
#>  $unknown : logi NA
#>  $yes     : logi TRUE
try(enum_bool(yes = TRUE, no = FALSE, unknown = NA))
#> Error : `enum_bool` members must be single logical (non-NA) values.

enum_num(yes = 1L, no = 2.0, maybe = NA_real_)
#> Enum with <num> members:
#>  $maybe : num NA
#>  $no    : num 2
#>  $yes   : int 1
try(enum_nmbr(yes = 1L, no = 2.0, maybe = Inf))
#> Error : `enum_nmbr` members must be scalar finite numerics.

enum_chr(text = "hello", empty = "", missing = NA_character_)
#> Enum with <chr> members:
#>  $empty   : chr ""
#>  $missing : chr NA
#>  $text    : chr "hello"
try(enum_str(text = "hello", empty = "", missing = NA_character_))
#> Error : `enum_str` members must be single (non-NA) strings.

# add class at construction
class(enum(red = 1, class = "Color"))
#> [1] "Color"       "enum"        "environment"
```
