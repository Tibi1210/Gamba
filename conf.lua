_G.love = require("love")
Shader = require("shader_handler")
Deck = require("Entities.Deck")
Case = require("Entities.Case")
Support_functions = require("background")
UI_btn = require("UI_btn")

Card_game = require("Games.cards")
Case_game = require("Games.caseopening")

MainMenu = require("Games.MainMenu")


math.randomseed(os.time())

SW = 1200
SH = 675

CardSize = {110,150}

function love.conf(t)
    t.window.title = "Gamba"
    t.window.height = SH
    t.window.width = SW
    t.window.resizable = false
    t.console = false
    t.window.borderless = false
    t.window.fullscreen = false
    t.window.fullscreentype = "desktop"
    t.window.vsync = 0
    t.window.msaa = 0
end
