# tempmail_fish
temp email web api tempmail.fish
# Example
```nim
import asyncdispatch, tempmail_fish, json
let data = waitFor create_email()
echo data["email"].getStr
echo data["authKey"].getStr
```
# Launch (your script)
```
nim c -d:ssl -r  your_app.nim
```
