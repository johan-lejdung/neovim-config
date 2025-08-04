((
  (raw_string_literal) @constant
  (#match? @constant "(SELECT|select|insert|INSERT|UPDATE|update|WITH|with).*")
)@injection.content (#set! injection.language "sql"))
