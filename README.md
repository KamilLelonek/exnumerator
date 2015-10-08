# exnumerable

Enum type in Elixir known from [Java](https://docs.oracle.com/javase/tutorial/java/javaOO/enum.html) or [C#](https://msdn.microsoft.com/en-us/library/vstudio/cc138362(v=vs.110).aspx).

Either in Java or in C# there is `enum` type available. It is a special data type that enables for a variable to be a set of predefined constants. The variable must be equal to one of the values that have been predefined for it. Common examples include compass directions (values of `NORTH`, `SOUTH`, `EAST`, and `WEST`) and the days of the week. You should use enum types any time you need to represent a fixed set of constants. That includes natural enum types such as the planets in our solar system and data sets where you know all possible values at compile time—for example, the choices on a menu, command line flags, and so on.

See more:

- https://docs.oracle.com/javase/tutorial/java/javaOO/enum.html
- https://msdn.microsoft.com/en-us/library/vstudio/cc138362(v=vs.110

## Rationale

Imagine a question that can be either "pending”, "answered, or "flagged”. Or a phone number that’s a "home”, "office”, "mobile”, or "fax” (if it’s 1982).

Some models call for this kind of data. An attribute that can have only one of a few different values. And that set of values almost never changes. It’s a situation where, if it were plain Elixir, you’d just use an atom.

When it comes to a database though, you could create a `PhoneNumberType` or `QuestionStatus` table and a `belongs_to` relationship to hold these values, but that doesn’t seem worth it. You can use [`Ecto.Type`](http://hexdocs.pm/ecto/Ecto.Type.html) behaviour for implementing custom types, but it expects 4 functions to be implemented, and it all becomes an overhead when you need to have many of custom enumerated types.

Here `exnumerable` steps in to give you a handy way to define enumerable types that can be used together with your database. They are kept as `string` type under the hood so whatever database you use (if not postgres for some reason) you can get full benefits from this library.

## Installation

The package can be installed as:

  1. Add exnumerable to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:exnumerable, "~> 0.0.1"}]
end
```

  2. Ensure exnumerable is started before your application:

```elixir
def application do
  [applications: [:exnumerable]]
end
```
