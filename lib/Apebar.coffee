#  Copyright (c) 2018 Matthias Hollerbach (@kinglouie).
#
#  Released under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version. See <http://www.gnu.org/licenses/> for
#  details.

getJson = (url) ->
  data = $.ajax
    url: url,
    dataType: 'json',
    async: false
  .responseText
  return JSON.parse data

matchTheme = (themesConfig) ->

  matchedThemeConfig = "default"

  for themeCfgKey, themeCfg of themesConfig
    k = themeCfgKey.replace(/ /g,'')

    if k.indexOf "display_width" == 0
      r = k.substring(13)
      width = r.match(/\d+/)
      if width
        if r.indexOf("<") == 0 and screen.width < parseInt width[0] or
          r.indexOf(">") == 0 and screen.width > parseInt width[0]
            matchedThemeConfig = themeCfgKey

    else if k.indexOf "display_height" == 0
      r = k.substring(13)
      height = r.match(/\d+/)
      if height
        if r.indexOf("<") == 0 and screen.height < parseInt height[0] or
          r.indexOf(">") == 0 and screen.height > parseInt height[0]
            matchedThemeConfig = themeCfgKey
 
  return matchedThemeConfig


module.exports.matchTheme = matchTheme
module.exports.getJson = getJson
