MAIN_CONFIG = {}


MAIN_CONFIG.weaponSwitchDelay = 3 -- Amount in seconds before the HUD displaying the player changing weapons fades away, (Default: 3, Disable: 0)

MAIN_CONFIG.shouldDefaultPM = false  -- Sets every person to same playermodel.
MAIN_CONFIG.defaultPlayerModel = "models/player/monk.mdl"  -- The default player model if MAIN_CONFIG.shouldDefaultPM is true
MAIN_CONFIG.playerModels = { -- List of player models to be randomly selected if MAIN_CONFIG.shouldDefaultPM is false
	[0] = "models/player/Group01/male_01.mdl",
	[1] = "models/player/Group01/male_02.mdl",
	[2] = "models/player/Group01/male_03.mdl",
	[3] = "models/player/Group01/male_04.mdl",
	[4] = "models/player/Group01/female_06.mdl",
	[5] = "models/player/Group01/female_04.mdl",
	[6] = "models/player/Group01/female_03.mdl"
}  
-- For a great list of default playermodels with pictues go here: https://csite.io/tools/gmod-universal-mdl

MAIN_CONFIG.nightTime = 120 -- Time for how long the Night period will last
MAIN_CONFIG.votingTime = 20 -- Time for how long the voting time during Judgement will last
MAIN_CONFIG.lastWordsTime = 1 -- Time for how long the player to be executed has to say their last words
MAIN_CONFIG.gameOverTime = 4 -- Time for how long until the game restarts

MAIN_CONFIG.deathlessNights = 100 -- Amount of days of no killing before the game goes to a stalemate

MAIN_CONFIG.minPlayerVotes = .5 -- Minimum amount of votes needed to elect someone to go up for execution, Default = .5
MAIN_CONFIG.minExecutionVotes = .75 -- Minimum amount of votes needed to execute the person, in percent Default = .75

MAIN_CONFIG.fistsDamage = false -- Whether the default fists do damage, Default = false

MAIN_CONFIG.friendlyKillMax = 1 -- Max amount of players a player can kill of his own team without being punished, Default: 1 Disable: -1

MAIN_CONFIG.maxVocalDistance = 500 -- Max distance a player can be away before not being able to hear another player

MAIN_CONFIG.DNARevealChances = {["name"] = .1, ["job"] = .3, ["faction"] = .5} -- Sets what the chances are of getting each piece of info from investigating dna 

MAIN_CONFIG.chat_leaderColor = Color(212,175,55) -- Color of the message sent to team for leaders