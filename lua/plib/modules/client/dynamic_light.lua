local ArgAssert = ArgAssert
local math = math
local hook = hook

local meta = {}
meta.__index = meta
debug.getregistry().DynamicLightLuaObject = meta

function meta:GetLight()
    return self.__light
end

function meta:IsValid()
    return self:GetDieTime() > CurTime() and self:GetLight() ~= nil
end

function meta:LightIndex()
    return self.__number
end

do
    local string_format = string.format
    function meta:__tostring()
        return string_format( 'Dynamic Light [%s]', self:LightIndex() )
    end
end

function meta:Remove()
    self:SetDeathTime( 0 )
    hook.Run( 'DLightRemoved', self )
end

-- Position
function meta:GetPos()
    return self.__pos
end

function meta:SetPos( vector )
    ArgAssert( vector, 1, 'vector' )
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
    ArgAssert( r, 1, 'number' )
    ArgAssert( g, 1, 'number' )
    ArgAssert( b, 1, 'number' )

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
    ArgAssert( color, 1, 'table' )
    self:SetColorUnpacked( color.r, color.g, color.b, color.a )
end

-- Alpha
function meta:GetAlpha()
    return self:GetColor().a
end

function meta:SetAlpha( int )
    ArgAssert( int, 1, 'number' )
    local color = self:GetColor()
    color.a = int

    self:SetColor( color )
end

-- DeathTime
function meta:GetDieTime()
    return self.__dietime or 0
end

function meta:SetDeathTime( int )
    ArgAssert( int, 1, 'number' )
    self.__dietime = int

    local light = self:GetLight()
    if (light) then
        light.dietime = self:GetDieTime()
    end
end

-- LifeTime
do

    local CurTime = CurTime

    function meta:GetLifeTime()
        return CurTime() - self:GetDieTime()
    end

    function meta:SetLifeTime( int )
        ArgAssert( int, 1, 'number' )
        self:SetDeathTime( CurTime() + int )
    end

end

-- Brightness
function meta:GetBrightness()
    return self.__brightness or 1
end

function meta:SetBrightness( int )
    ArgAssert( int, 1, 'number' )
    self.__brightness = math.max( 0, int )

    local light = self:GetLight()
    if (light) then
        light.brightness = self:GetBrightness()
    end
end

-- Light Size
function meta:GetSize()
    return self.__size or 32
end

function meta:SetSize( int )
    ArgAssert( int, 1, 'number' )
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
    ArgAssert( int, 1, 'number' )
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
    ArgAssert( int, 1, 'number' )
    self.__minlight = int

    local light = self:GetLight()
    if (light) then
        light.minlight = self:GetMinLight()
    end
end

do

    local listOfLights = {}

    do

        local pairs = pairs

        do
            local IsValid = IsValid
            hook.Add('PreCleanupMap', 'PLib - Dynamic Light', function()
                for index, light in pairs( listOfLights ) do
                    listOfLights[ index ] = nil
                    if IsValid( light ) then
                        light:Remove()
                    end
                end
            end)
        end

        function game.GetDynamicLightCount()
            local count = 0
            for _, __ in pairs( listOfLights ) do
                count = count + 1
            end

            return count
        end

    end

    do
        local NULL = NULL
        function game.GetDynamicLight( index )
            return listOfLights[ index ] or NULL
        end
    end

    hook.Add('DLightRemoved', 'PLib - Dynamic Light', function( light )
        listOfLights[ light:LightIndex() ] = nil
    end)

    do

        local setmetatable = setmetatable
        local DynamicLight = DynamicLight
        local Vector = Vector
        local Color = Color

        function CreateDynamicLight()
            local index = 1
            while ( listOfLights[ index ] ~= nil ) do
                index = index + 1
            end

            local light = DynamicLight( index )
            light.brightness = 1
            light.decay = 0
            light.size = 32

            local new = setmetatable( {
                ['__number'] = index,
                ['__color'] = Color( 255, 255, 255 ),
                ['__light'] = light
            }, meta )

            listOfLights[ index ] = light
            new:SetLifeTime( math.huge )
            new:SetBrightness( 2 )
            new:SetPos( Vector() )

            hook.Run( 'DLightCreated', new )

            return new
        end

    end

end