(module
  (type $alloc_t (func (result i32)))
  (type $free_t  (func (param i32)))
  (type $sink_t  (func (param i32)))
  (type $void_t  (func))

  (import "env" "malloc" (func $malloc (type $alloc_t)))
  (import "env" "free"   (func $free   (type $free_t)))
  (import "env" "sink"   (func $sink   (type $sink_t)))

  (func $bad (type $void_t)
    (local $v1 i32)
    (local $v2 i32)
    call $malloc
    local.set $v1
    call $malloc
    local.set $v2
    local.get $v1
    call $free
    local.get $v1
    call $sink
    local.get $v2
    call $free
  )

  (func $good (type $void_t)
    (local $v1 i32)
    (local $v2 i32)
    call $malloc
    local.set $v1
    call $malloc
    local.set $v2
    local.get $v1
    call $free
    local.get $v2
    call $sink
    local.get $v2
    call $free
  )

  (start $bad)
)



