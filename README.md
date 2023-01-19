# Dynamic Light
Adds handy meta object, methods and functions for working with dynamic light sources.

## Requires
- [PLib](https://github.com/Pika-Software/gmod_plib)

## Developer API
- ### `dlight` CreateDynamicLight() - Creates a new dynamic light object and returns it.

- ### [`number`](https://wiki.facepunch.com/gmod/number) game.GetDynamicLightCount() - Returns the number of valid dynamic light objects.

- ### `dlight` game.GetDynamicLight( [`number`](https://wiki.facepunch.com/gmod/number) index ) - Returns an existing light object based on a unique index.

- ### [GM](https://wiki.facepunch.com/gmod/GM_Hooks):DLightCreated( `dlight` light ) - This hook is called if a new dynamic light object has been created.

- ### [GM](https://wiki.facepunch.com/gmod/GM_Hooks):DLightRemoved( `dlight` light ) - This hook is called if the dynamic light object has been removed.

### DLight Object

- ### [`DynamicLight`](https://wiki.facepunch.com/gmod/Structures/DynamicLight) `dlight`:GetLight() - Returns a standard dynamic light object, which is [`userdata`](https://wiki.facepunch.com/gmod/light_userdata).

- ### [`boolean`](https://wiki.facepunch.com/gmod/boolean) `dlight`:IsValid() - Returns whether the light source is valid or not.

- ### [`number`](https://wiki.facepunch.com/gmod/number) `dlight`:LightIndex() - Returns a unique `dlight` index.

- ### `dlight`:Remove() - Removes the object of light source.

- ### [`vector`](https://wiki.facepunch.com/gmod/Vector) `dlight`:GetPos() - Returns the light source position in the world. (def. `0 0 0`)

- ### `dlight`:SetPos( [`vector`](https://wiki.facepunch.com/gmod/Vector) vec ) - Sets the position of light source in the world.

- ### [`color`](https://wiki.facepunch.com/gmod/Color) `dlight`:GetColor() - Returns color of light source. (def. `255 255 255 255`)

- ### `dlight`:SetColor( [`color`](https://wiki.facepunch.com/gmod/Color) col ) - Sets color of the light source.

- ### `dlight`:SetColorUnpacked( [`number`](https://wiki.facepunch.com/gmod/number) r, [`number`](https://wiki.facepunch.com/gmod/number) g, [`number`](https://wiki.facepunch.com/gmod/number) b, [`number`](https://wiki.facepunch.com/gmod/number) a ) - Sets the color of the light source by `r`, `g`, `b`, `a`.

- ### [`number`](https://wiki.facepunch.com/gmod/number) `dlight`:GetAlpha() - Returns alpha of the light source. (def. `255`)

- ### `dlight`:SetAlpha( [`number`](https://wiki.facepunch.com/gmod/number) a ) - Sets alpha of the light source.

- ### [`number`](https://wiki.facepunch.com/gmod/number) `dlight`:GetDieTime() - Returns time when the light source will die, the default is infinity. (def. `inf`)

- ### `dlight`:SetDeathTime( [`number`](https://wiki.facepunch.com/gmod/number) int ) - Sets time of death of the light source.

- ### [`number`](https://wiki.facepunch.com/gmod/number) `dlight`:GetLifeTime() - Returns the lifetime remaining of the light source. (def. `-inf`)

- ### `dlight`:SetLifeTime( [`number`](https://wiki.facepunch.com/gmod/number) int ) - Sets lifetime of the light source.

- ### [`number`](https://wiki.facepunch.com/gmod/number) `dlight`:GetBrightness() - Returns brightness of the light source. (def. `1`)

- ### `dlight`:SetBrightness( [`number`](https://wiki.facepunch.com/gmod/number) int ) - Sets brightness of the light source.

- ### [`number`](https://wiki.facepunch.com/gmod/number) `dlight`:GetSize() - Returns light source size. (def. `64`)

- ### `dlight`:SetSize( [`number`](https://wiki.facepunch.com/gmod/number) int ) - Sets light source size.

- ### [`number`](https://wiki.facepunch.com/gmod/number) `dlight`:GetStyle() - Returns light source style. (See [Appearances](https://developer.valvesoftware.com/wiki/Light_dynamic#Appearances))

- ### `dlight`:SetStyle( [`number`](https://wiki.facepunch.com/gmod/number) int ) - Sets light source style. (See [Appearances](https://developer.valvesoftware.com/wiki/Light_dynamic#Appearances))

- ### [`boolean`](https://wiki.facepunch.com/gmod/boolean) `dlight`:GetNoWorld() - Returns whether light should not illuminate the world. (def. `false`)

- ### `dlight`:SetNoWorld( [`boolean`](https://wiki.facepunch.com/gmod/boolean) bool ) - Sets a restriction on illumination of the light of the world.

- ### [`boolean`](https://wiki.facepunch.com/gmod/boolean) `dlight`:GetNoModel() - Returns whether light should not illuminate the models and entities. (def. `false`)

- ### `dlight`:SetNoModel( [`boolean`](https://wiki.facepunch.com/gmod/boolean) bool ) - Sets a restriction on light should not illuminate the models and entities.

- ### [`number`](https://wiki.facepunch.com/gmod/number) `dlight`:GetMinLight() - Returns the minimum light level. (def. `0`)

- ### `dlight`:SetMinLight( [`number`](https://wiki.facepunch.com/gmod/number) int ) - Sets the minimum light level.