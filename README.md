# koishi-adapter-minecraft  

Minecraft adapter for [koishi](https://github.com/koishijs/koishi)  

# 使用方法  

1. 添加 `koishi-adapter-koishi` 到您的项目  
2. 导入 `koishi-adapter-koishi` 并在您的配置文件内新建一个机器人  
3. 启动您的机器人  

配置样例
```javascript
{
    type: 'minecraft',
    selfId: 'bot',      // 注意 selfId 是必填项，配置文件中必须写
    host: '127.0.0.1',  // 后面的配置请参考 https://github.com/PrismarineJS/mineflayer
    username: 'bot'     // offline 的情况下 username 就是 Minecraft 里的名字
}
```  

# 注意事项  

1. 可能会有 bug， 如果遇到问题请提交您的 issue  
2. 整个服务器将会被当作同一个频道  
3. private 消息的实现使用了 /tell 指令，如果需要使用 private 消息请在服务器里安装 ess 插件  
4. 由于 mineflayer 的原理是模拟一个玩家，所以该用户会被看见或者杀死，您可以给这个玩家设置其他的出生点、给予创造模式或者观察者模式等来避免这些问题  

# TODO  

1. 收到 private 消息的时候处理为 private 消息  

# license  

MIT  