-- Globals provided by Plupdate.
--
-- This file can be used by toyboypy (https://toyboxpy.io) to import into a project's luacheck config.
--
-- Just add this to your project's .luacheckrc:
--    require "toyboxes/luacheck" (stds, files)
--
-- and then add 'toyboxes' to your std:
--    std = "lua54+playdate+toyboxes"

return {
    globals = {
        Plupdate = {
            fields = {
                CallbackInfo = {
                    fields = {
                        super = {
                            fields = {
                                className = {},
                                init = {}
                            }
                        },
                        className = {},
                        init = {},
                        call = {}
                    }
                },
                super = {
                    fields = {
                        className = {},
                        init = {}
                    }
                },
                className = {},
                init = {},
                checkForOtherPlaydateUpdate = {},
                iWillBeUsingTimers = {},
                iWillBeUsingFrameTimers = {},
                iWillBeUsingSprites = {},
                showCrankIndicator = {},
                onlyUpdateOneFrameEvery = {},
                updateEveryFrame = {},
                addCallback = {},
                addPostCallback = {},
                update = {},
            }
        }
    }
}
