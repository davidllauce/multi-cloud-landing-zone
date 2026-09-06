package main

required := {"dll-cost-center", "dll-team", "dll-owner", "env"}

deny contains msg if {
  resource := input.resource_changes[_]
  resource.change.actions[_] == "create"

  tags := object.union(
    object.get(resource.change.after, "labels", {}),
    object.get(resource.change.after, "tags", {}),
  )
  missing := {k | k := required[_]; not tags[k]}
  count(missing) > 0

  msg := sprintf("resource %s missing required labels/tags: %v", [
    resource.address,
    concat(", ", missing),
  ])
}
