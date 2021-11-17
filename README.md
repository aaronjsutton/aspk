# ASPK

A minimal authentication service written in Elixir.

## Overview

Provides a mechanism for authorizing an action or request using a key. It
exposes a single HTTP endpoint for which tokens will be read from a requests
HTTP Basic Authorization header.

## Usage

`ASPK.Server` is implemented as a `GenServer` that and can be run from a
supervision tree. `ASPK.Application` is a standalone OTP application that will
run the server. [Ecto](https://hexdocs.pm/ecto/Ecto.html) is used as the
database engine.

First generate a token using an `iex` console. `ASPK.create_token/0` can be used
for this.

```
iex> ASPK.create_token()
"YOUR_ENCODED_KEY"
```

To authenticate with the server, make a request an include `YOUR_ENCODED_KEY` in
the `Authorization` header as an HTTP Basic credential.

```
curl https://your-endpoint -H "Authorization: Basic YOUR_ENCODED_KEY"`
```

### Status Codes

The server returns the following status codes:

| Code | Description                                                         |
| ---- | ------------------------------------------------------------------- |
| 204  | Authentication was successful.                                      |
| 401  | Authentication request was missing credentials or malformed.        |
| 403  | Authorization credentials are not permitted to access the resource. |

## Security

ASPK keys are **secrets** and should be treated securely, just as your would
with any other API key. Additionally, transporting these credentials over HTTP
is **unsafe**, it is only secure when TLS/SSL is used to secure the connection
between server and client.
