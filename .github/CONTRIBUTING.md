# Contributing

Hiya! I'd love for you to contribute to this project.

## Programming Style

Please only contribute to this project if you know Roblox Luau at a mediocre standard, otherwise you won't understand some of the stuff here!

The programming style is the exact same as Roblox lua. Simply use a require function to require Blackbird and you're good to go!

The format for scripting is as follows.

1. Documentation; explain what this module does.
2. Services
3. Declare Blackbird
4. Load libraries with Blackbird
5. Variables
6. Functions
7. Return statement

Example:
```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Blackbird = require(ReplicatedStorage:WaitForChild("Blackbird"))
```
