Lighthouse-role
=========

This role install and configure `lighthouse` on target host(s).

For work `lighthouse` correctly role also install `nginx` and configure them to work with `lighthouse`

Example Playbook
----------------

```
    - hosts: servers
      roles:
         - lighthouse-role 
```

License
-------

MIT

Author Information
------------------

Sergey Zhukov (beatljs@mail.ru)

DevOps-32
