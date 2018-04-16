#  Copyright (c) 2018 Matthias Hollerbach (@kinglouie).
#
#  Released under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version. See <http://www.gnu.org/licenses/> for
#  details.

apebar = require './lib/Apebar.coffee'
widgets = require './lib/Widgets/index.coffee'
themes = require './lib/Themes/index.coffee'

cfg = null
bars = []

refreshFrequency: 500

init: ->
  if !@initialized
    # load configuration
    cfg = apebar.getJson "./apebar/config.json"

    # match display configuration
    barsConfiguration = cfg[apebar.matchDisplay cfg]

    if apebar.typeIsArray barsConfiguration
      for barCfg in barsConfiguration
        bars.push new themes[barCfg.theme](barCfg)
    else
      bars.push new themes[barsConfiguration.theme](barsConfiguration)

    @initialized = true

command: (callback) ->
  @init()
  for bar in bars
    bar.run()
  callback()

render: ->
  output = ""
  for bar, index in bars
    output += "<div class=\"#{bar.themeName}\" id=\"apebar-#{bar.themeName}-#{index}\">"
    output += bar.render()
    output += "</div>"
  output

afterRender: (domEl) ->
  for bar, index in bars
    # using queryselector because document.getElementById returns null
    el = domEl.querySelector "#apebar-#{bar.themeName}-#{index}"
    bar.afterRender(el)

update: ->
  for bar, index in bars
    domEl = document.getElementById "apebar-#{bar.themeName}-#{index}"
    bar.update(domEl)

style:
  """
  left: 0
  right: 0
  top:0
  bottom: 0
  > div
    position: absolute
  """
