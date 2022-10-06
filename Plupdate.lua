-- SPDX-FileCopyrightText: 2022-present Didier Malenfant <coding@malenfant.net>
--
-- SPDX-License-Identifier: MIT

import "CoreLibs/graphics"
import "CoreLibs/timer"
import "CoreLibs/frameTimer"
import "CoreLibs/object"

class('Plupdate', { }).extends()
class('CallbackInfo', { method = nil, arg1 = nil, arg2 = nil }, Plupdate).extends()

function Plupdate.CallbackInfo:init(callback, arg1, arg2)
	self.callback = callback
	self.arg1 = arg1
	self.arg2 = arg2
end

function Plupdate.CallbackInfo:call()
	self.callback(self.arg1, self.arg2)
end

local update_timers = false
local update_frame_timers = false
local update_sprites = false
local update_callbacks = { }
local post_update_callbacks = { }

function Plupdate.iWillBeUsingTimers()
	update_timers = true
end

function Plupdate.iWillBeUsingFrameTimers()
	update_frame_timers = true
end

function Plupdate.iWillBeUsingSprites()
	update_sprites = true
end

function Plupdate.addCallback(callback, arg1, arg2)
	-- Pre-update callbacks will be executed starting with the first one in
	table.insert(update_callbacks, Plupdate.CallbackInfo(callback, arg1, arg2))
end

function Plupdate.addPostCallback(callback, arg1, arg2)
	-- Post-update callbacks will be executed starting with the last one in
	table.insert(post_update_callbacks, 1, Plupdate.CallbackInfo(callback, arg1, arg2))
end

function playdate.update()
	for _, callback in ipairs(update_callbacks) do
		callback:call()
	end

	-- Update all the playdate SDK sub-systems.
	if update_sprites then
		playdate.graphics.sprite.update()
	end
	
	if update_timers then
		playdate.timer.update_timers()
	end
	
	if update_frame_timers then
		playdate.frameTimer.update_timers()
	end
	
	for _, callback in ipairs(post_update_callbacks) do
		callback:call()
	end
end
