#  Copyright (c) 2018 Matthias Hollerbach (@kinglouie).
#
#  Released under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version. See <http://www.gnu.org/licenses/> for
#  details.

Widget = require '../../Widget.coffee'

module.exports = class Bandwidth extends Widget

  refreshFrequency: 2500

  commands =
    down: "/usr/local/bin/ifstat -n -z -i en0 -S 1 1 | awk 'FNR == 3 {print $2}'"
    up:  "/usr/local/bin/ifstat -n -z -i en0 -S 1 1 | awk 'FNR == 3 {print $3}'"

  command: "echo " +
           "$(#{ commands.down }):::" +
           "$(#{ commands.up })"

  init: ->
    @value =
      down: ""
      up: ""

  afterRun: ->
    output = @output.split( /:::/g )

    down = parseFloat(output[0])
    up = parseFloat(output[1])
    
    sizeDown = " KB"
    sizeUp = " KB"
    digitsDown = 2
    digitsUp = 2

    if down > 1024
      sizeDown = " MB"
      down /= 1024
    if up > 1024
      sizeUp = " MB"
      up /= 1024

    if down >= 10
      digitsDown = 1
    if up >= 10
      digitsUp = 1
    if down >= 100
      digitsDown = 0
    if up >= 100
      digitsUp = 0


    @value.down = down.toFixed(digitsDown) + sizeDown
    @value.up  = up.toFixed(digitsUp) + sizeUp

  render: ->
    """
    <div class="widget-#{@name}">
      <span class="down">#{@value.down}</span><span class="up">#{@value.up}</span>
    </div>
    """

  update: (domEl) ->
    $(domEl).find(".widget-#{@name} .down").html @value.down
    $(domEl).find(".widget-#{@name} .up").html @value.up
