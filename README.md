# Plupdate for Playdate

[![MIT License](https://img.shields.io/github/license/DidierMalenfant/Plupdate)](https://spdx.org/licenses/MIT.html) [![Lua Version](https://img.shields.io/badge/Lua-5.4-yellowgreen)](https://lua.org) [![Toybox Compatible](https://img.shields.io/badge/toybox.py-compatible-brightgreen)](https://toyboxpy.io) [![Latest Version](https://img.shields.io/github/v/tag/DidierMalenfant/Plupdate)](https://github.com/DidierMalenfant/Plupdate/tags)

**Plupdate** is a [**Playdate**](https://play.date) **toybox** which helps manage the `playdate.update()` callback method.

You can add it to your **Playdate** project by installing [**toybox.py**](https://toyboxpy.io), going to your project folder in a Terminal window and typing:

```console
toybox add DidierMalenfant/Plupdate
toybox update
```

Then, if your code is in the `source` folder, just import the following:

```lua
import '../toyboxes/toyboxes.lua'
```

This **toybox** contains **Lua** toys for you to play with.

## Changes in your code

When using **Plupdate** or if you are using a library which uses **Plupdate**, make sure to replace your own `playdate.update()` by a call to `Plupdate.addCallback` during initialisation, like this:

```lua
function MyInit()
    ...

    Plupdate.addCallback(function()
        -- Place your update() code here instead
        ...
    end)
end
```

Finally, if your `update()`` code was originally calling the following methods, replace them by the following ones, also in your app's initialisation:

```Lua
function MyInit()
    ...
    
    -- If you used to call playdate.timer.updateTimers()
    Plupdate.iWillBeUsingTimers()
    
    -- If you used to call playdate.frameTimer.updateTimers()
    Plupdate.iWillBeUsingFrameTimers()
    
    -- If you used to call playdate.graphics.sprite.update()
    Plupdate.iWillBeUsingSprites()
    
    ...
end
```

## Why do we need this?

Up to now, the main application had to implement `playdate.update()` and had to made sure that this method called all the update methods required by any dependencies. **Plupdate** handles this for you and also handles enabling updates for various SDK sub-systems like sprites or timers.

If you are using a library that means you don't have to worry about adding things to `playdate.update()` yourself. If you are writing a library that means you can make sure that the things you need are in `playdate.update()` without requiring anything from your end-user.

Best of all, **Plupdate** calls can me made from anywhere in your code, inside or outside of update loops and callbacks, with no consequences. They can even be called multiple times without causing updates to happend multiple times.

It just works™.

## Usage

##### `Plupdate.iWillBeUsingTimers()`

Tell **Plupdate** that you require `playdate.timer.update_timers()` to be called during the update loop.

##### `Plupdate.iWillBeUsingFrameTimers()`

Tell **Plupdate** that you require `playdate.frameTimer.update_timers()` to be called during the update loop.

##### `Plupdate.iWillBeUsingSprites()`

Tell **Plupdate** that you require `playdate.graphics.sprite.update()` to be called during the update loop.

##### `Plupdate.showCrankIndicator()`

Displays the crank indicator as long as this is called every frame. This can be called from anywhere in your code, even a sprite `update()` method.

##### `Plupdate.onlyUpdateOneFrameEvery(number_of_ticks)`

Allow calls to `playdate.update()` to only occur every so many frames. A value of 5 for `number_of_ticks`, for example, only calls update() every 5 frames which in effect runs the entire project in slow motion. Very useful for debugging things like animations.

##### `Plupdate.updateEveryFrame()`

Switches calls `playdate.update()` back to every frame.

##### `Plupdate.addCallback(callback, arg1, arg2)`

Add a callback to the update loop. These will be executed **before** any of the system updates, sprites and timers for example, and in the order in which they are added.

In order to add an instance method as a callback, just pass `self` as the first argument:

```lua
Plupdate.addCallback(ClassName.method, self)
```

##### `Plupdate.addPostCallback(callback, arg1, arg2)`

Add a callback to the update loop. These will be executed **after** any of the system updates, sprites and timers for example, and in the reverse order in which they are added.

In order to add an instance method as a callback, just pass `self` as the first argument:

```lua
Plupdate.addPostCallback(ClassName.method, self)
```

## License

**Plupdate** is distributed under the terms of the [MIT](https://spdx.org/licenses/MIT.html) license.
