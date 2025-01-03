-- @popbottoms

local HttpService = game:GetService("HttpService")

local function GenerateGUID()
	return string.gsub(HttpService:GenerateGUID(false), "-", "")
end

local function Preserve(OriginalLinks, v)
	local GUID = GenerateGUID()
	v:SetAttribute("__objectid__", GUID)
	v.Archivable = true
	OriginalLinks[GUID] = v
end

local function PreserveClone(Inst)
	local OriginalLinks = {}

	Preserve(OriginalLinks, Inst)
	for _, v in Inst:GetDescendants() do
		Preserve(OriginalLinks, v)
	end

	local OriginalTracebacks = {}
	local Clone = Inst:Clone()

	OriginalTracebacks[Clone] = OriginalLinks[Clone:GetAttribute("__objectid__")]
	Clone:SetAttribute("__objectid__", nil)
	for _, v in Clone:GetDescendants() do
		OriginalTracebacks[v] = OriginalLinks[v:GetAttribute("__objectid__")]
		v:SetAttribute("__objectid__", nil)
	end

	return Clone, OriginalTracebacks
end

return PreserveClone
