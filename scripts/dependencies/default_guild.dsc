default_guild:
  type: task
  definitions: group_id
  script:
    - if <[group_id]||invalid> == invalid:
      - define group_id <yaml[configurations].data_key[groups.behrcraft]>
