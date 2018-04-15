#  Copyright (c) 2018 Matthias Hollerbach (@kinglouie).
#
#  Released under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version. See <http://www.gnu.org/licenses/> for
#  details.

Widget = require '../../Widget.coffee'
run = require 'run'

module.exports = class Spaces extends Widget

  refreshFrequency: 500

  command: "apebar/lib/Widgets/Spaces/bin/DisplaySpaces"

  init: ->
    @displays = {}

  afterRun: ->
    @displays = @output.split("\n").reduce (obj, str, index) ->
      parts = str.split(":")
      if parts[0] && parts[1] && parts[2]
        obj[parts[0].trim()] = { spaces: parts[1].trim().split(" "), currentSpace: parts[2].trim() }
      obj
    , {}

  render: ->
    """
      <div class="widget-#{@name}"></div>
    """

  update: (domEl) ->
    display_id = window.location.href.split("/").pop()
    output = ""
    if @displays[display_id]?
      for space in @displays[display_id].spaces
        classes = ["space-" + space]
        if space == @displays[display_id].currentSpace
          classes.push "current"
        output += "<span class=\"#{classes.join " "}\">#{space}</span>"  

    $(domEl).find(".widget-#{@name}").html output