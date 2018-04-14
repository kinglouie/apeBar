#  Copyright (c) 2018 Matthias Hollerbach (@kinglouie).
#
#  Released under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version. See <http://www.gnu.org/licenses/> for
#  details.

Widget = require '../../Widget.coffee'

module.exports = class Cpu extends Widget

  refreshFrequency: 2500

  command: "ESC=`printf \"\e\"`; ps -A -o %cpu | awk '{s+=$1} END {printf(\"%.2f\",s/8);}'"

  afterRun: ->
    output = parseFloat @output
    digits = 2
    if output >= 10
        digits = 1
    if output >= 100
        digits = 0


    @value = output.toFixed digits