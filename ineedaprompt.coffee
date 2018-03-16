# Description:
#   Provides a random prompt
#
# Dependencies:
#   request
#
# Configuration:
#   None
#
# Commands:
#   hubot prompt - provides prompt
#   hubot prompt (adjective|noun|adverb|verb|location) - provides a prompt with the specified types
#
# Author:
#   ickybodclay
request = require "request"

module.exports = (robot) ->
  robot.respond /prompt/i, (msg) ->
    types = msg.message.text.match(/(adjective|noun|adverb|verb|location)/gi)

    url = "https://ineedaprompt.com/dictionary/default/prompt?q="

    if(types)
      url = url.concat(types.join("+"))

    request url, (error, response, body) ->
      if (!error && response.statusCode == 200)
        responseJson = JSON.parse(body)
        msg.send responseJson.english
