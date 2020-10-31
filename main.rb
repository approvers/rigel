require 'discordrb'
require 'dotenv'

Dotenv.load

transfer_to = ENV['TRANSFER']
$question_queue = 0
bot = Discordrb::Commands::CommandBot.new(
    token: ENV['TOKEN'],
    client_id: ENV['CLIENT_ID'],
    prefix:'!Q.',
    )


bot.command :help do | event |
    event.send_embed do | embed |
        embed.title = "Command List"
        embed.url = "https://github.com/approvers/rigel"
        embed.colour = 0x00ccff
        embed.description = "```*r.help - このヘルプを表示\n*r.about - このボットの詳細を表示\n*r.LICENSE - ソースコードのライセンスを表示 ``` ***†新機能†*** \n メッセージに📧の絵文字をつけると自動的に学校からのお知らせチャンネルに転送します\n\n機能追加は言ってもらえば(僕の技術力の許す限り)しようと思いますのでよろしくお願いします"
        embed.footer = Discordrb::Webhooks::EmbedFooter.new(
            text: "このボットのソースコードはMITライセンスの元、オープンソースで公開されています",
        )
    end
end

bot.message(start_with: "Q:") do | event |
        p("[debug] catch message")
        message = event.message
        if message.author == bot
          break
        end
        $question_queue = $question_queue + 1
        bot.send_message(transfer_to, "#{event.author.name}さんからの質問:\n```#{message}```")
        file = File.open("LT-Q.html", "w:UTF-8")
        body = <<-EOS
<center>
<h1>†現在の質問数†</h1>
<h1 style="font-size: 90px;">#{$question_queue}</h1>
</center>
        EOS
        file.write(body)
end

bot.command :queue do |event|
    event.send_embed do | embed |
    embed.title = "Question Queue"
    embed.url = "https://github.com/laminne/rigel"
    embed.colour = 0x00ccff
    embed.description = "現在の質問の数:\n**#{$question_queue}**"
    embed.footer = Discordrb::Webhooks::EmbedFooter.new(
        text: "このボットのソースコードはMITライセンスの元、オープンソースで公開されています",
        )
  end
end

bot.run
