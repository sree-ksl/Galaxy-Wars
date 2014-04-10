-- Stage size
WIDTH = 320
HEIGHT = 480

-- Object type IDs
TYPE_PLAYER = 1
TYPE_ENEMY = 2
TYPE_PLAYER_BULLET = 3
TYPE_ENEMY_BULLET = 4
TYPE_POWERUP = 5
POWERUP_HEALTH = 1
POWERUP_LIFE = 2

-- Toggle delete statuses
DO_NOT_REMOVE = 0
REMOVE_EXPLODE = 1
REMOVE_QUIET = 2

-- asteroidInfo
ASTEROID_NAME = "asteroid_"
-- ASTEROID_FRAME = 16
ASTEROID_VARIANCE = 3
CRATER_NAME = "crater_"
-- CRATER_FRAME = ASTEROID_FRAME + ASTEROID_VARIANCE
CRATER_VARIANCE = 4


-- Game variables
MAX_LIVES = 5
lives = MAX_LIVES

-- enemySpawn
ENEMY_DELAY = 30


-- playerSpeed
PLAYER_MAXSPEED = 10
PLAYER_SPEED_COEFF = 15



-- Parallax layer speeds
parallaxCoefficient1 = 2
parallaxCoefficient2 = 1



-- Player images
PLAYER_LEFT = "player_l"
PLAYER_CENTRE = "player"
PLAYER_RIGHT = "player_r"


-- Enemy images
-- Enemy images
ENEMY_1 = "enemy1"
ENEMY_2 = "enemy2"
ENEMY_3 = "enemy3"


-- Bullet variables
BULLET_RELOAD = 40
ENEMY_BULLET_RELOAD = 100

-- Bullet sprite
PLAYER_BULLET = "player_bullet"
ENEMY_BULLET = "enemy_bullet"


-- explosions
EXPLOSION = "explosion_01"



-- Power-up variables
POWERUP_SPEED = 4
POWERUPS = {
    HEALTH_POWERUP = "health_powerup",
    PLAYER_LIFE = "player_life"
}


-- soundEffectGlobals
SOUND_EFFECTS = {
    SOUND_EXPLOSION = "sounds/explosion.wav",
    SOUND_MISSILE = "sounds/missile.wav"
}


--muteSoundEffectsImageNames
FX_MUTE = {
    ACTIVE = "unmute",
    MUTED = "mute"
}


-- musicVolumeAnimationNames
FX_VOL = {
    "volume_0",
    "volume_1",
    "volume_2",
    "volume_3"
}


-- loadingMusicNames
MUSIC = {
    TUNE1 = "sounds/tune1.mp3",
    TUNE2 = "sounds/tune2.mp3"
}

