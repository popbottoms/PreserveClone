
# PreserveClone
Module made for cloning instances while preserving there old instance in Roblox

When you clone an instance in Roblox, you lose the original instances path information. This module fixes that by setting an attribute on the instance and all its descendants, so you can trace back to the original after cloning

I had trouble figuring out how to keep track of original paths when cloning instances a long time ago. This module is the solution I came up with, and hopefully someone will find this helpful

## Usage
```lua
-- Require PreserveClone
local PreserveClone = require(path.to.PreserveClone)

-- We create a model with TWO humanoids
local Mdl = Instance.new("Model")
local Hum1 = Instance.new("Humanoid", Mdl)
local Hum2 = Instance.new("Humanoid", Mdl)

-- We clone the model while preserving the original instances
local ClonedMdl, MdlTracebacks = PreserveClone(Mdl)

-- Reverse the MdlTracebacks table to map old instances to new ones
local OldToNew = {}
for i, v in MdlTracebacks do
	OldToNew[v] = i
end

-- Now, we have our new humanoids from our old humanoids
local NewHum1 = OldToNew[Hum1]
local NewHum2 = OldToNew[Hum2]
```
There is quite a few other use cases for this aswell, not just the one listed here
Another good thing is that Object-Based Properties will be set as their cloned instance rather than their old instance!
