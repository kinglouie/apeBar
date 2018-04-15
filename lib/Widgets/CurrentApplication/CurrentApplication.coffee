#  Copyright (c) 2018 Matthias Hollerbach (@kinglouie).
#
#  Released under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version. See <http://www.gnu.org/licenses/> for
#  details.

Widget = require '../../Widget.coffee'

MAX_LENGTH = 80

module.exports = class CurrentApplication extends Widget

  refreshFrequency: 500

  commands =
    app: "/usr/local/bin/chunkc tiling::query -w owner"
    title:  "/usr/local/bin/chunkc tiling::query -w name"

  command: "echo " +
           "$(#{ commands.app }):::" +
           "$(#{ commands.title })"

  init: ->
    @value =
      windowApplication: ""
      windowTitle: ""

  afterRun: ->
    output = @output.split( /:::/g )

    app = output[0]
    title  = output[1]

    if "#{app}" == "?"
      app = "Finder"
      title = "Desktop"

    if app.replace( /([ \t\n])/g, "" ).length > 0
      app = app

    if title.replace( /([ \t\n])/g, "" ).length > 0
      if title.length > MAX_LENGTH
        title = title.substr(0, MAX_LENGTH) + "..."
      else
        title = title

    if app != "" and title != ""
      @value.windowApplication = app
      @value.windowTitle = title

  render: ->
    """
    <div class="widget-#{@name}">
      <span class="window-application">#{@value.windowApplication}</span><span class="window-title">#{@value.windowTitle}</span>
    </div>
    """

  update: (domEl) ->
    $(domEl).find(".widget-#{@name} .window-application").html @value.windowApplication
    $(domEl).find(".widget-#{@name} .window-title").html @value.windowTitle
