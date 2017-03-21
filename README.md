# Autokarma


Voodoo(STEAM_0:1:28607710)
Adds a simple system in garrysmod to manage karma while an admin of allowed rank is currently on. 

# To install

Place in garrysMod\garrysmod\addons\autokarma\

# Notes: 

Comes with 3 cvars to change certain settings:

###### Cvars

"autokarma_enable" , default value is "1" (On) -- Enables/Disables the entire system

"autokarma_nokick" , default value is "1" (On) -- Enables/Disables the prevent karma kicking feature 

"autokarma_notify" , default value is "1" (On) -- Enables/Disables notifying of would-be kicks if "autokarma_nokick" is on

###### Other notes of interest

On first line of autokarma.lua, add groups retroactivtly to
...
local rankcheck = {'moderator','admin','superadmin','owner'}
...
to best suite your wishes. (Such as if the rank 'helper' should activate autokarma when a user of said rank is on.



