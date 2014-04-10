-- Require Corona classes
local storyboard = require( "storyboard" )

-- Require our code files
require( "globals" )
require( "unit" )
require( "bullet" )
require( "arrayfuncs" )
require( "staticsprites" )
-- Load the sprite data file
spritedata = require( "shipsprites" )
-- explosiondata = require( "explosionsprites" )
-- explosiondata = explosions:getSheet( )

-- Initialize physics
physics = require("physics")
physics.start()
physics.setGravity( 0, 0 )
physicsData = (require "shipphysics").physicsData(1)
-- physics.setDrawMode( "debug" )

-- Variables
-- soundEffectHandleVariables
local soundEffectHandles

-- muteSoundEffectsVariable
local soundEffectsVolume = true
local soundEffectsImages = {}


-- musicVolumeVariable
local gameVolume = 3
local soundVolumeImage = nil


-- musicHandleVariable
local musicHandles
local musicChannel


-- Variables
local scene = storyboard.newScene()
local sceneView
local enemies = {}
local lastEnemy = 0
local playerInstance, background
local parallax1, parallax2
local imagesheet
-- asteroidGroup
local asteroids
--bulletsVar
local bullets = {}
-- explosionsVariables
local explosionsheet
local explosions = {}

-- powerupVariables
local powerups = {}



-- loadParallaxLayer
-- Load a background image and add it to a parallax layer
function loadParallaxLayer( sceneGroup, imageName )
    -- Create a group
    local parallaxGroup = display.newGroup( )
    
    -- Load the background image twice and add them to the group
    local bgImage = display.newImage( imageName )
    parallaxGroup:insert( bgImage )
    bgImage.anchorX, bgImage.anchorY = 0, 0
    bgImage.y = 0
    
    bgImage = display.newImage( imageName )
    parallaxGroup:insert( bgImage )
    bgImage.anchorX, bgImage.anchorY = 0, 0
    bgImage.y = -bgImage.height
    
    -- Add the parallax group to the scene
    sceneGroup:insert( parallaxGroup )
    parallaxGroup.y = 0
    
    -- Return the group
    return parallaxGroup
end


-- makeAsteroid
-- Create an asteroid using our random images
function makeAsteroid( group )
    -- Create a group to store the asteroid
    local newGroup = display.newGroup()
    
    -- Choose a random image for the asteroid base and its crater
    local rockName = ASTEROID_NAME..math.random( ASTEROID_VARIANCE )
    local rock = display.newImage( imagesheet, spritedata:getFrameIndex(rockName) )
    local craterName = CRATER_NAME..math.random( CRATER_VARIANCE )
    local crater = display.newImage( imagesheet, spritedata:getFrameIndex(craterName) )
    
    -- Insert the images and set a random position for the group
    newGroup:insert( rock )
    newGroup:insert( crater )
    newGroup.x = 40 + math.random( 240 )
    newGroup.y = math.random( 480 )
    
    -- Set a random position for the crater
    rock.x = 0
    rock.y = 0
    crater.x = 10 + math.random( 40 )
    crater.y = 10 + math.random( 40 )
    
    -- Add everything to the asteroids layer
    group:insert( newGroup )
end



-- resetGameVars
-- Resets the game variables before a new game
function resetGameVars( )
    lives = MAX_LIVES
    enemies = {}
    bullets = {}
    lastEnemy = 0
    explosions = {}
    powerups = {}
end


-- muteGameFunction
function muteGame( event )
    if event.phase == "began" then
        -- Change the sound FX mute state
        soundEffectsVolume = not soundEffectsVolume
        -- Set visibilities
        if ( soundEffectsVolume == false ) then
            soundEffectsImages[1].isVisible = false
            soundEffectsImages[2].isVisible = true
        else
            soundEffectsImages[1].isVisible = true
            soundEffectsImages[2].isVisible = false
        end
        -- Stop all sounds if they're inactive
        if ( soundEffectsVolume == false ) then
            audio.stop( )
        else
            -- Choose another background tune
            chooseNextSong( )
        end
    end
end



--musicVolumeChangeFunction
function changeVolume( event )
    if event.phase == "began" then
        -- Increase volume or reset to 1
        gameVolume = gameVolume + 1
        if ( gameVolume == 4 ) then
            gameVolume = 0
        end
        
        -- Set visibilities
        soundVolumeImage:setSequence(FX_VOL[gameVolume + 1])
        audio.setVolume( (gameVolume + 1) / 4 )
    end
