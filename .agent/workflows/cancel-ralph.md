---
description: Cancel the active Ralph loop.
---

Cancel the active Ralph loop.

Usage:
`/cancel-ralph`

1. Identify any running background commands initiated by `ralph_gemini.py`.
2. Terminate the identified process using `send_command_input` with the `Terminate` flag set to true.
3. Confirm to the user that the loop has been cancelled.
