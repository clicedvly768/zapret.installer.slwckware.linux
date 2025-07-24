Чтобы установить Zapret на Slackware Linux, выполните следующие шаги. Проект предоставляет установщик для систем без systemd (используется SysVinit), что подходит для Slackware.

### 1. Установите зависимости
Откройте терминал и установите необходимые пакеты:
```bash
# Обновите репозитории
sudo slackpkg update

# Установите зависимости
sudo slackpkg install git ipset iptables curl openssl
```

### 2. Клонируйте репозиторий
```bash
git clone https://github.com/Snowy-Fluffy/zapret.installer
cd zapret.installer
```

### 3. Запустите установщик для SysVinit
Slackware использует SysVinit, поэтому укажите параметр `sysv`:
```bash
sudo ./install.sh sysv
```
Установщик:
- Скопирует файлы в `/opt/zapret`.
- Добавит скрипт инициализации `/etc/init.d/zapret`.
- Настроит автозапуск через `rc.local`.

### 4. Настройте автозапуск (если не добавлено автоматически)
Проверьте, есть ли запись в `/etc/rc.d/rc.local`:
```bash
sudo nano /etc/rc.d/rc.local
```
Добавьте строку, если её нет:
```bash
[ -x /etc/init.d/zapret ] && /etc/init.d/zapret start
```
Сделайте скрипт исполняемым:
```bash
sudo chmod +x /etc/rc.d/rc.local
```

### 5. Настройте Zapret
Отредактируйте конфиг:
```bash
sudo nano /opt/zapret/config
```
Основные параметры (измените по необходимости):
```ini
MODE=ipset        # Режим работы (ipset, nft, tpws)
TPWS_EXE=tpws     # Использовать tpws для обхода
ALLOW_SSH=1       # Не блокировать SSH-доступ
DNS="8.8.8.8"     # DNS-сервер для обхода блокировок
```

### 6. Запустите службу
```bash
sudo /etc/init.d/zapret start
```

### 7. Проверьте работу
```bash
sudo /etc/init.d/zapret status
curl -v https://example.com  # Проверьте доступ к заблокированным ресурсам
```

### Дополнительно:
- **Обновление**: 
  ```bash
  cd zapret.installer
  git pull
  sudo ./install.sh sysv
  ```
- **Удаление**:
  ```bash
  sudo ./install.sh remove
  sudo rm -rf /opt/zapret /etc/init.d/zapret
  ```
- **Логи**: `/var/log/zapret.log`

### Решение проблем:
1. **Ошибки зависимостей**: Убедитесь, что установлены `ipset`, `iptables`, `openssl`.
2. **Скрипт не запускается**: Проверьте права:
   ```bash
   sudo chmod +x /etc/init.d/zapret
   ```
3. **Проблемы с DNS**: В конфиге укажите рабочие DNS (например, Cloudflare `1.1.1.1`).
4. **Поддержка IPv6**: Добавьте в конфиг:
   ```ini
   IPV6=1
   ```

Если установщик работает некорректно, используйте ручную установку:
```bash
# Скопируйте файлы
sudo cp -r dist /opt/zapret
# Возьмите скрипт SysV из репозитория
sudo cp init.d/zapret.sysv /etc/init.d/zapret
```
