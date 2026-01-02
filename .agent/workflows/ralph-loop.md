---
description: Start a Ralph loop in your current session.
---

Start a Ralph loop in your current session.

Usage:
`/ralph-loop "<prompt>" --max-iterations <n> --completion-promise "<text>"`

1. Extract the prompt, max iterations, and completion promise from the user's input.
2. Execute the following command in the background using `run_command` with a generous `WaitMsBeforeAsync`.
// turbo
3. `python e:\ralph-wiggum\ralph_gemini.py "<prompt>" --max-iterations <n> --completion-promise "<text>"`
4. Inform the user that the loop has started and explain how to monitor it using `command_status`.
