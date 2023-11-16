⚠ *(Please note that the commands used by the script are written for Windows, you can modify them manually in the `cmd` table.)*

# References
- src - Source (original) file folder
- mod - Source text pattern modifications folder
- res - Result (output) file folder
- rewriter.lua - The script itself

# Instructions
1. Make a new file in the [mod] folder with the same name as the original one from the [src];
2. Write patterns with the following syntax:
	instance1==modification1;instance2==modification2	...(and so on)
3. Run the script.

# Notes
Original instance follows Lua pattern matching format, which is similar to regex.

# Example
src > test.txt ::
```
Hello human, I'm a talking computer!
I love consuming data (sometimes)!
```

mod > test.txt ::
```
human==user;computer==machine
consuming==being useful;data %(sometimes%)==to everyone
```
