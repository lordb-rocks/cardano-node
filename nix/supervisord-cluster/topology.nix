{ stateDir
, graphviz
, composition
}:
with composition;

''
  mkdir -p "${stateDir}"

  args=( --topology-output "${stateDir}/topology.json"
         --dot-output      "${stateDir}/topology.dot"
         --size             ${toString n_hosts}
         ${toString
           (map (l: ''--loc ${l}'') locations)}
       )

  topology "''${args[@]}"

  jq .   "${stateDir}/topology.json" |
  sponge "${stateDir}/topology.json"

  ${graphviz}/bin/neato -s120 -Tpdf \
     "${stateDir}/topology.dot" > "${stateDir}/topology.pdf"
''
