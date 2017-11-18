AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	if SERVER then
		self:SetUseType(SIMPLE_USE)
		self:SetModel("models/hunter/blocks/cube075x2x075.mdl")
		self:PhysicsInit(SOLID_NONE)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetSolid(SOLID_NONE)
		self:SetColor(Color(255,215,155))
		self:DrawShadow(false)

		self:SetAngles(Angle(0,0,90))
		timer.Simple(0.1,function()
			if IsValid(self) then
				self:SetPos(self:GetPos()+Vector(0,0,32))
			end
		end)
	end

	self:SetCollisionGroup(COLLISION_GROUP_NONE)

	if SERVER then
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
		end
	end
	
	self.Sent = false

	self:SetNWString("Item","rubyflask")
	self:SetNWString("ItemName","Ruby Flask")
	self:SetNWString("ItemIcon","hexgm/ui/icon_rubyflask.png")
	self:SetNWString("ItemRarity","common")

	timer.Simple(60,function() if IsValid(self) then self:Remove() end end)
end

function ENT:SetItemInfo(item)
	self:SetNWString("Item",item)

	local function MatchItemtoTable(t)
		for a, b in pairs(HEX.ItemTable) do
			if t == b.id then
				return a
			end
		end
	end
	self:SetNWString("ItemName",HEX.ItemTable[MatchItemtoTable(item)].name)
	self:SetNWString("ItemIcon",HEX.ItemTable[MatchItemtoTable(item)].icon)
	self:SetNWString("ItemRarity",HEX.ItemTable[MatchItemtoTable(item)].itemrarity)
end

function ENT:Think()
end

function ENT:OnRemove()

end