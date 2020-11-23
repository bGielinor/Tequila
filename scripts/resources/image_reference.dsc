# + ██ [ docs: https://discord.com/developers/docs/reference#image-formatting ] ██
image_reference:
  type: procedure
  definitions: type|1|2
  script:
    - define base_url https://cdn.discordapp.com
    - choose <[type]>:
      - case Custom Emoji:
        # % ██ [ Input is emoji_id ] ██
        # + ██ [ docs: https://discord.com/developers/docs/resources/emoji#emoji-object ] ██
        - define url <[base_url]>/emojis/<[1]>.png

      - case Guild Icon:
        # % ██ [ input is guild_id | guild_icon ] ██
        # + ██ [ docs: https://discord.com/developers/docs/resources/guild#guild-object ] ██
        - define url <[base_url]>/icons/<[1]>/<[2]>.png

      - case Guild Splash:
        # % ██ [ input is guild_id | guild_splash ] ██
        # + ██ [ docs: https://discord.com/developers/docs/resources/guild#guild-object ] ██
        - define url <[base_url]>/splashes/<[1]>/<[2]>.png

      - case Guild Discovery Splash:
        # % ██ [ input is guild_id | guild_discovery_splash ] ██
        # + ██ [ docs: https://cdn.discordapp.com/discovery-splashes/guild_id/guild_discovery_splash.png ] ██
        - define url <[base_url]>/discovery-splashes/<[1]>/<[2]>.png

      - case Guild Banner:
        # % ██ [ input is guild_id | guild_banner ] ██
        # + ██ [ docs: https://cdn.discordapp.com/banners/guild_id/guild_banner.png ] ██
        - define url <[base_url]>/banners/<[1]>/<[2]>.png

      - case Default User Avatar:
        # % ██ [ input is user_discriminator ] ██
        # + ██ [ docs: https://cdn.discordapp.com/embed/avatars/user_discriminator.png ] ██
        - define url <[base_url]>/embed/avatars/<[1]>.png

      - case User Avatar:
        # % ██ [ input is user_id | user_avatar ] ██
        # + ██ [ docs: https://cdn.discordapp.com/avatars/user_id/user_avatar.png ] ██
        - define url <[base_url]>/avatars/<[1]>/<[2]>.png

      - case Application Icon:
        # % ██ [ input is application_id | icon ] ██
        # + ██ [ docs: https://cdn.discordapp.com/app-icons/application_id/icon.png ] ██
        - define url <[base_url]>/app-icons/<[1]>/<[2]>.png

      - case Application Asset:
        # % ██ [ input is application_id | asset_id ] ██
        # + ██ [ docs: https://cdn.discordapp.com/app-assets/application_id/asset_id.png ] ██
        - define url <[base_url]>/app-assets/<[1]>/<[2]>.png

      - case Team Icon:
        # % ██ [ input is team_id | team_icon ] ██
        # + ██ [ docs: https://cdn.discordapp.com/team-icons/team_id/team_icon.png ] ██
        - define url <[base_url]>/team-icons/<[1]>/<[2]>.png

    - determine <[url]>
