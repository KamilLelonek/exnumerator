# exnumerator

Enum type in Elixir known from [Java](https://docs.oracle.com/javase/tutorial/java/javaOO/enum.html) or [C#](https://msdn.microsoft.com/en-us/library/vstudio/cc138362).

[![Build Status](https://travis-ci.org/KamilLelonek/exnumerator.svg)](https://travis-ci.org/KamilLelonek/exnumerator)

Either in Java or in C# there is `enum` type available. It is a special data type that enables for a variable to be a set of predefined constants. The variable must be equal to one of the values that have been predefined for it. Common examples include compass directions (values of `NORTH`, `SOUTH`, `EAST`, and `WEST`) and the days of the week. You should use enum types any time you need to represent a fixed set of constants. That includes natural enum types such as the planets in our solar system and data sets where you know all possible values at compile time—for example, the choices on a menu, command line flags, and so on.

See more:

* <https://docs.oracle.com/javase/tutorial/java/javaOO/enum.html>
* <https://msdn.microsoft.com/en-us/library/vstudio/cc138362>

## Rationale

Imagine a question that can be either "pending”, "answered, or "flagged”. Or a phone number that’s a "home”, "office”, "mobile”, or "fax” (if it’s 1982).

Some models call for this kind of data. An attribute that can have only one of a few different values. And that set of values almost never changes. It’s a situation where, if it were plain Elixir, you’d just use an atom.

When it comes to a database though, you could create a `PhoneNumberType` or `QuestionStatus` table and a `belongs_to` relationship to hold these values, but that doesn’t seem worth it. You can use [`Ecto.Type`](http://hexdocs.pm/ecto/Ecto.Type.html) behaviour for implementing custom types, but it expects 4 functions to be implemented, and it all becomes an overhead when you need to have many of custom enumerated types.

Here `exnumerator` steps in to give you a handy way to define enumerable types that can be used together with your database. They are kept as `string` type under the hood so whatever database you use (if not postgres for some reason) you can get full benefits from this library.

## Installation

The package can be installed as:

```elixir
def deps do
  [
    {:exnumerator, "~> 1.6"},
    # ...
  ]
end
```

## Usage

This project is helpful if you have both [`ecto`](https://github.com/elixir-lang/ecto) and [`postgrex`](https://github.com/ericmj/postgrex) in your project. It makes no sense to use it without a database.

### Custom type

```elixir
# VALUES as STRINGS
defmodule MyProject.Message.StatusAsString do
  use Exnumerator,
    values: ["sent", "read", "received", "delivered"]
end

# VALUES as ATOMS
defmodule MyProject.Message.StatusAsAtom do
  use Exnumerator,
    values: [:sent, :read, :received, :delivered]
end

# VALUES as KEYWORD
defmodule MyProject.Message.StatusAsKeyword do
  use Exnumerator,
    values: [sent: "S", read: "R", received: "RE", delivered: "D"]
end
```

### Database migration

```elixir
defmodule MyProject.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :status, :string
    end
  end
end
```

### Database schema

```elixir
defmodule MyProject.Message do
  use MyProject.Web, :schema

  schema "messages" do
    field :status, MyProject.Message.StatusAsString
  end
end
```

### Operations

**You can see all available values:**

```elixir
iex(1)> MyProject.Message.StatusAsString.values()
["sent", "read", "received", "delivered"]
```

```elixir
iex(1)> MyProject.Message.StatusAsAtom.values()
[:sent, :read, :received, :delivered]
```

```elixir
iex(1)> MyProject.Message.StatusAsKeyword.values()
[sent: "S", read: "R", received: "RE", delivered: "D"]
```

When you try to insert a record with some value that is not defined, you will get the following error:

```elixir
# Status should be a String or an Atom, depending of what you use.

iex(1)> %MyProject.Message{status: "invalid"} |> MyProject.Repo.insert!()
** (Ecto.ChangeError) value `"invalid"` for `MyProject.Message.status`
   in `insert` does not match type MyProject.Message.status
```

**You can also pick a random value from the predefined set:**

```elixir
iex(1)> MyProject.Message.StatusAsString.sample()
"delivered"

iex(1)> MyProject.Message.StatusAsAtom.sample()
:delivered

iex(1)> MyProject.Message.StatusAsKeyword.sample()
{:delivered, "D"}
```

**You can pick the first value from the predefined set too:**

```elixir
iex(1)> MyProject.Message.StatusAsString.first()
"sent"

iex(1)> MyProject.Message.StatusAsAtom.first()
:sent

iex(1)> MyProject.Message.StatusAsKeyword.first()
{:sent, "S"}
```

## Testing

To test this project you need to run:

    mix test
