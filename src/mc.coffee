{ Adapter, Bot, Session } = require 'koishi-core'
{ transformContent, createSession } = require './utils'
mineflayer = require 'mineflayer'

class MinecraftBot extends Bot
  constructor: (adapter, options) ->
    super(adapter, options)
    @options = options
    Object.defineProperty this, 'username',
      get: => @mc.player?.username?.toString() ? ''
    Object.defineProperty this, 'nickname',
      get: => @mc.player?.displayName?.toString() ? ''

  sendMessage: (_, content) -> @mc.chat transformContent content

  sendPrivateMessage: (username, content) ->
    @mc.chat "/tell #{username} #{transformContent content}"

  getSelf: -> { userId: @username, nickname: @nickname }

  getUser: (userId) ->
    player = @mc.players[userId]
    return if player
      { userId, nickname: player.displayName.toString() }
    else
      { userId, nickname: userId }

  getFriendList: -> @mc.players.map (player) -> {
    userId: player.username
    nickname: player.displayName.toString()
  }

  getGroup: -> { groupId: 'minecraft', groupName: 'minecraft' }
  getGroupList: -> [@getGroup()]
  getGroupMember: @getUser
  getGroupMemberList: @getFriendList
  getChannel: @getGroup
  getChannelList: @getGroupMemberList



class MinecraftAdapter extends Adapter
  constructor: (app) -> super app, MinecraftBot
  
  start: -> this.bots.forEach (bot) =>
    bot.mc = mineflayer.createBot bot.options
    bot.status = Bot.Status.GOOD
    bot.mc.on 'error', bot.logger.error
    bot.mc.on 'chat', (username, message) =>
      if username == bot.username then return
      session = await createSession this.app, bot, username, message
      this.dispatch session

module.exports = { MinecraftAdapter, MinecraftBot }