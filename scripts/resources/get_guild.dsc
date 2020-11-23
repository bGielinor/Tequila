# + ██ [ Docs: https://discord.com/developers/docs/resources/guild#guild-object ] ██
get_guild:
  type: task
  definitions: group_id
  debug: false
  script:
    - inject default_guild

    - define url https://discordapp.com/api/guilds/<[group_id]>
    - define headers <yaml[saved_headers].parsed_key[discord.bot_auth]>

    - ~webget <[url]> headers:<[headers]> save:response
    - if <entry[response].failed>:
      - determine "invalid return | <entry[response].status>"
    - define guild <util.parse_yaml[{"data":<entry[response].result>}].get[data]>
    - determine <[guild]>

group_information:
  type: task
  definitions: group_id
  script:
    - ~run get_guild def:<[group_id]> save:data
    - define data <entry[data].created_queue.determination.first>

    - if <[data].starts_with[invalid]>:
      - announce to_console <&4><[data]>
      - stop

    - announce to_console <n><proc[object_formatting].context[<list_single[<[data].exclude[roles|emojis]>]>]>
