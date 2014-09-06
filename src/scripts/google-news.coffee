# Description
#   A Hubot script that display the google news
#
# Dependencies:
#   "hubot-arm": "^0.2.1",
#   "hubot-request-arm": "^0.2.1"
#
# Configuration:
#   None
#
# Commands:
#   hubot google-news - display the google news
#
# Author:
#   bouzuya <m@bouzuya.net>
#
module.exports = (robot) ->
  require('hubot-arm') robot

  robot.respond /google-news$/i, (res) ->
    url = 'https://news.google.co.jp/'
    res
      .robot
      .arm('request')
        method: 'GET'
        url: url
        format: 'html'
      .then (r) ->
        articles = []
        r.$('.esc-lead-article-title a.article').each ->
          e = r.$ @
          href = e.attr('href')
          title = e.text()
          article = "#{title} #{href}"
          articles.push article
        res.send articles.filter((item, i) -> i < 10).join('\n')
