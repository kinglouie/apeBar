#  Copyright (c) 2018 Matthias Hollerbach (@kinglouie).
#
#  Released under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version. See <http://www.gnu.org/licenses/> for
#  details.

Theme = require '../../Theme.coffee'
run = require 'run'

module.exports = class Pecan extends Theme

  top: 32
  left: 32
  right: 32

  render: ->
    displayId = window.location.href.split("/").pop()
    run "apebar/assets/Blurry/backgroundrunner.sh --height 35 --top #{@top} --left #{@left} --right #{@right} --material 2 -c 3 --display #{displayId}", ->
    positionsHtml =
      left: ""
      center: ""
      right: ""

    for position, widgets_list of @cfg.widgets
      for widget in widgets_list
        positionsHtml[position] += @widgets[widget].render()

    """
    <link rel="stylesheet" type="text/css" href="/apebar/assets/font-awesome/css/fontawesome-all.min.css" />
    <link rel="stylesheet" type="text/css" href="/apebar/lib/Themes/Pecan/style.css" />
    <div class="position left">#{positionsHtml.left}</div>
    <div class="position center">#{positionsHtml.center}</div>
    <div class="position right">#{positionsHtml.right}</div>
    """

#
# WIDGET OVERRIDES
#
  init: ->

    if @widgets.Battery?
      @widgets.Battery.render = ->
        """
          <div class="widget-#{@name}">
            <svg class="battery-icon" viewBox="0 0 23 16" xmlns="http://www.w3.org/2000/svg"><defs><clipPath id="juice-level"><rect x="2" y="4" width="16" height="8"/></clipPath><mask id="charging-mask" class="charging"><rect width="100%" height="100%" fill="white"/><path d="M698.89,380.05a1,1,0,0,0-.89-.55h-2.61l1.56-4.68a1,1,0,0,0-1.75-.92l-6,8a1,1,0,0,0-.09,1.05,1,1,0,0,0,.89.55h2.61l-1.56,4.68a1,1,0,0,0,.49,1.21,1,1,0,0,0,.46.11,1,1,0,0,0,.8-.4l6-8A1,1,0,0,0,698.89,380.05Z" transform="translate(-684 -373.5)" fill="black"/></mask></defs><path d="M707,381.5a2.5,2.5,0,0,1-2,2.45v-4.9A2.5,2.5,0,0,1,707,381.5Z" transform="translate(-684 -373.5)"/><g mask="url(#charging-mask)"><path d="M702.5,375.5h-17A1.5,1.5,0,0,0,684,377v9a1.5,1.5,0,0,0,1.5,1.5h17A1.5,1.5,0,0,0,704,386v-9A1.5,1.5,0,0,0,702.5,375.5Zm.5,10a1,1,0,0,1-1,1H686a1,1,0,0,1-1-1v-8a1,1,0,0,1,1-1h16a1,1,0,0,1,1,1Z" transform="translate(-684 -373.5)"/><g clip-path="url(#juice-level)"><path class="juice"  d="M686.5,377.5h15a.5.5,0,0,1,.5.5v7a.5.5,0,0,1-.5.5h-15a.5.5,0,0,1-.5-.5v-7A.5.5,0,0,1,686.5,377.5Z" transform="translate(-684 -373.5)"/></g></g><polygon class="charging" points="14 7 8.75 14 8.33 14 10 9 6 9 11.25 2 11.67 2 10 7 14 7"/></svg>
            <span class="percentage">#{@value.percentage}</span>
          </div>
        """
      @widgets.Battery.update = (domEl) ->
        $(domEl).find(".widget-#{@name} .battery-icon #juice-level rect").attr "width", @value.percentage/100*16
        if @value.discharging
          $(domEl).find(".widget-#{@name} .battery-icon .charging").hide()
        else
          $(domEl).find(".widget-#{@name} .battery-icon .charging").show()
        $(domEl).find(".widget-#{@name} .percentage").html @value.percentage

    if @widgets.Cpu?
      @widgets.Cpu.render = ->
        """
          <div class="widget-#{@name}">
            <svg xmlns="http://www.w3.org/2000/svg" width="20px" height="20px" viewBox="0 0 942 942"><g><path d="M579.1,894c0,26.5,21.5,48,48,48s48-21.5,48-48v-77.5H579.2V894H579.1z"/><path d="M579.1,48v77.5H675V48c0-26.5-21.5-48-48-48S579.1,21.5,579.1,48z"/><path d="M423,48v77.5h96V48c0-26.5-21.5-48-48-48S423,21.5,423,48z"/><path d="M423,894c0,26.5,21.5,48,48,48s48-21.5,48-48v-77.5h-96V894z"/><path d="M267,48v77.5h95.9V48c0-26.5-21.5-48-48-48S267,21.5,267,48z"/><path d="M267,894c0,26.5,21.5,48,48,48s48-21.5,48-48v-77.5h-96V894z"/><path d="M0,627c0,26.5,21.5,48,48,48h77.5v-95.9H48C21.5,579.1,0,600.5,0,627z"/><path d="M894,579.1h-77.5V675H894c26.5,0,48-21.5,48-48S920.5,579.1,894,579.1z"/><path d="M0,471c0,26.5,21.5,48,48,48h77.5v-96H48C21.5,423,0,444.5,0,471z"/><path d="M894,423h-77.5v96H894c26.5,0,48-21.5,48-48S920.5,423,894,423z"/><path d="M0,315c0,26.5,21.5,48,48,48h77.5v-96H48C21.5,267,0,288.5,0,315z"/><path d="M894,267h-77.5v95.9H894c26.5,0,48-21.5,48-48S920.5,267,894,267z"/><path d="M171.6,720.4c0,27.6,22.4,50,50,50h498.8c27.6,0,50-22.4,50-50V221.6c0-27.6-22.4-50-50-50H221.6c-27.6,0-50,22.4-50,50V720.4z"/></g></svg>
            <span class="percentage">#{@value}</span>
          </div>
        """
      @widgets.Cpu.update = (domEl) ->
        $(domEl).find(".widget-#{@name} .percentage").html @value

    if @widgets.Memory?
      @widgets.Memory.render = ->
        """
          <div class="widget-#{@name}">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 79.4 1000 774"><g><path d="M79.4,186.4C40.9,186.4,10,217,10,255.1v350c0,38,30.9,68.6,69.4,68.6h1.1v67.7c0,38.6,31.1,69.7,69.9,69.7h139.8c38.7,0,69.9-31.1,69.9-69.7v-67.7h70.2v70.6c0,38.4,30.9,69.4,69.3,69.4h350.7c38.4,0,69.3-30.9,69.3-69.4v-70.6h1c38.5,0,69.4-30.6,69.4-68.6v-350c0-38-30.9-68.7-69.4-68.7H79.4L79.4,186.4z M116.3,254.9h103.2c20.8,0,37.5,17.4,37.5,39.1v271.3c0,21.6-16.7,39.1-37.5,39.1H116.3c-20.8,0-37.5-17.4-37.5-39.1V294C78.9,272.3,95.6,254.9,116.3,254.9z M335.3,254.9h103.2c20.8,0,37.5,17.4,37.5,39.1v271.3c0,21.6-16.7,39.1-37.5,39.1H335.3c-20.8,0-37.5-17.4-37.5-39.1V294C297.8,272.3,314.5,254.9,335.3,254.9z M554.2,254.9h103.2c20.8,0,37.5,17.4,37.5,39.1v271.3c0,21.6-16.7,39.1-37.5,39.1H554.2c-20.8,0-37.5-17.4-37.5-39.1V294C516.8,272.3,533.5,254.9,554.2,254.9z M773.2,254.9h103.2c20.8,0,37.5,17.4,37.5,39.1v271.3c0,21.6-16.7,39.1-37.5,39.1H773.2c-20.8,0-37.5-17.4-37.5-39.1V294C735.7,272.3,752.4,254.9,773.2,254.9z"/></g></svg>
            <span class="percentage">#{@value}</span>
          </div>
        """
      @widgets.Memory.update = (domEl) ->
        $(domEl).find(".widget-#{@name} .percentage").html @value







