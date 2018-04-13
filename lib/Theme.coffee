#  Copyright (c) 2018 Matthias Hollerbach (@kinglouie).
#
#  Released under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version. See <http://www.gnu.org/licenses/> for
#  details.

module.exports = class Theme

  constructor: (cfg, widgets) ->
    @cfg = cfg
    @widgets = widgets
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

  render: ->
    html = ""
    for position, widgets_list of @cfg.widgets
      for widget in widgets_list
        html += @widgets[widget].render()
    return html

  afterRender: (domEl) ->

  update: ->
    for position, widgets_list of @cfg.widgets
      for widget in widgets_list
        if @widgets[widget].needsUpdate
          @widgets[widget].update()
