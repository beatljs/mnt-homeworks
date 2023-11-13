
---
<img src="Netology.png" height="24px"/>

### Учебная группа DevOps-32

---

## Решение по домашнему заданию 10-monitoring-04-elk к занятию 15 «Система сбора логов Elastic Stack» 


- [Описание](#description)
- [Cкриншоты](#screenshots)
- [Файлы](#files)
- [Исполнитель](#student)

---

###### Description
### Описание

При выполнении домашнего задания использовались манифест `docker-compose` и конфигурации `filebeat/logstash` из директории [help](https://github.com/netology-code/mnt-homeworks/tree/MNT-video/10-monitoring-04-elk/help) к домашнему заданию.

Домашнее задание выполнялось в `docker` на локальной машине.

---

###### screenshots
### Cкриншоты

<details>
    <summary> Cкриншот `docker ps`...  </summary>

![](./screenshots/docker.png)

</details>

<details>
    <summary> Интерфейс Kibana - Index Management...  </summary>

![](./screenshots/im.png)

</details>

<details>
    <summary> Интерфейс Kibana - Index pattern...  </summary>

![](./screenshots/ip.png)

</details>

<details>
    <summary> Интерфейс Kibana - Discover (отфильтровано по `message` и `container.name`)...  </summary>

![](./screenshots/kibana.png)

</details>

---

###### files
### Файлы (использованы из директории `help` в неизменном виде)

[docker-compose манифест](./docker-compose.yml)

[logstash.conf](./configs/logstash.conf)

[logstash.yml](./configs/logstash.yml)

[filebeat.yml](./configs/filebeat.yml)

---

###### Student
### Исполнитель

Сергей Жуков DevOps-32

---