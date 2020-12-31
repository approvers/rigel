# Rigel

限界LT#1に合わせて書き換えれたコードです

## 起動方法

1. `.env`を作成し、

```
TOKEN="<Discord Bot token>"
CLIENT_ID="<Discord Bot Client ID>"
CHANNEL_ID="<Discord Channel ID>"
TRANSFER="<Discord Channel ID>"
```

環境に合わせ適宜書き換えてください

2. `bundle install`を実行(Gem のインストール)
3. `ruby main.rb`を実行  
   ※discordrb は libsodium への依存関係が存在しているようなので事前にインストールしておく必要があります
