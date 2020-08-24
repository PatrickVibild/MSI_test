# BstServices

Server developed in Elixir 1.10. 

Main functionality is implementing a Binary Search Tree (BST) implementation that can create 
new BST from a list of elements or insert a element to an existing BST.

Server exposes a REST API /insert endpoint that requires a json with the arguments  `tree` and `n`.

Example

```
curl --location --request POST 'server_url/insert' \
--header 'Content-Type: application/json' \
--data-raw '{
   "tree": [5, 7, 6, 3, 4],
   "n": 10
}'
```

## Installation

BstService uses [Elixir Mix](https://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html) to build
test and deploy the application.

`mix test`
`mix run --no-halt`
`MIX_ENV=prod mix release`

## Docker
Application is dockerize in a two stage dockerfile. 
For running the application [Bitwalter/alpine-erlang](https://hub.docker.com/r/bitwalker/alpine-erlang) docker image has been choosen
since erlang is already installed by default.

Docker container can be found on Docker public repositories and is been updated on every github master merge.
[Docker Hub - BstService](https://hub.docker.com/r/patrickvibild/bstelixirmsi)

##Deployment

Application deployment can be found at https://bst.patrickvibild.usw1.kubesail.org

The server listens to the endpoints:
1. /insert
>   curl --location --request POST 'https://bst.patrickvibild.usw1.kubesail.org/insert' \
    --header 'Content-Type: application/json' \
    --data-raw '{
       "tree": [
          5,
          7,
          6,
          3,
          4
       ],
       "n": 10
    }'
>> [5,3,4,7,6,10]
2. /status

> curl --location --request GET 'https://bst.patrickvibild.usw1.kubesail.org/status'
>> Healthy

##Coding challenge comments.

Elixir project structure have been following the recommendations from the book [Programming Elixir >=1.6](https://pragprog.com/titles/elixir16/programming-elixir-1-6/)
I never had any previous experience with Elixir. I found it as a interesting paradigm to think only about inputs and outputs without caching any objects.

The Motorola code challenge examples for the BST was declaring inputs and outputs as elixir maps. I decided to 
abstract elixir implementation from the functions and the API by accepting a list instead of a elixir map. This abstraction
also allows a language agnostic endpoint /insert. The core of the module is using maps as marked the PDF challenge, but the
communication with the module is with a list of elements instead.

Given a preorder traversal of a BST I can reconstruct the BST and then add the element. In order for readability, testing and usage
the created BST is returned as its preorder traversal.