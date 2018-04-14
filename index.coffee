#  Copyright (c) 2018 Matthias Hollerbach (@kinglouie).
#
#  Released under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version. See <http://www.gnu.org/licenses/> for
#  details.

apebar = require './lib/Apebar.coffee'
widgets = require './lib/Widgets/index.coffee'
themes = require './lib/Themes/index.coffee'

cfg = null
theme = null

refreshFrequency: 500

init: ->
  if !@initialized
    # load configuration
    cfg = apebar.getJson "./apebar/config.json"

    # match theme configuration
    matchedThemeConfiguration = apebar.matchTheme cfg
    themeName = cfg[matchedThemeConfiguration].name
    themeCfg = cfg[matchedThemeConfiguration]

    # set/init theme
    if themeName of themes
      theme = new themes[themeName](themeCfg)

    @initialized = true

command: (callback) ->
  @init()
  theme.run()
  callback()

render: ->
  theme.render()

afterRender: (domEl) ->
  theme.afterRender(domEl)

update: (output, domEl) ->
  theme.update()
