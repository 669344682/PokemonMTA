PokeSlots_C = inherit(Class)

function PokeSlots_C:constructor()
	
	self.screenWidth, self.screenHeight = guiGetScreenSize()
	
	self.slots = 6
	self.slotWidth = self.screenHeight * 0.25
	self.slotHeight = self.screenHeight * 0.055
	self.x = self.screenWidth - self.slotWidth
	self.y = self.screenHeight / 2.1
	self.space = 2.5
	self.alpha = 220
	
	self.pokeSlots = {}
	
	self:init()
	
	if (Settings.showClassDebugInfo == true) then
		mainOutput("PokeSlots_C was started.")
	end
end


function PokeSlots_C:init()
	for i = 1, self.slots - 1 do
		self.pokeSlots[i] = Pokedex[math.random(1, #Pokedex)]
	end
end


function PokeSlots_C:update(delta, renderTarget)
	if (renderTarget) then
	
		dxSetRenderTarget(renderTarget, false)
		dxSetBlendMode("modulate_add")
		
		for i = 1, self.slots do
			local color = tocolor(255, 255, 255, self.alpha)
			
			if (self.pokeSlots[i]) then
				local slotColor = self.pokeSlots[i].color
				color = tocolor(slotColor.r, slotColor.g, slotColor.b, self.alpha * 0.55)
			end
			
			local x = self.x - 5
			local y = ((self.y) + (self.slotHeight * i)) + self.space * i
			
			-- // draw border // --
			dxDrawRectangle (x, y, self.slotWidth, self.slotHeight, tocolor(65, 65, 65, self.alpha), false, true)
			dxDrawImage(x + 2, y + 2, self.slotWidth - 4, self.slotHeight - 4, Textures["gui"].slotBG, 0, 0, 0, color, false)

			if (self.pokeSlots[i]) then
				-- // pokeball // --
				local size = (self.slotHeight / 2) * 0.5
				dxDrawImage(x + 4, y + 4, size, size, Textures["icons"].pokeBallIcon, 0, 0, 0, tocolor(255, 255, 255, self.alpha), false)
				
				-- // pokemon icon // --
				local texture
				
				if (Textures["icons"][self.pokeSlots[i].icon]) then
					texture = Textures["icons"][self.pokeSlots[i].icon]
				else
					texture = Textures["icons"].default_icon
				end
				
				-- // pokemon icon // --
				size = self.slotHeight * 0.8
				dxDrawImage(x + (self.slotHeight / 4), y + (self.slotHeight / 8), size, size, texture, 0, 0, 0, tocolor(255, 255, 255, self.alpha), false)
			else
				-- // pokeball // --
				local size = (self.slotHeight / 2) * 0.5
				dxDrawImage(x + 4, y + 4, size, size, Textures["icons"].pokeBallIconDisabled, 0, 0, 0, tocolor(255, 255, 255, self.alpha), false)
				
				-- // pokemon icon // --
				size = self.slotHeight * 0.8
				dxDrawImage(x + (self.slotHeight / 4), y + (self.slotHeight / 8), size, size, Textures["icons"].default_icon, 0, 0, 0, tocolor(255, 255, 255, self.alpha), false)
			end
		end
		
		dxSetBlendMode("blend")
		dxSetRenderTarget()
	end
end


function PokeSlots_C:clear()
	

end


function PokeSlots_C:destructor()
	self:clear()
	
	if (Settings.showClassDebugInfo == true) then
		mainOutput("PokeSlots_C was deleted.")
	end
end