spriteSequences = {}

spriteSequences.shipsSequence = {
    { 
        name = PLAYER_CENTRE,
        start = spritedata:getFrameIndex( PLAYER_CENTRE ),
        count = 1
    },
    { 
        name = PLAYER_LEFT,
        start = spritedata:getFrameIndex( PLAYER_LEFT ),
        count = 1
    },
    { 
        name = PLAYER_RIGHT,
        start = spritedata:getFrameIndex( PLAYER_RIGHT ),
        count = 1
    },
    { 
        name = ENEMY_1,
        start = spritedata:getFrameIndex( ENEMY_1 ),
        count = 1
    },
    { 
        name = ENEMY_2,
        start = spritedata:getFrameIndex( ENEMY_2 ),
        count = 1
    },
    { 
        name = ENEMY_3,
        start = spritedata:getFrameIndex( ENEMY_3 ),
        count = 1
    }
}

spriteSequences.bulletSequence = {
    { 
        name = PLAYER_BULLET,
        start = spritedata:getFrameIndex( PLAYER_BULLET ),
        count = 1
    },
    { 
        name = ENEMY_BULLET,
        start = spritedata:getFrameIndex( ENEMY_BULLET ),
        count = 1
    },
}

spriteSequences.explosionSequence = {
    name = EXPLOSION,
    start = 1,
    count = 16,
    loopCount = 1
}

spriteSequences.powerupSequence = {
    {
        name = POWERUPS.HEALTH_POWERUP,
        start = spritedata:getFrameIndex( POWERUPS.HEALTH_POWERUP ),
        count = 1
    },
    {
        name = POWERUPS.PLAYER_LIFE,
        start = spritedata:getFrameIndex( POWERUPS.PLAYER_LIFE ),
        count = 1
    }
}

-- START:musicSequence
spriteSequences.soundSequence = {
    {
        name = FX_MUTE.MUTED,
        start = spritedata:getFrameIndex( FX_MUTE.MUTED ),
        count = 1,
        loopCount = 1
    },
    {
        name = FX_MUTE.ACTIVE,
        start = spritedata:getFrameIndex( FX_MUTE.ACTIVE ),
        count = 1,
        loopCount = 1
    }
}
-- END:musicSequence

-- START:musicSequence
spriteSequences.musicSequence = {
    {
        name = FX_VOL[1],
        start = spritedata:getFrameIndex( FX_VOL[1] ),
        count = 1,
        loopCount = 1
    },
-- END:musicSequence
    {
        name = FX_VOL[2],
        start = spritedata:getFrameIndex( FX_VOL[2] ),
        count = 1,
        loopCount = 1
    },
    {
        name = FX_VOL[3],
        start = spritedata:getFrameIndex( FX_VOL[3] ),
        count = 1,
        loopCount = 1
    },
    {
        name = FX_VOL[4],
        start = spritedata:getFrameIndex( FX_VOL[4] ),
        count = 1,
        loopCount = 1
    }
-- START:musicSequence
}
-- END:musicSequence

return spriteSequences