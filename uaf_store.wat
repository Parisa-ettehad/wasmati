(module
    (type $alloc_t (func (result i32)))
    (type $free_t  (func (param i32)))
    (type $void_t  (func))

    (import "env" "malloc" (func $malloc (type $alloc_t)))
    (import "env" "free"   (func $free   (type $free_t)))

    (memory 1)

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
        i32.const 10
        i32.store

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
        i32.const 20
        i32.store

        local.get $v2
        call $free
    )

    (start $bad)
)