require "class"
require "globals"

-- bulletConstructor
Bullet = Class( )

function Bullet:new( physics, group, spriteSet, unit )
    -- Create a new sprite, hide it out of bounds, and add it to the group
    local spriteInstance = display.newSprite( spriteSet, spriteSequences.bulletSequence )
    spriteInstance.x = -50
    spriteInstance.y = -50
    group:insert( spriteInstance )
    self.spriteInstance = spriteInstance
    
    -- Mark the bullet as alive
    self.alive = true
    
    -- Prepare the bullet sprite
    self.spriteInstance.object = self
    local body, ydisplacement
    -- START:bulletPhysics
    if unit.type == TYPE_PLAYER then
    -- bulletPhysics
        -- Set starting speed and y difference from the shooting ship
        self.vy = -4
        ydisplacement = -10
        -- Assign the player bullet sprite
        self.type = TYPE_PLAYER_BULLET
        self.spriteInstance:setSequence( PLAYER_BULLET )
        -- bulletConstructor
        -- bulletPhysics
        body = physicsData:get( PLAYER_BULLET )
        
    else
    
        -- Set starting speed and y difference from the shooting ship
        self.vy = 6 + parallaxCoefficient1
        ydisplacement = 10
        -- Set the enemy image
        self.type = TYPE_ENEMY_BULLET
        self.spriteInstance:setSequence( ENEMY_BULLET )
        body = physicsData:get( ENEMY_BULLET )
        
    end
    
    physics.addBody( self.spriteInstance, body )    

    -- Set the starting coordinates
    spriteInstance.y = unit.y + ydisplacement
    spriteInstance.x = unit.x
    self.x = spriteInstance.x
    self.y = spriteInstance.y
end

-- bulletFunctions
-- Move the unit in the y direction
function Bullet:move( )
    -- Update the y coordinate
    self.y = self.y + self.vy
    
    -- Reset coordinates
    self.spriteInstance.rotation = 0
    self.spriteInstance.y = self.y
    self.spriteInstance.x = self.x
end

-- Check whether the unit is out of bounds
function Bullet:toggleDelete( )
    -- The bullet has to be removed if it's dead or out of bounds
    if ( self.alive == false) then
        return true
    elseif (( self.y < -20 ) or ( self.y > 500 )) then
        self.oob = true
        return true
    end
    
    return false
end

-- Remove the bullet from the stage
function Bullet:removeMe( )
    self.spriteInstance:removeSelf( )
    self.spriteInstance = nil
end
