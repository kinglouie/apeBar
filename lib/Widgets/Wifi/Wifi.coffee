#  Copyright (c) 2018 Matthias Hollerbach (@kinglouie).
#
#  Released under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version. See <http://www.gnu.org/licenses/> for
#  details.

Widget = require '../../Widget.coffee'

module.exports = class Wifi extends Widget

  command: "networksetup -getairportnetwork en0 | cut -c 24-"
