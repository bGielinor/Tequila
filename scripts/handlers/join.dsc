user_joins:
  type: world
  events:
    after discord user joins:
      - define author <context.user||invalid>
      - if <[author]> == invalid:
        - stop

      - run user_join_announcement def:<[author]>
