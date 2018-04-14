#  Copyright (c) 2018 Matthias Hollerbach (@kinglouie).
#
#  Released under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version. See <http://www.gnu.org/licenses/> for
#  details.

widgets = require './Widgets/index.coffee'

module.exports = class Theme

  constructor: (cfg) ->
    @cfg = cfg
    @widgets = {}

    # set/init active widgets
    for position, widget_list of cfg.widgets
      for widget in widget_list
        widgetName = if typeof widget is 'string' then widget else widget.name
        @widgets[widget] = new widgets[widgetName]()
        #if widget of cfg.widget_refresh_frequency
        #  activeWidgets[widget].refreshFrequency = cfg.widget_refresh_frequency[widget]

    @init()
    if @cfg.top?
      @top = @cfg.top
    if @cfg.left?
      @left = @cfg.left
    if @cfg.bottom?
      @bottom = @cfg.bottom
    if @cfg.right?
      @right = @cfg.right

  init: ->

  run: ->
    for widget_name, widget of @widgets
      frequency = if widget.refreshFrequency? then widget.refreshFrequency else widget::refreshFrequency
      if Date.now() >= widget.lastRun + frequency
        widget.run()

  render: ->
    html = ""
    for widget_name, widget of @widgets
        html += widget.render()
    return html

  afterRender: (domEl) ->

  update: ->
    for widget_name, widget of @widgets
      if widget.needsUpdate
        widget.update()
