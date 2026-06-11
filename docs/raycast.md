# Raycast

Captured safely:

- Raycast cask in `Brewfile`
- Selected defaults in `scripts/raycast-defaults.sh`
- Installed extension inventory below

Excluded:

- `~/Library/Application Support/com.raycast.macos/raycast-enc.sqlite`
- `raycast-activities-enc.sqlite`
- Extension caches and local Application Support files
- analytics identifiers
- account/session state

Raycast stores meaningful configuration in encrypted local databases and account sync. Copying those files into dotfiles would be brittle and would risk private data.

## Selected Defaults

Observed on this Mac:

- Global hotkey: `Command-49`
- Preferred window mode: `compact`
- Follow system appearance: enabled
- Raycast menu bar icon: hidden
- Hyper Key icon: enabled
- Hyper Key state: enabled, include Shift, key code `57`
- Active subscription flag: disabled

Apply:

```sh
./scripts/raycast-defaults.sh
```

Restart Raycast afterwards.

## Extensions

Installed extension inventory from `~/.config/raycast/extensions`:

| Extension | Author | Package |
| --- | --- | --- |
| 1Password | khasbilegt | `1password` |
| Apple Intelligence | EvanZhouDev | `raycast-apple-intelligence` |
| ArXiv Search | koayon | `arxiv` |
| Brew | nhojb | `brew` |
| Coffee | mooxl | `coffee` |
| Color Picker | thomas | `color-picker` |
| Image Modification | HelloImSteven | `sips` |
| ImageOptim | marckohlbrugge | `imageoptim` |
| Kill Process | rolandleth | `kill-process` |
| Media Converter | leandro.maia | `media-converter` |
| Model Context Protocol Registry | thomas | `model-context-protocol-registry` |
| Port Manager | lucaschultz | `port-manager` |
| Raycast Wallpaper | koinzhang | `raycast-wallpaper` |
| Screen Saver | koinzhang | `screen-saver` |
| Search npm Packages | mrmartineau | `search-npm` |
| Set Audio Device | benvp | `audio-device` |
| TinyPNG | kawamataryo | `tinypng` |
| YAFW | pablopunk | `yafw` |
| shadcn/ui | luisFilipePT | `shadcn-ui` |

Reinstall manually through Raycast Store or these URLs:

```text
https://www.raycast.com/khasbilegt/1password
https://www.raycast.com/EvanZhouDev/raycast-apple-intelligence
https://www.raycast.com/koayon/arxiv
https://www.raycast.com/nhojb/brew
https://www.raycast.com/mooxl/coffee
https://www.raycast.com/thomas/color-picker
https://www.raycast.com/HelloImSteven/sips
https://www.raycast.com/marckohlbrugge/imageoptim
https://www.raycast.com/rolandleth/kill-process
https://www.raycast.com/leandro.maia/media-converter
https://www.raycast.com/thomas/model-context-protocol-registry
https://www.raycast.com/lucaschultz/port-manager
https://www.raycast.com/koinzhang/raycast-wallpaper
https://www.raycast.com/koinzhang/screen-saver
https://www.raycast.com/mrmartineau/search-npm
https://www.raycast.com/benvp/audio-device
https://www.raycast.com/kawamataryo/tinypng
https://www.raycast.com/pablopunk/yafw
https://www.raycast.com/luisFilipePT/shadcn-ui
```

