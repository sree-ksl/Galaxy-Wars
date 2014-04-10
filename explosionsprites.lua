-- local sheetInfo = require("myExportedImageSheet") -- lua file that Texture packer published
--
-- local myImageSheet = graphics.newImageSheet( "ImageSheet.png", sheetInfo:getSheet() ) -- ImageSheet.png is the image Texture packer published
--
-- local myImage1 = display.newImage( myImageSheet , sheetInfo:getFrameIndex("image_name1"))
-- local myImage2 = display.newImage( myImageSheet , sheetInfo:getFrameIndex("image_name2"))
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- explosion_01
            x=212,
            y=240,
            width=36,
            height=34,

            sourceX = 18,
            sourceY = 18,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_02
            x=170,
            y=240,
            width=40,
            height=38,

            sourceX = 16,
            sourceY = 16,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_03
            x=58,
            y=248,
            width=50,
            height=42,

            sourceX = 10,
            sourceY = 14,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_04
            x=118,
            y=210,
            width=50,
            height=46,

            sourceX = 10,
            sourceY = 12,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_05
            x=60,
            y=202,
            width=56,
            height=44,

            sourceX = 6,
            sourceY = 12,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_06
            x=126,
            y=54,
            width=58,
            height=50,

            sourceX = 4,
            sourceY = 10,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_07
            x=120,
            y=158,
            width=56,
            height=50,

            sourceX = 6,
            sourceY = 10,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_08
            x=2,
            y=106,
            width=58,
            height=46,

            sourceX = 6,
            sourceY = 12,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_09
            x=182,
            y=108,
            width=56,
            height=50,

            sourceX = 6,
            sourceY = 10,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_10
            x=2,
            y=54,
            width=60,
            height=50,

            sourceX = 4,
            sourceY = 10,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_11
            x=186,
            y=54,
            width=56,
            height=52,

            sourceX = 6,
            sourceY = 10,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_12
            x=2,
            y=154,
            width=56,
            height=50,

            sourceX = 6,
            sourceY = 10,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_13
            x=190,
            y=2,
            width=60,
            height=50,

            sourceX = 4,
            sourceY = 10,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_14
            x=2,
            y=2,
            width=62,
            height=50,

            sourceX = 4,
            sourceY = 10,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_15
            x=62,
            y=150,
            width=56,
            height=50,

            sourceX = 6,
            sourceY = 10,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_16
            x=64,
            y=102,
            width=58,
            height=46,

            sourceX = 6,
            sourceY = 12,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_17
            x=128,
            y=2,
            width=60,
            height=50,

            sourceX = 6,
            sourceY = 10,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_18
            x=124,
            y=106,
            width=56,
            height=50,

            sourceX = 6,
            sourceY = 10,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_19
            x=66,
            y=2,
            width=60,
            height=50,

            sourceX = 4,
            sourceY = 10,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_20
            x=64,
            y=54,
            width=60,
            height=46,

            sourceX = 4,
            sourceY = 12,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_21
            x=2,
            y=206,
            width=54,
            height=44,

            sourceX = 10,
            sourceY = 12,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_22
            x=178,
            y=160,
            width=52,
            height=42,

            sourceX = 10,
            sourceY = 14,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_23
            x=178,
            y=204,
            width=52,
            height=34,

            sourceX = 10,
            sourceY = 16,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_24
            x=2,
            y=252,
            width=48,
            height=38,

            sourceX = 10,
            sourceY = 16,
            sourceWidth = 70,
            sourceHeight = 70
        },
        {
            -- explosion_25
            x=232,
            y=160,
            width=18,
            height=18,

            sourceX = 26,
            sourceY = 26,
            sourceWidth = 70,
            sourceHeight = 70
        },
    },
    
    sheetContentWidth = 256,
    sheetContentHeight = 512
}

SheetInfo.frameIndex =
{

    ["explosion_01"] = 1,
    ["explosion_02"] = 2,
    ["explosion_03"] = 3,
    ["explosion_04"] = 4,
    ["explosion_05"] = 5,
    ["explosion_06"] = 6,
    ["explosion_07"] = 7,
    ["explosion_08"] = 8,
    ["explosion_09"] = 9,
    ["explosion_10"] = 10,
    ["explosion_11"] = 11,
    ["explosion_12"] = 12,
    ["explosion_13"] = 13,
    ["explosion_14"] = 14,
    ["explosion_15"] = 15,
    ["explosion_16"] = 16,
    ["explosion_17"] = 17,
    ["explosion_18"] = 18,
    ["explosion_19"] = 19,
    ["explosion_20"] = 20,
    ["explosion_21"] = 21,
    ["explosion_22"] = 22,
    ["explosion_23"] = 23,
    ["explosion_24"] = 24,
    ["explosion_25"] = 25,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
