#  Copyright (c) 2018 Matthias Hollerbach (@kinglouie).
#
#  Released under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version. See <http://www.gnu.org/licenses/> for
#  details.

widgets = require './Widgets/index.coffee'

module.exports = class Theme

  top: 0
  right: 0
  bottom: null
  left: 0
  
  constructor: (cfg) ->
    @cfg = cfg
    @widgets = {}
    @themeName = @constructor.name

    # set/init active widgets
    for position, widget_list of cfg.widgets
      for widget in widget_list
        widgetName = if typeof widget is 'string' then widget else widget.name
        @widgets[widget] = new widgets[widgetName]()
        #if widget of cfg.widget_refresh_frequency
        #  activeWidgets[widget].refreshFrequency = cfg.widget_refresh_frequency[widget]

    @init()

    if "position" of @cfg
      if "top" of @cfg.position
        @top = @cfg.position.top
      if "left" of @cfg.position
        @left = @cfg.position.left
      if "bottom" of @cfg.position
        @bottom = @cfg.position.bottom
      if "right" of @cfg.position
        @right = @cfg.position.right

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
    if @top?
      $(domEl).css "top", @top
    if @bottom?
      $(domEl).css "bottom", @bottom
    if @left?
      $(domEl).css "left", @left
    if @right?
      $(domEl).css "right", @right

  update: (domEl) ->
    for widget_name, widget of @widgets
      if widget.needsUpdate
        widget.update(domEl)
