#  Copyright (c) 2018 Matthias Hollerbach (@kinglouie).
#
#  Released under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version. See <http://www.gnu.org/licenses/> for
#  details.

Theme = require '../../Theme.coffee'

module.exports = class Apple extends Theme

  render: ->
    displayId = window.location.href.split("/").pop()
    run "apebar/assets/Blurry/backgroundrunner.sh --height 22 --top 0 --left 0 --right 0 --material 9 --display #{displayId}", ->
    positionsHtml =
      left: ""
      center: ""
      right: ""

    for position, widgets_list of @cfg.widgets
      for widget in widgets_list
        positionsHtml[position] += @widgets[widget].render()

    """
    <link rel="stylesheet" type="text/css" href="/apebar/lib/Themes/Apple/style.css" />
    <div class="left">#{positionsHtml.left}</div>
    <div class="center">#{positionsHtml.center}</div>
    <div class="right">#{positionsHtml.right}</div>
    """

#
# WIDGET OVERRIDES
#

  init: ->

    if @widgets.Battery?
      @widgets.Battery.render = ->
        """
          <div id="apebar-#{@name}">
            <svg class="battery-icon" viewBox="0 0 23 16" xmlns="http://www.w3.org/2000/svg"><defs><clipPath id="juice-level"><rect x="2" y="4" width="16" height="8"/></clipPath><mask id="charging-mask" class="charging"><rect width="100%" height="100%" fill="white"/><path d="M698.89,380.05a1,1,0,0,0-.89-.55h-2.61l1.56-4.68a1,1,0,0,0-1.75-.92l-6,8a1,1,0,0,0-.09,1.05,1,1,0,0,0,.89.55h2.61l-1.56,4.68a1,1,0,0,0,.49,1.21,1,1,0,0,0,.46.11,1,1,0,0,0,.8-.4l6-8A1,1,0,0,0,698.89,380.05Z" transform="translate(-684 -373.5)" fill="black"/></mask></defs><path d="M707,381.5a2.5,2.5,0,0,1-2,2.45v-4.9A2.5,2.5,0,0,1,707,381.5Z" transform="translate(-684 -373.5)"/><g mask="url(#charging-mask)"><path d="M702.5,375.5h-17A1.5,1.5,0,0,0,684,377v9a1.5,1.5,0,0,0,1.5,1.5h17A1.5,1.5,0,0,0,704,386v-9A1.5,1.5,0,0,0,702.5,375.5Zm.5,10a1,1,0,0,1-1,1H686a1,1,0,0,1-1-1v-8a1,1,0,0,1,1-1h16a1,1,0,0,1,1,1Z" transform="translate(-684 -373.5)"/><g clip-path="url(#juice-level)"><path class="juice"  d="M686.5,377.5h15a.5.5,0,0,1,.5.5v7a.5.5,0,0,1-.5.5h-15a.5.5,0,0,1-.5-.5v-7A.5.5,0,0,1,686.5,377.5Z" transform="translate(-684 -373.5)"/></g></g><polygon class="charging" points="14 7 8.75 14 8.33 14 10 9 6 9 11.25 2 11.67 2 10 7 14 7"/></svg>
            <span class="percentage">#{@value.percentage}</span>
          </div>
        """
      @widgets.Battery.update = ->
        $("#apebar-#{@name} .battery-icon #juice-level rect").attr "width", @value.percentage/100*16
        if @value.discharging
          $("#apebar-#{@name} .battery-icon .charging").hide()
        else
          $("#apebar-#{@name} .battery-icon .charging").show()
        $("#apebar-#{@name} .percentage").html @value.percentage
