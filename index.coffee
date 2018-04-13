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
activeWidgets = {}

refreshFrequency: 500



init: ->
  if !@initialized
    # load configuration
    cfg = apebar.getJson "./apebar/config.json"

    # match theme configuration
    matchedThemeConfiguration = apebar.matchTheme cfg.themes
    themeName = cfg.themes[matchedThemeConfiguration].name
    themeCfg = cfg.themes[matchedThemeConfiguration].config

    # set/init active widgets
    for position, widget_list of themeCfg.widgets
      for widget in widget_list
        activeWidgets[widget] = new widgets[widget]()
        if widget of cfg.widget_refresh_frequency
          activeWidgets[widget].refreshFrequency = cfg.widget_refresh_frequency[widget]

    # set/init theme
    if themeName of themes
      theme = new themes[themeName](themeCfg, activeWidgets)

    @initialized = true

command: (callback) ->
  @init()
  for widget_name, widget of activeWidgets
    if Date.now() >= widget.lastRun + widget.refreshFrequency
      widget.run()

  callback()

render: ->
  theme.render()

afterRender: (domEl) ->
  theme.afterRender(domEl)

update: (output, domEl) ->
  theme.update()
