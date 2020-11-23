connection_handler:
  type: world
  debug: false
  events:
    on server start:
      - announce to_console "<&a>[ <&e>Discord Connections start in<&6>: <&e>13s <&a>]"
      - wait 13s
      - ~discord id:bot connect code:<yaml[tokens].read[discord.bot]>
      - wait 3s
      - ~run channel_cache

    on shutdown:
      - discord id:bot disconnect
