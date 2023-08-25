# Домашнее задание к занятию 1 «Введение в Ansible»

## Подготовка к выполнению

1. Установите Ansible версии 2.10 или выше.

```
beatl@OWEN:~$ ansible --version
ansible [core 2.15.3]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/beatl/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /home/beatl/.local/lib/python3.9/site-packages/ansible
  ansible collection location = /home/beatl/.ansible/collections:/usr/share/ansible/collections
  executable location = /home/beatl/.local/bin/ansible
  python version = 3.9.1 (default, Jul  6 2022, 23:56:07) [GCC 8.3.0] (/usr/local/bin/python3)
  jinja version = 3.1.2
  libyaml = True
```

## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.

```
TASK [Print fact] ******************************************************************************************************
ok: [localhost] => {
    "msg": 12
}
```

2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.

```
TASK [Print fact] ******************************************************************************************************
ok: [localhost] => {
    "msg": "all_default_facts"
}
```

3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.
4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.

```
beatl@OWEN:~/mnt-homeworks/01/playbook$ ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [debian]
ok: [centos]

TASK [Print OS] ********************************************************************************************************
ok: [centos] => {
    "msg": "CentOS"
}
ok: [debian] => {
    "msg": "Debian"
}

TASK [Print fact] ******************************************************************************************************
ok: [centos] => {
    "msg": "el"
}
ok: [debian] => {
    "msg": "deb"
}

PLAY RECAP *************************************************************************************************************
centos                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
debian                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.

_Для этого меняем значения some_fact соответствующих файлах examp.yml каталога group_vars_

```
                    ----- Skip -----
TASK [Print fact] ******************************************************************************************************
ok: [centos] => {
    "msg": "el default fact"
}
ok: [debian] => {
    "msg": "deb default fact"
}
                    ----- Skip -----
```

6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.

_Файл prod.yml_

```
---
  el:
    hosts:
      centos:
        ansible_connection: docker
  deb:
    hosts:
      debian:
        ansible_connection: docker
```

_Вывод Ansible_

```
beatl@OWEN:~/mnt-homeworks/01/playbook$ ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [debian]
ok: [centos]

TASK [Print OS] ********************************************************************************************************
ok: [centos] => {
    "msg": "CentOS"
}
ok: [debian] => {
    "msg": "Debian"
}

TASK [Print fact] ******************************************************************************************************
ok: [centos] => {
    "msg": "el default fact"
}
ok: [debian] => {
    "msg": "deb default fact"
}

PLAY RECAP *************************************************************************************************************
centos                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
debian                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.

```
beatl@OWEN:~/mnt-homeworks/01/playbook$ ansible-vault encrypt group_vars/deb/examp.yml
New Vault password: 
Confirm New Vault password: 
Encryption successful
beatl@OWEN:~/mnt-homeworks/01/playbook$ ansible-vault encrypt group_vars/el/examp.yml
New Vault password: 
Confirm New Vault password: 
Encryption successful
```

8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.

```
beatl@OWEN:~/mnt-homeworks/01/playbook$ ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] **************************************************************************************************
ERROR! Attempting to decrypt but no vault secrets found
```

```
beatl@OWEN:~/mnt-homeworks/01/playbook$ ansible-playbook --ask-vault-pass -i inventory/prod.yml site.yml
Vault password: 

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
                    ----- Skip -----
```

9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.

```
beatl@OWEN:~/mnt-homeworks/01/playbook$ ansible-doc -l -t connection
ansible.builtin.local        execute on controller                                                                                                                                                                             
ansible.builtin.paramiko_ssh Run tasks via python ssh (paramiko)                                                                                                                                                               
ansible.builtin.psrp         Run tasks over Microsoft PowerShell Remoting Protocol                                                                                                                                             
ansible.builtin.ssh          connect via SSH client binary                                                                                                                                                                     
ansible.builtin.winrm        Run tasks over Microsoft's WinRM                                                                                                                                                                  
community.docker.docker      Run tasks in docker containers                                                                                                                                                                    
community.docker.docker_api  Run tasks in docker containers                                                                                                                                                                    
community.docker.nsenter     execute on host running controller container  
```

