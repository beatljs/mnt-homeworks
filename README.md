
---
<img src="Netology.png" height="24px"/>

### Учебная группа DevOps-32

---

## Решение по домашнему заданию к занятию 5 «Тестирование roles» c использованием `molecule`


- [Описание](#description)
- [Требования к инфраструктуре](#requirements)
- [Переменные и настройки](#vars-and-setup)
- [Запуск](#play)
- [Исполнитель](#student)

---

###### Description
### Описание

Здесь приводится результат выполнения домашнего задания 5 «Тестирование roles» c использованием `molecule`.

Код написан для выполнения домашнего задания 5 в рамках обучения работе с `Ansible` и базируется на коде из домашнего задания 4.

В развитие навыков работы с `ansible` в настоящем коде сформированы каталоги и сценарии `molecule` для выполнения тестрования роли `vector-role`.

Тестирование роли `vector-role` реализовано через контейнеры `docker` для платформ `centos:7` и `debian`.


---

###### Requirements
### Требования к инфрастуктуре

Для успешного запуска тестирования требуется на `control node`: 

1. Docker version 18.09.1, build 4c52b90
2. Установленный Python 3.9.1
3. Ansible [core 2.15.3]
4. Установленный пакет molecule: `pip3 install "molecule==3.5.2"`. Имеено этой версии, на последней версии работать не будет. 
5. Драйвер `pip3 install "molecule_docker==1.1.0"`. Именно этой версии! 

---

###### Vars and Setup
### Переменные и настройки

Для запуска тестирования в рамках настоящего ДЗ настроек переменных не требуется.

---

###### Play
### Запуск

Запуск тестирования: 

Запуск должен производиться из каталога `playbook/roles/vector-role`: 

``` 
molecule test -s centos_debian

```

<details>
    <summary> Вывод ansible...  </summary>

```
beatl@OWEN:~/mnt-homeworks/05/playbook/roles/vector-role$ molecule test -s centos_debian 
INFO     centos_debian scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/home/beatl/.cache/ansible-compat/f5bcd7/modules:/home/beatl/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/beatl/.cache/ansible-compat/f5bcd7/collections:/home/beatl/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/home/beatl/.cache/ansible-compat/f5bcd7/roles:/home/beatl/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running centos_debian > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running centos_debian > lint
COMMAND: yamllint .
ansible-lint
flake8


Passed: 0 failure(s), 0 warning(s) on 24 files. Last profile that met the validation criteria was 'production'.
INFO     Running centos_debian > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running centos_debian > destroy
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos_7)
changed: [localhost] => (item=debian_buster)

TASK [Wait for instance(s) deletion to complete] *******************************
ok: [localhost] => (item=centos_7)
ok: [localhost] => (item=debian_buster)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running centos_debian > syntax

playbook: /home/beatl/mnt-homeworks/05/playbook/roles/vector-role/molecule/centos_debian/converge.yml
INFO     Running centos_debian > create

PLAY [Create] ******************************************************************

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None) 
skipping: [localhost] => (item=None) 
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'wheel', 'container': 'docker'}, 'image': 'centos:7', 'name': 'centos_7', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']})
ok: [localhost] => (item={'capabilities': ['SYS_ADMIN'], 'command': '/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'sudo', 'container': 'docker'}, 'image': 'python:3.8-slim-buster', 'name': 'debian_buster', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']})

TASK [Create Dockerfiles from image names] *************************************
changed: [localhost] => (item={'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'wheel', 'container': 'docker'}, 'image': 'centos:7', 'name': 'centos_7', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']})
changed: [localhost] => (item={'capabilities': ['SYS_ADMIN'], 'command': '/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'sudo', 'container': 'docker'}, 'image': 'python:3.8-slim-buster', 'name': 'debian_buster', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']})

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={'diff': [], 'dest': '/home/beatl/.cache/molecule/vector-role/centos_debian/Dockerfile_centos_7', 'src': '/home/beatl/.ansible/tmp/ansible-tmp-1695009499.7401357-56286-267866889609512/source', 'md5sum': '66eab1607b3083050b102b976560c944', 'checksum': '5486d641b43265faca0cc762ec2149f46293ce71', 'changed': True, 'uid': 1000, 'gid': 1000, 'owner': 'beatl', 'group': 'beatl', 'mode': '0600', 'state': 'file', 'size': 1390, 'invocation': {'module_args': {'src': '/home/beatl/.ansible/tmp/ansible-tmp-1695009499.7401357-56286-267866889609512/source', 'dest': '/home/beatl/.cache/molecule/vector-role/centos_debian/Dockerfile_centos_7', 'mode': '0600', 'follow': False, '_original_basename': 'Dockerfile.j2', 'checksum': '5486d641b43265faca0cc762ec2149f46293ce71', 'backup': False, 'force': True, 'unsafe_writes': False, 'content': None, 'validate': None, 'directory_mode': None, 'remote_src': None, 'local_follow': None, 'owner': None, 'group': None, 'seuser': None, 'serole': None, 'selevel': None, 'setype': None, 'attributes': None}}, 'failed': False, 'item': {'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'wheel', 'container': 'docker'}, 'image': 'centos:7', 'name': 'centos_7', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})
ok: [localhost] => (item={'diff': [], 'dest': '/home/beatl/.cache/molecule/vector-role/centos_debian/Dockerfile_python_3_8_slim_buster', 'src': '/home/beatl/.ansible/tmp/ansible-tmp-1695009500.527296-56286-1370001063594/source', 'md5sum': '93b744be6a1fdf35780cc8ee6a40edec', 'checksum': 'aa3d0e47d37d18ea815acbe86110445e356dfa4d', 'changed': True, 'uid': 1000, 'gid': 1000, 'owner': 'beatl', 'group': 'beatl', 'mode': '0600', 'state': 'file', 'size': 1399, 'invocation': {'module_args': {'src': '/home/beatl/.ansible/tmp/ansible-tmp-1695009500.527296-56286-1370001063594/source', 'dest': '/home/beatl/.cache/molecule/vector-role/centos_debian/Dockerfile_python_3_8_slim_buster', 'mode': '0600', 'follow': False, '_original_basename': 'Dockerfile.j2', 'checksum': 'aa3d0e47d37d18ea815acbe86110445e356dfa4d', 'backup': False, 'force': True, 'unsafe_writes': False, 'content': None, 'validate': None, 'directory_mode': None, 'remote_src': None, 'local_follow': None, 'owner': None, 'group': None, 'seuser': None, 'serole': None, 'selevel': None, 'setype': None, 'attributes': None}}, 'failed': False, 'item': {'capabilities': ['SYS_ADMIN'], 'command': '/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'sudo', 'container': 'docker'}, 'image': 'python:3.8-slim-buster', 'name': 'debian_buster', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']}, 'ansible_loop_var': 'item', 'i': 1, 'ansible_index_var': 'i'})

TASK [Build an Ansible compatible image (new)] *********************************
ok: [localhost] => (item=molecule_local/centos:7)
ok: [localhost] => (item=molecule_local/python:3.8-slim-buster)

TASK [Create docker network(s)] ************************************************
skipping: [localhost]

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'wheel', 'container': 'docker'}, 'image': 'centos:7', 'name': 'centos_7', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']})
ok: [localhost] => (item={'capabilities': ['SYS_ADMIN'], 'command': '/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'sudo', 'container': 'docker'}, 'image': 'python:3.8-slim-buster', 'name': 'debian_buster', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos_7)
changed: [localhost] => (item=debian_buster)

TASK [Wait for instance(s) creation to complete] *******************************
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j795838832370.56499', 'results_file': '/home/beatl/.ansible_async/j795838832370.56499', 'changed': True, 'item': {'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'wheel', 'container': 'docker'}, 'image': 'centos:7', 'name': 'centos_7', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']}, 'ansible_loop_var': 'item'})
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j982876238171.56525', 'results_file': '/home/beatl/.ansible_async/j982876238171.56525', 'changed': True, 'item': {'capabilities': ['SYS_ADMIN'], 'command': '/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'sudo', 'container': 'docker'}, 'image': 'python:3.8-slim-buster', 'name': 'debian_buster', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=7    changed=3    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0

INFO     Running centos_debian > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running centos_debian > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [debian_buster]
ok: [centos_7]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Create temp directory] *************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/home/beatl/mnt-homeworks/05/playbook/roles/vector-role/molecule/centos_debian/tmpd",
-    "state": "absent"
+    "state": "directory"
 }

changed: [centos_7]
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/home/beatl/mnt-homeworks/05/playbook/roles/vector-role/molecule/centos_debian/tmpd",
-    "state": "absent"
+    "state": "directory"
 }

changed: [debian_buster]

TASK [vector-role : Get vector distrib] ****************************************
changed: [centos_7]
changed: [debian_buster]

TASK [vector-role : Create root directory] *************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/home/beatl/mnt-homeworks/05/playbook/roles/vector-role/molecule/centos_debian/tmpd/vector-0.29.1",
-    "state": "absent"
+    "state": "directory"
 }

changed: [centos_7]
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/home/beatl/mnt-homeworks/05/playbook/roles/vector-role/molecule/centos_debian/tmpd/vector-0.29.1",
-    "state": "absent"
+    "state": "directory"
 }

changed: [debian_buster]

TASK [vector-role : Extract vector] ********************************************
changed: [debian_buster]
changed: [centos_7]

TASK [vector-role : Copy vector to bin with owner and permissions] *************
changed: [debian_buster]
changed: [centos_7]

TASK [vector-role : Configure vector.service from template] ********************
--- before
+++ after: /home/beatl/.ansible/tmp/ansible-local-57089222emba8/tmpwigqxqo6/vector.service.j2
@@ -0,0 +1,18 @@
+[Unit]
+Description=Vector
+Documentation=https://vector.dev
+After=network-online.target
+Requires=network-online.target
+
+[Service]
+User=root
+Group=0
+ExecStartPre=/usr/bin/vector validate --no-environment --config-yaml /home/beatl/mnt-homeworks/05/playbook/roles/vector-role/molecule/centos_debian/v_conf/vector.yml
+ExecStart=/usr/bin/vector --config-yaml /home/beatl/mnt-homeworks/05/playbook/roles/vector-role/molecule/centos_debian/v_conf/vector.yml --watch-config
+ExecReload=/usr/bin/vector validate --no-environment --config-yaml /home/beatl/mnt-homeworks/05/playbook/roles/vector-role/molecule/centos_debian/v_conf/vector.yml
+Restart=no
+AmbientCapabilities=CAP_NET_BIND_SERVICE
+EnvironmentFile=-/etc/default/vector
+
+[Install]
+WantedBy=multi-user.target
\ No newline at end of file

changed: [centos_7]
--- before
+++ after: /home/beatl/.ansible/tmp/ansible-local-57089222emba8/tmpioyc18u0/vector.service.j2
@@ -0,0 +1,18 @@
+[Unit]
+Description=Vector
+Documentation=https://vector.dev
+After=network-online.target
+Requires=network-online.target
+
+[Service]
+User=root
+Group=0
+ExecStartPre=/usr/bin/vector validate --no-environment --config-yaml /home/beatl/mnt-homeworks/05/playbook/roles/vector-role/molecule/centos_debian/v_conf/vector.yml
+ExecStart=/usr/bin/vector --config-yaml /home/beatl/mnt-homeworks/05/playbook/roles/vector-role/molecule/centos_debian/v_conf/vector.yml --watch-config
+ExecReload=/usr/bin/vector validate --no-environment --config-yaml /home/beatl/mnt-homeworks/05/playbook/roles/vector-role/molecule/centos_debian/v_conf/vector.yml
+Restart=no
+AmbientCapabilities=CAP_NET_BIND_SERVICE
+EnvironmentFile=-/etc/default/vector
+
+[Install]
+WantedBy=multi-user.target
\ No newline at end of file

changed: [debian_buster]

TASK [vector-role : Create config dir for vector] ******************************
--- before
+++ after
@@ -1,5 +1,5 @@
 {
-    "mode": "0755",
+    "mode": "0644",
     "path": "/home/beatl/mnt-homeworks/05/playbook/roles/vector-role/molecule/centos_debian/v_conf",
-    "state": "absent"
+    "state": "directory"
 }

changed: [centos_7]
--- before
+++ after
@@ -1,5 +1,5 @@
 {
-    "mode": "0755",
+    "mode": "0644",
     "path": "/home/beatl/mnt-homeworks/05/playbook/roles/vector-role/molecule/centos_debian/v_conf",
-    "state": "absent"
+    "state": "directory"
 }

changed: [debian_buster]

TASK [vector-role : Configure vector from template] ****************************
--- before
+++ after: /home/beatl/.ansible/tmp/ansible-local-57089222emba8/tmpiqloqsg3/vector.yml.j2
@@ -0,0 +1,20 @@
+data_dir: /var/lib/vector
+sinks:
+    to_clickhouse:
+        compression: gzip
+        database: logs
+        endpoint: http://127.0.0.1:8123
+        inputs:
+        - sample_file
+        skip_unknown_fields: true
+        table: local_log
+        type: clickhouse
+sources:
+    sample_file:
+        ignore_older_secs: 600
+        include:
+        - /var/log/**/*.log
+        read_from: beginning
+        type: file
+    vector_log:
+        type: internal_logs

changed: [centos_7]
--- before
+++ after: /home/beatl/.ansible/tmp/ansible-local-57089222emba8/tmpiun52zwk/vector.yml.j2
@@ -0,0 +1,20 @@
+data_dir: /var/lib/vector
+sinks:
+    to_clickhouse:
+        compression: gzip
+        database: logs
+        endpoint: http://127.0.0.1:8123
+        inputs:
+        - sample_file
+        skip_unknown_fields: true
+        table: local_log
+        type: clickhouse
+sources:
+    sample_file:
+        ignore_older_secs: 600
+        include:
+        - /var/log/**/*.log
+        read_from: beginning
+        type: file
+    vector_log:
+        type: internal_logs

changed: [debian_buster]

TASK [vector-role : Create data directory] *************************************
--- before
+++ after
@@ -1,5 +1,5 @@
 {
-    "mode": "0755",
+    "mode": "0777",
     "path": "/var/lib/vector",
-    "state": "absent"
+    "state": "directory"
 }

changed: [centos_7]
--- before
+++ after
@@ -1,5 +1,5 @@
 {
-    "mode": "0755",
+    "mode": "0777",
     "path": "/var/lib/vector",
-    "state": "absent"
+    "state": "directory"
 }

changed: [debian_buster]

TASK [vector-role : Flush handlers] ********************************************

TASK [vector-role : Flush handlers] ********************************************

RUNNING HANDLER [vector-role : Restart Vector service] *************************
changed: [debian_buster]
changed: [centos_7]

PLAY RECAP *********************************************************************
centos_7                   : ok=11   changed=10   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
debian_buster              : ok=11   changed=10   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running centos_debian > idempotence

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [debian_buster]
ok: [centos_7]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Create temp directory] *************************************
ok: [centos_7]
ok: [debian_buster]

TASK [vector-role : Get vector distrib] ****************************************
ok: [debian_buster]
ok: [centos_7]

TASK [vector-role : Create root directory] *************************************
ok: [centos_7]
ok: [debian_buster]

TASK [vector-role : Extract vector] ********************************************
ok: [debian_buster]
ok: [centos_7]

TASK [vector-role : Copy vector to bin with owner and permissions] *************
ok: [centos_7]
ok: [debian_buster]

TASK [vector-role : Configure vector.service from template] ********************
ok: [centos_7]
ok: [debian_buster]

TASK [vector-role : Create config dir for vector] ******************************
ok: [centos_7]
ok: [debian_buster]

TASK [vector-role : Configure vector from template] ****************************
ok: [centos_7]
ok: [debian_buster]

TASK [vector-role : Create data directory] *************************************
ok: [centos_7]
ok: [debian_buster]

TASK [vector-role : Flush handlers] ********************************************

TASK [vector-role : Flush handlers] ********************************************

PLAY RECAP *********************************************************************
centos_7                   : ok=10   changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
debian_buster              : ok=10   changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Idempotence completed successfully.
INFO     Running centos_debian > side_effect
WARNING  Skipping, side effect playbook not configured.
INFO     Running centos_debian > verify
INFO     Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Get Vector version] ******************************************************
ok: [debian_buster]
ok: [centos_7]

TASK [Assert Vector instalation] ***********************************************
ok: [centos_7] => {
    "changed": false,
    "msg": "All assertions passed"
}
ok: [debian_buster] => {
    "changed": false,
    "msg": "All assertions passed"
}

TASK [Validation Vector configuration] *****************************************
ok: [debian_buster]
ok: [centos_7]

TASK [Assert Vector validate config] *******************************************
ok: [centos_7] => {
    "changed": false,
    "msg": "All assertions passed"
}
ok: [debian_buster] => {
    "changed": false,
    "msg": "All assertions passed"
}

PLAY RECAP *********************************************************************
centos_7                   : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
debian_buster              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running centos_debian > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running centos_debian > destroy

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos_7)
changed: [localhost] => (item=debian_buster)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=centos_7)
changed: [localhost] => (item=debian_buster)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
```
</details>

---

###### Student
### Исполнитель

Сергей Жуков DevOps-32

---


