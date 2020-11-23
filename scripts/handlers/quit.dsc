user_quits:
  type: world
  events:
    on discord user leaves:
      - define author <context.user||invalid>
      - if <[author]> == invalid:
        - stop

  # % ██ [ obtain user info             ] ██
      - define user_id <[author].id>
      - define headers <yaml[saved_headers].parsed_key[discord.bot_auth]>
      - ~webget https://discordapp.com/api/users/<[user_id]> headers:<[headers]> save:response
      - if <entry[response].failed>:
        - define embed <discordembed>
        - define embed <[embed].color[14941952]>
        - define embed "<[embed].title[<[user_id]> joined the Discord]>"
        - define context "<list_single[**Error retrieving user information**:]>"
        - define context "<[context].include_single[**Status Code**: `<entry[response].status>`]>"
        - define context "<[context].include_single[**Response**: `<entry[response].result>`]>"
        - define embed <[embed].description[<[context].separated_by[<&nl>]>]>
        - stop
      - define data <util.parse_yaml[<entry[response].result>]>
      - define user_avatar https://cdn.discordapp.com/avatars/<[user_id]>/<[data].get[avatar]>?size=64
      - define discriminator <[data].get[discriminator]>
      - define username <[data].get[username]>

      - define title "<[username]>`#<[discriminator]>` left the Discord."
      - define context "<list_single[**Discord Profile**: <&lt>@<[user_id]><&gt>]>"
      - define context "<[context].include_single[**Discord ID**:`<[user_id]>`]>"

      - define embed <discordembed>
      - define embed <[embed].color[65279]>
      - define embed <[embed].thumbnail_url[<[user_avatar]>]>
      - define embed <[embed].title[<[title]>]>
      - define embed <[embed].description[<[context].separated_by[<&nl>]>]>

      - discord id:bot send_embed channel:773728812215173170 embed:<[embed]>
