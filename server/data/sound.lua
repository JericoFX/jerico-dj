local class = require "server.data.utils"
local Sound = {}
local xsound = exports.xsound

function Sound:Play()
    xsound:PlayUrlPos(self.source or -1,self.name, self.url, 1.0, self.position, false)
    xsound:Distance(self.source,self.name,30)
    self.play = "play"
end

function Sound:Pause()
     xsound:Pause(self.source or -1,self.name)
     self.play = "pause"
end

function Sound:Resume()
     xsound:Resume(self.source or -1,self.name)
     self.play = "play"
end

function Sound:Volumen(volume)
    local volume = volume + 0.0
    if volume == 1.0 then 
        volume = 1
    end
     xsound:setVolume(self.source or -1,self.name,tonumber(volume))
end

function Sound:Destroy()
    if not self:getStatus() == "play" or not self:getStatus() == "pause" then return end
     xsound:Destroy(self.source or -1,self.name)
     self.play = false
end

function Sound:getStatus()
    return self.play or false
end

return class.new(Sound)