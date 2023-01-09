local meta = {}
meta.__index = meta

function meta:GetLight()
    return self.__light
end

function meta:IsValid()
    return self:GetLight() ~= nil
end

function meta:LightIndex()
    return self.__number or -1
end

function meta:__tostring()
    return string.format( 'Dynamic Light [%s]', self:LightIndex() )
end

function meta:Remove()
    local light = self:GetLight()
    if (light) then
        light.dietime = 0
    end
end

-- Position
function meta:GetPos()
    return self.__pos
end

function meta:SetPos( vector )
    self.__pos = vector

    local light = self:GetLight()
    if (light) then
        light.pos = self:GetPos()
    end
end

-- Color
function meta:GetColor()
    return self.__color
end

function meta:SetColorUnpacked( r, g, b, a )
    local color = self:GetColor()
    color.r = r or 0
    color.g = g or 0
    color.b = b or 0
    color.a = a or 255

    local light = self:GetLight()
    if (light) then
        local invertedAlpha = (255 - color.a)
        light.r = math.max( 0, color.r - invertedAlpha )
        light.g = math.max( 0, color.g - invertedAlpha )
        light.b = math.max( 0, color.b - invertedAlpha )
    end
end

function meta:SetColor( color )
    self:SetColorUnpacked( color.r, color.g, color.b, color.a )
end

-- Alpha
function meta:GetAlpha()
    return self:GetColor().a
end

function meta:SetAlpha( int )
    local color = self:GetColor()
    color.a = int

    self:SetColor( color )
end

-- DeathTime
function meta:GetDeathTime()
    return self.__dietime or 0
end

function meta:SetDeathTime( int )
    self.__dietime = int

    local light = self:GetLight()
    if (light) then
        light.dietime = self:GetDeathTime()
    end
end

-- LifeTime
function meta:GetLifeTime()
    return CurTime() - self:GetDeathTime()
end

function meta:SetLifeTime( int )
    self:SetDeathTime( CurTime() + int )
end

-- Brightness
function meta:GetBrightness()
    return self.__brightness or 1
end

function meta:SetBrightness( int )
    self.__brightness = math.max( 0, int )

    local light = self:GetLight()
    if (light) then
        light.brightness = self:GetBrightness()
    end
end

-- Light Size
function meta:GetSize()
    return self.__size or 0
end

function meta:SetSize( int )
    self.__size = int

    local light = self:GetLight()
    if (light) then
        light.size = self:GetSize()
    end
end

-- Light Style
function meta:GetStyle()
    return self.__style or 0
end

function meta:SetStyle( int )
    self.__style = int

    local light = self:GetLight()
    if (light) then
        light.style = self:GetStyle()
    end
end

-- No World Lighting
function meta:GetNoWorld()
    return self.__noworld or false
end

function meta:SetNoWorld( bool )
    self.__noworld = bool == true

    local light = self:GetLight()
    if (light) then
        light.noworld = self:GetNoWorld()
    end
end

-- No Model Lighting
function meta:GetNoModel()
    return self.__nomodel or true
end

function meta:SetNoModel( bool )
    self.__nomodel = bool == true

    local light = self:GetLight()
    if (light) then
        light.nomodel = self:GetNoModel()
    end
end

-- Mininal Light
function meta:GetMinLight()
    return self.__minlight or 0
end

function meta:SetMinLight( int )
    self.__minlight = int

    local light = self:GetLight()
    if (light) then
        light.minlight = self:GetMinLight()
    end
end

function CreateDynamicLight( index )
    local light = DynamicLight( index )
    light.decay = 0

    local new = setmetatable( {
        ['__number'] = index,
        ['__color'] = Color( 255, 255, 255 ),
        ['__light'] = light
    }, meta )

    new:SetLifeTime( math.huge )
    new:SetBrightness( 2 )
    new:SetPos( Vector() )

    return new
end