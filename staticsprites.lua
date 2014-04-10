require "class"
require "globals"
require "auxiliary"

-- objectConstructor
GameObject = Class( )

-- GameObject constructor
function GameObject:new( group, spriteSet, spriteSequence, px, py )
    -- Create a new sprite and add it to the group
    local spriteInstance = display.newSprite( spriteSet, spriteSequence )
    spriteInstance.x = -50
    spriteInstance.y = -50
    group:insert( spriteInstance )
    
    -- Store the sprite instance and the "self" object
    self.spriteInstance = spriteInstance
    self.spriteInstance.object = self
end


-- Resizes the sprite
function GameObject:scale( factor )
    self.spriteInstance:scale( factor, factor )
end

-- objectFunctions
-- Check whether the object needs to be deleted
function GameObject:toggleDelete( )
    return false
end

-- Remove the unit
function GameObject:removeMe( )
    self.spriteInstance:removeSelf( )
    self.spriteInstance = nil
end


-- explosionConstructor
Explosion = Class( GameObject )

-- Explosion constructor
function Explosion:new( group, spriteSet, spriteSequence, px, py )
    -- Prepare the explosion sprite
    self.spriteInstance:setSequence( EXPLOSION )
    self.spriteInstance:play()
    
    -- Set the sprite's coordinates
    self.spriteInstance.x = px
    self.spriteInstance.y = py
end


-- explosionFunctions
-- Check whether the explosion has to be deleted
function Explosion:toggleDelete( )
    -- Delete the sprite if it reaches the final frame
    if ( self.spriteInstance.frame == 16 ) then
        return true
    end
    
    return false
end


-- powerupConstructor
-- Power-up
Powerup = Class( GameObject )

-- Power-up constructor
function Powerup:new( group, spriteSet, spriteSequence, px, py, physics )
    -- Prepare the explosion sprite
    local powerType = math.random( 2 )
    local sInstance = self.spriteInstance
    local body
    
    -- Set the image and physics body depending on the power-up type
    if( powerType == 1 ) then
        self.spriteInstance:setSequence( POWERUPS.HEALTH_POWERUP )
        body = physicsData:get( POWERUPS.HEALTH_POWERUP )
    else
        self.spriteInstance:setSequence( POWERUPS.PLAYER_LIFE )
        body = physicsData:get( POWERUPS.PLAYER_LIFE )
    end
    -- Add the body, store the power-up type, and display the image
    physics.addBody( sInstance, body )
    self.type = TYPE_POWERUP
    self.subtype = powerType
    
    -- Set the power-up's starting parameters
    self.alive = true
    self.x = px
    self.y = py
    self.spriteInstance.x = px
    self.spriteInstance.y = py
end


-- powerupFunctions
-- Move the power-up
function Powerup:move( )
    self.y = self.y + POWERUP_SPEED
    self.spriteInstance.x = self.x
    self.spriteInstance.y = self.y
end

-- Check whether the power-up needs to be deleted
function Powerup:toggleDelete( )
    if self.y > 500 or self.alive == false then
        return true
    end
    
    return false
end

