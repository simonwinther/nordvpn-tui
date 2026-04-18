# nordvpn-tui

A keyboard-first terminal UI for NordVPN on Linux. It wraps the official
`nordvpn` CLI so you can check status, quick connect, disconnect, pick a
country or city, and toggle core settings from one focused screen.

## Runtime dependency

`nordvpn-tui` is a front-end for the official NordVPN client. It requires:

- The `nordvpn` CLI on `$PATH` (provided by the NordVPN Linux package)
- The `nordvpnd` daemon running (`systemctl start nordvpnd`)

Install the NordVPN Linux client first: https://nordvpn.com/download/linux/

## Install

### Arch Linux (AUR)

```
yay -S nordvpn-tui-bin
```

Or with any AUR helper, or manually:

```
git clone https://aur.archlinux.org/nordvpn-tui-bin.git
cd nordvpn-tui-bin
makepkg -si
```

### Debian / Ubuntu (.deb)

Download the `.deb` from the [latest GitHub Release][releases] and install:

```
sudo dpkg -i nordvpn-tui_<version>_amd64.deb
```

### Tarball (any Linux)

Download the tarball for your architecture from the [latest GitHub Release][releases],
extract, and place the binary on your `$PATH`:

```
tar xf nordvpn-tui_<version>_linux_amd64.tar.gz
sudo install -m755 nordvpn-tui /usr/local/bin/
```

### Build from source

Requires Go 1.22+.

```
git clone https://github.com/simonwa01/nordvpn-tui.git
cd nordvpn-tui
make build
./bin/nordvpn-tui
```

[releases]: https://github.com/simonwa01/nordvpn-tui/releases

## Demo mode

Run without the real daemon to try the UI:

```
./bin/nordvpn-tui --fake
```

## Keymap

| Key                   | Action                                      |
| --------------------- | ------------------------------------------- |
| `1` `2` `3`           | Home / Countries / Settings                 |
| `enter`               | Primary action in the current view          |
| `c`                   | Quick connect                               |
| `d`                   | Disconnect                                  |
| `/`                   | Search (inline, Countries / Servers)        |
| `↑` `↓` / `k` `j`    | Move cursor                                 |
| `→` `l`               | Open cities for the focused country         |
| `←` `h` / `esc`       | Back / clear search                         |
| `?`                   | Toggle help overlay                         |
| `L`                   | Open activity log                           |
| `q` / `ctrl-c`        | Quit                                        |

## Architecture

```
UI (Bubble Tea) <-> Store (pure reducers) <-> VPN service (exec wrapper)
                                                     |
                                                     v
                                                `nordvpn` CLI
```

- `internal/vpn/`: CLI wrapper, parsers, typed errors, fake client.
- `internal/state/`: single `AppState` struct, no ad-hoc mutation.
- `internal/app/`: Bubble Tea root model, messages, key dispatch, router.
- `internal/theme/`: palette and named Lip Gloss styles.
- `internal/views/`: per-view render functions, each pure.

Parsers live in one place. The UI never inspects raw CLI output.

## Repo analytics

![Alt](https://repobeats.axiom.co/api/embed/dd83797db25f0a94ec0fc87a174cd6bc2001a215.svg "Repobeats analytics image")

## License

MIT, see [LICENSE](LICENSE).
