{ Session } = require 'koishi-core'
{ Random, segment } = require 'koishi-utils'
qface = require 'qface'

transformContent = (content) -> segment.transform content,
  at: (data) -> " @#{data.id} "
  face: (data) -> "[#{(qface.get data.id)?.QDes ? '表情'}]"
  image:     -> '[图片]'
  audio:     -> '[语音]'
  video:     -> '[视频]'
  file:      -> '[文件]'
  quote:     -> '[引用]'
  card:      -> '[卡片]'

createSession = (app, bot, username, message) -> session = new Session app,
  type: 'message'
  subtype: 'group'
  platform: 'minecraft'
  selfId: bot.username
  userId: username
  channelId: 'minecraft'
  messageId: Random.uuid()
  timestamp: new Date()
  content: message
  author:
    userId: username
  nickname: (await bot.getUser username).nickname

module.exports = { transformContent, createSession }