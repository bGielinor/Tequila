# + ██ [ Docs: https://discord.com/developers/docs/resources/channel#channels-resource ] ██
get_guild_channels:
  type: task
  definitions: group_id
  script:
    - inject default_guild

    - define url https://discordapp.com/api/guilds/<[group_id]>/channels
    - define headers <yaml[saved_headers].parsed_key[discord.bot_auth]>

    - ~webget <[url]> headers:<[headers]> save:response
    - if <entry[response].failed>:
      - determine "invalid return | <entry[response].status>"
    - define channels <util.parse_yaml[{"data":{<entry[response].result>}].get[data]>
    - if <[channels].is_empty>:
      - determine "invalid return | empty list"
    - determine <[channels]>

guild_channels_information:
  type: task
  definitions: group_id
  script:
    - ~run get_guild_channels def:<[group_id]> save:data
    - define data <entry[data].created_queue.determination.first>

    - if <[data].starts_with[invalid]>:
      - announce to_console <&4><[data]>
      - stop

    - announce to_console <n><proc[object_formatting].context[<list_single[<[data].exclude[roles|emojis]>]>]>

get_channel:
  type: task
  definitions: channel_id
  script:
    - inject default_guild

    - define url https://discordapp.com/api/channels/<[channel_id]>
    - define headers <yaml[saved_headers].parsed_key[discord.bot_auth]>

    - ~webget <[url]> headers:<[headers]> save:response
    - if <entry[response].failed>:
      - determine "invalid return | <entry[response].status>"
    - define channels <util.parse_yaml[{"data":{<entry[response].result>}].get[data]>
    - determine <[channels]>

channel_information:
  type: task
  definitions: channel_id
  script:
    - ~run get_channel def:<[channel_id]> save:data
    - define data <entry[data].created_queue.determination.first>

    - if <[data].starts_with[invalid]>:
      - announce to_console <&4><[data]>
      - stop

    - announce to_console <n><proc[object_formatting].context[<list_single[<[data].exclude[permission_overwrites]>]>]>
