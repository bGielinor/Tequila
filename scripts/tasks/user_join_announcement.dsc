user_join_announcement:
  type: task
  definitions: user_id|group_id
  debug: true
  script:
  # % ██ [ obtain user info             ] ██
      - define headers <yaml[saved_headers].parsed_key[discord.bot_auth]>
      - define group_name <yaml[configurations].read[groups].get[<[group_id]>]>
      - if !<yaml[configurations].read[join_channels].contains[<[group_name]>]>:
        - stop
      - define channel_id <yaml[configurations].read[join_channels.<[group_name]>]>
      - define url https://discordapp.com/api/channels/<[channel_id]>/messages

      - ~webget https://discordapp.com/api/users/<[user_id]> headers:<[headers]> save:response
      - if <entry[response].failed>:
        - define color 14941952
        - define title "<[user_id]> joined the Discord"
        - define context "<list_single[**Error retrieving user information**:]>"
        - define context "<[context].include_single[**Status Code**: `<entry[response].status>`]>"
        - define context "<[context].include_single[**Response**: `<entry[response].result>`]>"
        - define context "<[context].include_single[**Consolidated Reason**: `Discord backend borking`]>"
        - define description <[context].separated_by[<n>]>
        - define data <script.parsed_key[response].to_json>
        - ~webget <[url]> method:post data:<[data]> headers:<[headers]> save:response
        - stop

      - define data <util.parse_yaml[<entry[response].result>]>
      - define user_avatar https://cdn.discordapp.com/avatars/<[user_id]>/<[data].get[avatar]>
      - define discriminator <[data].get[discriminator]>
      - define username <[data].get[username]>

      - define first_joined <util.time_now.sub[<util.time_now.epoch_millis.sub[<[user_id].div[4194304].add[1420070400000]>].mul[0.001]>]>
      - define first_joined_formatted "<[first_joined].add[8h].format[MM/dd/yyyy hh:mm:ss]>"
      - define time_since <util.time_now.duration_since[<[first_joined]>]>
      - if <[time_since].in_years> > 0:
        - define years <[time_since].in_years.round_down>
        - if <[years]> > 1:
          - define years_grammar "<[years]> years"
        - else:
          - define years_grammar "<[years]> year"

        - define days <[time_since].in_days.round_down.sub[<[time_since].in_years.round_down.mul[365]>]>
        - if <[days]> > 1:
          - define days_grammar "and <[days]> days ago"
        - else if <[days]> == 1:
          - define days_grammar "and <[days]> day ago"
        - else:
          - define days_grammar ago

        - define account_age_formatted "<[years_grammar]> <[days_grammar]>"
      - else:
        - define days <[time_since].in_days.round_down>
        - define account_age_formatted "<[days]> days ago"

      - define title "<[username]>`<&ns><[discriminator]>` joined the Discord!"
      - define context "<list_single[**Discord Profile**: <&lt>@<[user_id]><&gt>]>"
      - define context "<[context].include_single[**Discord ID**:`<[user_id]>`]>"
      - define context "<[context].include_single[**Discord Join Date**: `<[first_joined_formatted]>`]>"
      - define context "<[context].include_single[**Discord Account Created**: `<[account_age_formatted]>`]>"


      - define color 65279
      - define thumbnail_url <[user_avatar]>
      - define title <[title]>
      - define description <[context].separated_by[<&nl>]>
      - define data <script.parsed_key[response].to_json>

      - ~webget <[url]> method:post data:<[data]> headers:<[headers]> save:response

  response:
    embed:
      color: <[color]>
      description: <[description]>
      title: <[title]>
      thumbnail:
        url: <[thumbnail_url]||>