_Для работы на control node лучше использовать ansible.builtin.local_

10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.

_Файл prod.yml_

```
  el:
    hosts:
      centos:
        ansible_connection: docker
  deb:
    hosts:
      debian:
        ansible_connection: docker
  local:
    hosts:
      localhost:
        ansible_connection: local
```


11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.


_Вывод Ansible_

```
beatl@OWEN:~/mnt-homeworks/01/playbook$ ansible-playbook --ask-vault-pass -i inventory/prod.yml site.yml
Vault password: 

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]
ok: [debian]
ok: [centos]

TASK [Print OS] ********************************************************************************************************
ok: [centos] => {
    "msg": "CentOS"
}
ok: [debian] => {
    "msg": "Debian"
}
ok: [localhost] => {
    "msg": "Debian"
}

TASK [Print fact] ******************************************************************************************************
ok: [centos] => {
    "msg": "el default fact"
}
ok: [debian] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "all_default_facts"
}

PLAY RECAP *************************************************************************************************************
centos                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
debian                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.

```
beatl@OWEN:~/mnt-homeworks/01/playbook$ ansible-vault decrypt group_vars/deb/examp.yml
Vault password: 
Decryption successful
beatl@OWEN:~/mnt-homeworks/01/playbook$ ansible-vault decrypt group_vars/el/examp.yml
Vault password: 
Decryption successful
```

2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.

```
beatl@OWEN:~/mnt-homeworks/01/playbook$ ansible-vault encrypt_string PaSSw0rd
New Vault password: 
Confirm New Vault password: 
Encryption successful
!vault |
          $ANSIBLE_VAULT;1.1;AES256
          37613866653130636234303130386465396631653638656365356131363631306533633764363735
          3435386437333363363235623330623962396464306665610a373464366666366332613366323361
          34303834666432396565366264346431623031353236396237356165303839653638303837613764
          3833393766316365320a343662643865623137643030323837393831303964343034643435656330
          3663
```

3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.

```
                    ----- Skip -----
TASK [Print fact] ******************************************************************************************************
ok: [centos] => {
    "msg": "el default fact"
}
ok: [debian] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "PaSSw0rd"
}
                    ----- Skip -----
```

4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот вариант](https://hub.docker.com/r/pycontribs/fedora).

```
beatl@OWEN:~/mnt-homeworks/01/playbook$ ansible-playbook --ask-vault-pass -i inventory/prod.yml site.yml
Vault password: 

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]
ok: [debian]
ok: [fedora]
ok: [centos]

TASK [Print OS] ********************************************************************************************************
ok: [centos] => {
    "msg": "CentOS"
}
ok: [debian] => {
    "msg": "Debian"
}
ok: [fedora] => {
    "msg": "Fedora"
}
ok: [localhost] => {
    "msg": "Debian"
}

TASK [Print fact] ******************************************************************************************************
ok: [centos] => {
    "msg": "el default fact"
}
ok: [debian] => {
    "msg": "deb default fact"
}
ok: [fedora] => {
    "msg": "fedora ivanovna"
}
ok: [localhost] => {
    "msg": "PaSSw0rd"
}

PLAY RECAP *************************************************************************************************************
centos                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
debian                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
fedora                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```

5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.

_my_scipt.sh_
```
#!/bin/bash

dock_img=("centos" "debian" "fedora")

for c_name in "${dock_img[@]}"; do
  res=$( docker container inspect -f '{{.State.Running}}' "$c_name" )
  echo Res is "$res"
  if [ "$( docker container inspect -f '{{.State.Running}}' "$c_name" )" = "true" ]; then
    echo "Container $c_name is found"
  else
    echo "Starting container $c_name"
    docker run -dt --name "$c_name" "$c_name"
  fi
done

ansible-playbook --ask-vault-pass -i inventory/prod.yml site.yml

docker stop $(docker ps -q)
docker rm $(docker ps -aq)
```

---
