# 🗄️ Administration MySQL – Sécurité, sauvegarde et supervision

![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?logo=mysql&logoColor=white)
![Grafana](https://img.shields.io/badge/Grafana-dashboard-F46800?logo=grafana&logoColor=white)
![Prometheus](https://img.shields.io/badge/Alertmanager-alertes-E6522C?logo=prometheus&logoColor=white)

Projet d'**administration de bases de données** (Bachelor 3, Ynov Campus) : sécuriser, sauvegarder et superviser
un serveur MySQL 8.

## 🔐 Sécurité

- **Gestion des utilisateurs et des rôles** (`sql/01_utilisateurs_et_roles.sql`) : comptes dédiés par usage,
  principe du moindre privilège, privilèges accordés par rôle.
- **Chiffrement de colonnes sensibles** (`sql/02_chiffrement_aes.sql`) : fonctions `AES_ENCRYPT` / `AES_DECRYPT`
  pour protéger les données personnelles (ex. numéros de téléphone).
- **Identifiants hors du code** : les scripts lisent les accès dans `~/.my.cnf` (modèle : `my.cnf.example`).

## 💾 Sauvegarde

- `scripts/backup_incremental.sh` : stratégie **incrémentale par binary logs**, avec purge automatique
  des journaux de plus de 7 jours et contrôle du code de retour.

## 📊 Supervision

- `monitoring/grafana_dashboard.json` : tableau de bord **Grafana** branché sur MySQL
  (connexions actives, connexions max, requêtes par seconde via `performance_schema`).
- `monitoring/alertmanager.yml` : routage des alertes **Alertmanager** (regroupement, répétition, inhibition
  des alertes `warning` quand une alerte `critical` est active).

## ▶️ Utilisation

```bash
cp my.cnf.example ~/.my.cnf && chmod 600 ~/.my.cnf     # renseigner vos identifiants
mysql < sql/01_utilisateurs_et_roles.sql               # remplacer d'abord les <mot_de_passe_fort>
mysql < sql/02_chiffrement_aes.sql                     # définir votre propre clé AES
bash scripts/backup_incremental.sh
```

Le tableau de bord s'importe dans Grafana via **Dashboards → Import → Upload JSON file**.

> Les mots de passe et la clé de chiffrement d'origine ont été remplacés par des valeurs d'exemple.

## 🛠️ Compétences

`MySQL 8` · `sécurité des données` · `RBAC` · `chiffrement AES` · `sauvegarde incrémentale` · `Grafana` · `Alertmanager`

---
Khadija Ibisk – Bachelor Dev IA & Data Engineering, Ynov Campus