end



-- pickSongsWithoutRepeating

function chooseNextSong( )
    if ( soundEffectsVolume == true ) then
        -- END:chooseNextSongFunction
        -- Choose a song ID without repeating it
        local nextSong
        repeat

            nextSong = math.random( #musicHandles )

        until nextSong ~= currentSong

		
        -- Play the tune and store the ID for the next choice
        currentSong = nextSong
        musicChannel = audio.play( 
            musicHandles[nextSong], { onComplete = soundFinished } )


        audio.setVolume( (gameVolume + 1) / 4 , { channel=musicChannel } )

    end
end



-- soundFinishedFunction
function soundFinished( event )
    -- Rewind
    audio.rewind( musicChannel )
    -- Choose another song
    chooseNextSong()
end


-- chooseSongWithDelay
function soundFinished( event )
    -- Rewind
    audio.rewind( musicChannel )
    -- Choose another song
    local timeDelay = 5000 + math.random( 5000 )
    timer.performWithDelay( chooseNextSong, timeDelay )
end



-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view
    
    -- Reset game variables
    resetGameVars( )
    
    -- parallaxInit
    -- Create the parallax layers
    parallax2 = loadParallaxLayer( group, "images/parallaxbg.jpg" )
    parallax1 = loadParallaxLayer( group, "images/parallaxfg.png" )

    
    -- Set the scene group's starting y coordinate to 0
    group.y = 0
    group.yOrigin = 0
    
    -- loadSprites
    -- Create an image sheet
    imagesheet = graphics.newImageSheet( "images/shipsprites.png", spritedata:getSheet( ) )

    
    -- explosionSprites
    -- Load the explosion sprites and create a new sprite set
    local eximages = "images/explosionsprite.png"
    local explosionOptions = {
        width = 64,
        height = 64,
        numFrames = 16
    }
    explosionsheet = graphics.newImageSheet( eximages, explosionOptions )

    
    -- loadSprites
    -- Load the sprite animation data
    spriteSequences = require( "shipanims" )

    
    -- asteroids
    -- Create a group to hold the asteroids
    asteroids = display.newGroup()
    
    -- Create two asteroids and add them to the scene group
    for i = 1, 2 do
        makeAsteroid( asteroids )
    end
    group:insert( asteroids )

    
    -- loadSoundEffectHandles
    soundEffectHandles = {
        explosion = audio.loadSound( SOUND_EFFECTS.SOUND_EXPLOSION ),
        missile = audio.loadSound( SOUND_EFFECTS.SOUND_MISSILE )
    }

    
    -- addMuteButtonToStage
    -- Add an "active sounds" button
    local soundsprite = display.newSprite( imagesheet, spriteSequences.soundSequence )
    group:insert( soundsprite )
    soundsprite.x = 30
    soundsprite.y = 450
    soundsprite:setSequence( FX_MUTE.ACTIVE )
    soundEffectsImages[1] = soundsprite
    -- Add a "muted sounds" button
    soundsprite = display.newSprite( imagesheet, spriteSequences.soundSequence )
    group:insert( soundsprite )
    soundsprite.x = 30
    soundsprite.y = 450
    soundsprite:setSequence( FX_MUTE.MUTED )
    soundsprite.isVisible = false
    soundEffectsImages[2] = soundsprite
    soundEffectsImages[1]:addEventListener( "touch", muteGame )
    soundEffectsImages[2]:addEventListener( "touch", muteGame )

    
    -- musicVolumeDraw
	-- Draw the volume image
	soundsprite = display.newSprite( imagesheet, spriteSequences.musicSequence )
	group:insert( soundsprite )
	soundsprite.x = 80
	soundsprite.y = 450
	soundsprite:setSequence( FX_VOL[4] )
	soundVolumeImage = soundsprite

    
    -- musicVolumeChangeListener
	-- Add a listener to change music volume
    gameVolume = 3
    soundVolumeImage:addEventListener( "touch", changeVolume )

    
    -- musicLoadFunction
    musicHandles = {
        audio.loadStream( MUSIC.TUNE1 ),
        audio.loadStream( MUSIC.TUNE2 )
    }

    
    -- newSoundChannelWithListener
    musicChannel = audio.play( musicHandles[1], { 
        channel=1, loops=1, onComplete = soundFinished 
    } )

    audio.setVolume( (gameVolume + 1) / 4 , { channel=musicChannel } )
    

    -- Initialize the player
    playerInstance = Player( group, imagesheet )

end


-- onPlayerTouch
-- Handles the game's touch event listener and updates the player's position accordingly
local function onPlayerTouch( event )
    if event.phase ~= "ended" then
        -- If the player keeps pressing the screen, save the touch location as the target position
        playerInstance:setTargetPosition( event.x, event.y )
    else
        -- When the touch event ends, stop moving the player
        playerInstance:resetTargetPosition( )
    end
end



-- Updates the parallax each frame
local function updateParallax( )
    -- Move in the y direction (using the coefficient in globals.lua)
    parallax2.y = parallax2.y + parallaxCoefficient2
    parallax1.y = parallax1.y + parallaxCoefficient1
    
    -- Reset the layers' positions if they scroll out of the scene
    if parallax2.y >= parallax2[1].height then
        parallax2.y = parallax2.y - parallax2[1].height
    end
    if parallax1.y >= parallax1[1].height then
        parallax1.y = parallax1.y - parallax1[1].height
    end
end




-- Update the enemies
local function updateEnemies( group )
    -- Loop through all the enemies (backwards in case we remove some from the table)
    for i = #enemies, 1, -1 do
        -- Move the enemy
        enemies[ i ]:move( )
        
        -- enemiesShoot
        -- Make the enemy shoot
        if ( enemies[ i ]:canShoot( ) == true ) then

            -- playEnemyMissileSoundIfActive
            if soundEffectsVolume == true then
                -- playEnemyMissileSound
                local chan = audio.play( soundEffectHandles.missile )

                audio.setVolume( 0.1 * (gameVolume + 1) / 4 , { channel=chan } )
            end

            -- enemiesShoot
            bullets[ #bullets + 1 ] = Bullet( physics, group, imagesheet, enemies[ i ] )
        end

        

        -- Delete inactive enemies
        if ( enemies[ i ]:toggleDelete( ) == true ) then
            -- Add power-ups
            if math.random() < 0.2 then
                powerups[ #powerups + 1 ] = Powerup( group, imagesheet, spriteSequences.powerupSequence, enemies[i].x, enemies[i].y, physics )
            end
            
            -- Add an explosion
            explosions[ #explosions + 1 ] = Explosion( group, explosionsheet, spriteSequences.explosionSequence, enemies[i].x, enemies[i].y )


            if soundEffectsVolume == true then
                -- playExplosionSound
                local chan = audio.play( soundEffectHandles.explosion )

                audio.setVolume( 0.5 * (gameVolume + 1) / 4 , { channel=chan } )
            end


            
            -- Remove the enemy
            enemies[ i ]:removeMe( )
            removeTableRows( enemies, i, 1 )
        end

    end
end


-- addEnemies
-- Adds an enemy if we've waited enough time
local function addEnemies( group )
    lastEnemy = lastEnemy - 1
    if ( lastEnemy <= 0 ) then
        -- Add the enemy
        lastEnemy = math.random( ENEMY_DELAY ) + ENEMY_DELAY
        enemies[ #enemies + 1 ] = Enemy( group, imagesheet )
    end
end



-- Updates all bullets in the game
function updateBullets( group )
    -- Loop through all bullets (backwards in case we remove some)
    for i = #bullets, 1, -1 do
        -- Move the bullet
        bullets[ i ]:move( )
        
        -- Remove inactive bullets
        if ( bullets[ i ]:toggleDelete( ) == true ) then

            if (bullets[i].oob ~= true) then

                -- Add an explosion
                local newEx
                newEx = Explosion( group, explosionsheet, spriteSequences.explosionSequence, 
                    bullets[i].x, bullets[i].y )
                newEx:scale( 0.5 )
                explosions[ #explosions + 1 ] = newEx


                if soundEffectsVolume == true then
                    playBulletExplosionSound
                    local chan = audio.play( soundEffectHandles.explosion )

                    audio.setVolume( 0.5 * (gameVolume + 1) / 4 , { channel=chan } )
                end

            end
            -- updateBullets
            bullets[ i ]:removeMe( )
            removeTableRows( bullets, i, 1 )
        end
    end
end




-- Updates the explosion animations and removes inactive explosions
function updateExplosions( )
    -- Loop through all the explosions
    for i = #explosions, 1, -1 do
        -- Remove explosions that have completed the animation
        if explosions[ i ]:toggleDelete( ) then
            explosions[ i ]:removeMe( )
            removeTableRows( explosions, i, 1 )
        end
    end
end



-- Updates the game's power-ups
function updatePowerups( )
    -- Loop through the power-ups
    for i = #powerups, 1, -1 do
        -- Move the power-up
        powerups[ i ]:move( )
        
        -- Delete unused power-ups
        if powerups[ i ]:toggleDelete( ) then
            powerups[ i ]:removeMe( )
            removeTableRows( powerups, i, 1 ) 
        end
    end
end



-- Updates the asteroids' positions
function updateAsteroids( )
    for i = asteroids.numChildren, 1, -1 do
        -- Move the asteroid
        asteroids[ i ].y = asteroids[ i ].y + parallaxCoefficient1
        
        -- Move asteroids back to the top of the screen after they move out of bounds
        if asteroids[ i ].y > 530 then
            asteroids[ i ].y = -50 - math.random( 50 )
            asteroids[ i ].x = 40 + math.random( 240 )
        end
    end
end



-- The game's main update function
local function tick( event )
    local group = sceneView
    
    -- tickUpdateParallax
    -- Update the parallax layers
    updateParallax( )

    
    -- playerAndEnemyMovement
    -- Update the player
    playerInstance:move( )
    -- playerShoot
    -- If the player can shoot, add a new bullet
    if ( playerInstance:canShoot( ) ) then

        -- playMissileSoundIfActive
        if soundEffectsVolume == true then
            -- playMissileSound
            local chan = audio.play( soundEffectHandles.missile )

            audio.setVolume( 0.1 * (gameVolume + 1) / 4 , { channel=chan } )
        end

        -- playerShoot
        local newBullet = Bullet( physics, group, imagesheet, playerInstance )
        bullets[ #bullets + 1 ] = newBullet
    end

    
    -- Update enemies
    updateEnemies( group )

    
    -- bulletMovement
    -- Update the bullets
    updateBullets( group )



    -- Update the explosions
    updateExplosions( )

    

    -- Update the power-ups
    updatePowerups( )

    
    -- Add enemies
    addEnemies( group )
    

    -- Update the asteroids
    updateAsteroids( )

    

    -- Check whether we have some lives left, and return to the menu if we don't
    if lives <= 0 then
        soundEffectsVolume = false
        audio.stop( )
        storyboard.gotoScene( "menu" )
    end

end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    -- Destroy the menu screen
    storyboard.purgeScene( "menu" )
    
    local group = self.view
    sceneView = group
    
    --enterSceneGroupCoords
    group.yReference = 0
    group.y = 0

    
    group:addEventListener( "touch", onPlayerTouch )
    Runtime:addEventListener( "enterFrame", tick )
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local group = self.view
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
    local group = self.view
    
    -- deleteUnusedSounds
    for i = 1, #soundEffectHandles do
        audio.dispose( soundEffectHandles[i] )
    end


    -- Remove event listeners
    group:removeEventListener( "touch", onPlayerTouch )
    Runtime:removeEventListener( "enterFrame", tick )
    
    -- Remove units, bullets, power-ups, and explosions
    
    -- Remove the player's ship
    playerInstance:removeMe( )
    
    -- Remove bullets
    for i = #bullets, 1, -1 do
        bullets[ i ]:removeMe( )
    end

    -- Remove explosions
    for i = #explosions, 1, -1 do
        explosions[ i ]:removeMe( )
    end
    
    -- Remove power-ups
    for i = #powerups, 1, -1 do
        powerups[ i ]:removeMe( )
    end
    
    -- Remove asteroids
    for i = asteroids.numChildren, 1, -1 do
        local asteroid = asteroids[ i ]
        for j = asteroid.numChildren , 1, -1 do
            asteroid[ j ]:removeSelf( )
        end
        asteroid:removeSelf( )
    end
    
end


-- Add the scene's event listeners
scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

-- Return the scene
return scene