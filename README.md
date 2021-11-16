# ASPK

Minimal key-based authentication server.

# Overview

Provides a mechanism for authorizing an action or request using a key. It
exposes a single HTTP endpoint for which tokens will be read from a requests
HTTP Basic Authorization header.

# Usage

Include the ASPK token in the Authorization header of a request. The server will
return `204 No Content` if the request token is valid.
