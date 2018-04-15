#  Copyright (c) 2018 Matthias Hollerbach (@kinglouie).
#
#  Released under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version. See <http://www.gnu.org/licenses/> for
#  details.

Widget = require '../../Widget.coffee'

module.exports = class Battery extends Widget

  refreshFrequency: 10000

  command: "sh apebar/lib/Widgets/Battery/bin/battery.sh"

  init: ->
    @value =
      discharging: true
      percentage: 100

  afterRun: ->
    values = @output.split(':')
    @value.discharging = (values[0] == '1')
    @value.percentage = parseInt(values[1])

  render: ->
    """
      <div class="widget-#{@name}">#{@value.percentage}</div>
    """

  update: (domEl) ->
    $(domEl).find(".widget-#{@name}").html @value.percentage
