#  Copyright (c) 2018 Matthias Hollerbach (@kinglouie).
#
#  Released under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version. See <http://www.gnu.org/licenses/> for
#  details.

run = require 'run'

module.exports = class Widget

  command: "echo ''"
  refreshFrequency: 0

  constructor: ->
    @output = ""
    @value = ""
    @needsUpdate = false
    @lastRun = 0
    @name = @constructor.name
    @init()

  init: ->

  run: ->
    run @command, (err, stdout) =>
      @output = stdout
      @needsUpdate = true
      @afterRun()
    @lastRun = Date.now()
    
  afterRun: ->
    @value = @output

  render: ->
    """
      <div id="apebar-#{@name}">#{@value}</div>
    """

  update: ->
    $("#apebar-#{@name}").html @value
