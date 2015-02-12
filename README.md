# Learn Elixir by writing a simplified Search Engine

When learning a new language, a frequently asked question is how to
practice effectively.

Besides reading a good book about the language, it's docs, guides and
so on, you may think that it's still missing that hands on project.

That's how this project has born. It's a proposal, under development,
that focus on exercising key concepts and features of the Elixir
language.

This is a specification for building a search engine in Elixir.

## Goal

Write a resilient search engine where new documents can be indexed and
searched.

## Components

In order to achieve that, we are going to write the following
components.

### Tokenizer

Write a function `tokenize/1` that given a document (string) returns a
list of tokens. A token is sequence of one or more characters.

### Index

Write a function `index/2` that given a document and a `Dict`,
tokenizes it using the previous function, returns a new `Dict` with
each token from the document been a keyword and the value been a list
of documents where it occurs.

### Search

Write a function `search/2` where given a `Dict` and a keyword, returns
a the list of documents where the keyword occurs.

## Search Server

In this section we are going to assemble the component in order to
build a search server that indexes and queries the documents.

### Server process

Write a process that wrapps the Search module and accepts messages:

- `{:add_document, document }` that index the document and updates the
  process state with the new dict.
- `{ :query, key_word }` and reply with `{ :ok, results }`

Does the implementation scales writes? Scales reading? Is resilient to
failures? Is `add_document` non blocking? Can you query while indexing
a document?

### GenServer

Rewrite the code from the search server using
[GenServer](http://elixir-lang.org/docs/stable/elixir/GenServer.html)
that handles an `add_document` cast and a `query` call.

## Supervisor

Create a
[Supervisor](http://elixir-lang.org/docs/stable/elixir/Supervisor.html)
for our `SearchServer` in order to restart when it crashes.

A server may crash when, for example, a client pass an unexpected
value to the `add_document` cast.

## Plug a Plug

Expose an HTTP endpoint to our search server using
[Plug](https://github.com/elixir-lang/plug).

## Hot code swap

Reference: Programming Elixir ch8

Add a new call `query_multiple` that receives a list of keywords and
return all documents that match any keyword.

Deploy this new server using hot code swap.

## Scaling

TODO: ...  scale tokenizer workers …••••
