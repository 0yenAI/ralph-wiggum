# Ralph Wiggum for Gemini CLI & Google IDE Antigravity
# Copyright (c) 2025 0yenAI
# This softare is released under the MIT License.
# https://opensource.org/licenses/MIT

import argparse
import subprocess
import time
import sys
import os

def main():
    """
    Ralph Wiggum Loop Implementation for Gemini CLI & Google IDE Antigravity.
    
    This script repeatedly executes an AI command until a specific "completion promise"
    string is found in the output. It allows for iterative, self-correcting development
    workflows where the AI improves its work over multiple passes.
    """
    parser = argparse.ArgumentParser(
        description="Ralph Wiggum for Gemini CLI & Google IDE Antigravity",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="Example:\n  python ralph_gemini.py \"Fix the bug in main.py\" --completion-promise \"ALL TESTS PASSED\""
    )
    parser.add_argument("prompt", help="The prompt or task description to feed to the AI agent.")
    parser.add_argument("--command", default="gemini", help="The command to invoke the AI (default: 'gemini').")
    parser.add_argument("--completion-promise", required=True, help="The specific string to look for in stdout that signals the task is done.")
    parser.add_argument("--max-iterations", type=int, default=50, help="Maximum number of iterations before giving up (default: 50).")
    parser.add_argument("--interval", type=int, default=2, help="Seconds to wait between iterations (default: 2).")
    parser.add_argument("--verbose", action="store_true", help="Show full output of every iteration.")

    args = parser.parse_args()

    print(f"🔥 Starting Ralph Loop for Google IDE Antigravity...")
    print(f"🤖 Agent Command: {args.command}")
    print(f"🎯 Task: {args.prompt}")
    print(f"🏁 Completion Promise: '{args.completion_promise}'")
    print(f"🔄 Max Iterations: {args.max_iterations}")
    print("=" * 60)

    start_time = time.time()

    for i in range(1, args.max_iterations + 1):
        print(f"\n[Iteration {i}/{args.max_iterations}] Executing AI...")
        
        # Construct the command. 
        # We pass the prompt as an argument. 
        # Ensure your AI tool accepts the prompt as the last argument.
        full_command = f'{args.command} "{args.prompt}"'
        
        try:
            # Execute the command
            result = subprocess.run(
                full_command, 
                shell=True, 
                capture_output=True, 
                text=True,
                encoding='utf-8', 
                errors='replace'
            )
            
            output = result.stdout.strip()
            error_output = result.stderr.strip()
            
            combined_output = output + "\n" + error_output

            if args.verbose:
                print(f"---" + " Output " + "---" + "\n" + combined_output + "\n" + "---" * 5)
            else:
                # specific preview
                preview = output[:200] + "..." if len(output) > 200 else output
                print(f"Output preview: {preview}")

            # Check for completion
            if args.completion_promise in combined_output:
                elapsed = time.time() - start_time
                print(f"\n✅ Completion promise '{args.completion_promise}' detected!")
                print(f"🚀 Task completed in {i} iterations ({elapsed:.1f}s).")
                sys.exit(0)
            
            # Check for hard errors (optional: mostly we want to keep going, but if the tool crashes hard...)
            # Ralph philosophy: "Failures are data". We usually continue.
            if result.returncode != 0:
                 print(f"⚠️ Agent returned exit code {result.returncode}. Retrying...")
            
        except KeyboardInterrupt:
            print("\n🛑 Loop cancelled by user.")
            sys.exit(130)
        except Exception as e:
            print(f"❌ System Error: {e}")
        
        time.sleep(args.interval)

    print(f"\n🛑 Max iterations ({args.max_iterations}) reached without completion.")
    sys.exit(1)

if __name__ == "__main__":
    main()
