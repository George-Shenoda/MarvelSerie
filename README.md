# Marvel Chroniverse — Mobile App (Android `.apk` & iOS `.ipa`)

A Marvel-style chronological watchlist app covering **MCU Sacred Timeline**, **Netflix Defenders**, **Fox X-Men**, **Sony Spider-Verse**, **Legacy Multiverse**, and a **Non-Canon Vault**, built with **Capacitor** and automated via **GitHub Actions**.

## 1. Set Up Your Permanent Signing Key (One-Time Step)
To ensure **every future `.apk` update upgrades in-place without deleting your old app or watchlist data**, generate your permanent keystore signed with `CN=Shnwnw` once:

```bash
./scripts/generate-android-keystore.sh
```

Then open your GitHub repository → **Settings → Secrets and variables → Actions → New repository secret** and add:
- `ANDROID_KEYSTORE_BASE64` — the base64 string printed by the script
- `ANDROID_KEYSTORE_ALIAS` — `shnwnw-release-key`
- `ANDROID_KEYSTORE_PASSWORD` — your chosen password
- `ANDROID_KEY_PASSWORD` — your chosen password

> **Important:** Keep `marvel-chroniverse-shnwnw.jks` backed up safely and never commit it to git (`.gitignore` already excludes `*.jks`).

## 2. Build & Publish `.apk` + `.ipa` to GitHub Releases
You can trigger a release in either of two ways:
1. **Push a version tag:**
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```
2. **Manual trigger from GitHub:** Go to **Actions → Build & Release Android (.apk) + iOS (.ipa) → Run workflow**, enter a version tag (e.g. `v1.0.1`), and click **Run workflow**.

GitHub Actions will automatically build both `Marvel-Chroniverse-vX.Y.Z.apk` and `Marvel-Chroniverse-vX.Y.Z.ipa`, generate release notes + SHA-256 checksums, and publish them on your repository's **Releases** page.
