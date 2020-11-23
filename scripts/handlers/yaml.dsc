yaml_handler:
  type: world
  load:
    - foreach <yaml[configurations].read[configurations]> key:yaml as:file_path:
      - ~run load_yaml def:<[yaml]>|<[file_path]>|false|false

  events:
    on server start:
      - yaml id:configurations load:data/configurations.yml
      - inject locally load

    on script reload:
      - inject locally load

load_yaml:
  type: task
  definitions: yaml|file_path|save|force
  script:
    - if <yaml.list.contains[<[yaml]>]>:
      - if <[save]>:
        - yaml id:<[yaml]> savefile:<[file_path]>
        - announce to_console "<&e>Yaml saved<&6>: <&a><[yaml]>"
      - yaml id:<[yaml]> unload
      - announce to_console "<&e>Yaml unloaded<&6>: <&a><[yaml]>"

    - if <server.has_file[<[file_path]>]>:
      - yaml id:<[yaml]> load:<[file_path]>
      - announce to_console "<&e>Yaml loaded<&6>: <&a><[yaml]>"

    - else if <[force]>:
      - yaml id:<[yaml]> create
      - yaml id:<[yaml]> savefile:<[file_path]>
      - announce to_console "<&e>Yaml created<&6>: <&a><[yaml]>"

save_yaml:
  type: task
  definitions: yaml
  script:
    - if <yaml[configurations].contains[configurations.<[yaml]>]>:
      - yaml id:<[yaml]> savefile:<yaml[configurations].read[configurations.<[yaml]>]>
