# Apps

`Brewfile` captures Homebrew-managed formulae, casks, and fonts from this Mac.

These apps are present in `/Applications` but were not installed as Homebrew casks on the oracle machine. They may come from the App Store, MDM/Jamf, direct downloads, vendor installers, or licenses that should be handled manually.

Homebrew also installs `mas`, so personal App Store apps can be restored with:

```sh
./scripts/app-store-apps.sh --dry-run
```

Run without `--dry-run` after signing into the Mac App Store. The script intentionally includes Apple personal apps only and leaves work-managed Microsoft, MDM, and vendor apps manual.

| App | Notes |
| --- | --- |
| Authen.app | direct or vendor-managed |
| Claude.app | direct install on oracle |
| CleanShot X.app | licensed direct install on oracle |
| Clicky.app | direct or vendor-managed |
| Codex.app | direct install on oracle |
| Company Portal.app | MDM/work-managed |
| Dia.app | direct install on oracle |
| GarageBand.app | App Store/Apple |
| Jamf Connect.app | MDM/work-managed |
| Keynote.app | App Store/Apple |
| Klack.app | direct or App Store |
| Microsoft Defender.app | MDM/work-managed |
| Microsoft Excel.app | Office/App Store/MDM |
| Microsoft OneNote.app | Office/App Store/MDM |
| Microsoft Outlook.app | Office/App Store/MDM |
| Microsoft PowerPoint.app | Office/App Store/MDM |
| Microsoft Teams.app | direct or MDM |
| Microsoft Word.app | Office/App Store/MDM |
| Mirage Host.app | vendor-managed |
| NTE.app | vendor-managed |
| Numbers.app | App Store/Apple |
| OneDrive.app | Microsoft installer/MDM |
| Pages.app | App Store/Apple |
| Paper.app | direct install on oracle |
| Power Monitor.app | vendor-managed |
| Readout.app | direct or App Store |
| Safari.app | macOS built-in |
| Webex.app | direct or MDM |
| Xcode.app | App Store/Apple Developer |
| iMovie.app | App Store/Apple |

Do not add work-managed apps to `Brewfile` unless you explicitly want Homebrew to own them on personal machines.
