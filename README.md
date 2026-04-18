# nordvpn-tui

A keyboard-first terminal UI for NordVPN on Linux. Wraps the official `nordvpn`
CLI and gives you the five things you actually do every day — see status, quick
connect, disconnect, pick a country/city, toggle core settings — on one clean,
focused screen.

## Install

```
go build -o bin/nordvpn-tui ./cmd/nordvpn-tui
./bin/nordvpn-tui
```

Requirements: Linux, Go 1.22+, the NordVPN CLI on `$PATH`, and the `nordvpnd`
daemon running.

Demo without the real daemon:

```
./bin/nordvpn-tui --fake
```

## Keymap

| Key           | Action                                          |
| ------------- | ----------------------------------------------- |
| `1` `2` `3`   | Home / Countries / Settings                     |
| `enter`       | Primary action in the current view              |
| `c`           | Quick connect                                   |
| `d`           | Disconnect                                      |
| `/`           | Search (inline, Countries / Servers)            |
| `↑` `↓` / `k` `j` | Move cursor                                 |
| `→` `l`       | Open cities for the focused country             |
| `←` `h` / `esc`   | Back / clear search                         |
| `?`           | Toggle help overlay                             |
| `L`           | Open activity log                               |
| `q` / `ctrl-c`| Quit                                            |

## Manual test matrix

- [ ] Disconnected start — Home shows "Disconnected", primary CTA is Quick Connect.
- [ ] `c` connects and the hero flips to "Connected" with country/city/IP.
- [ ] `2` enters Countries; `/` filters; `enter` connects to a country.
- [ ] `→` opens cities for the focused country; `enter` connects to city.
- [ ] `3` enters Settings; toggling each bool updates its row; Technology cycles NordLynx/OpenVPN.
- [ ] Kill Switch toggle shows a confirm prompt; `n` cancels, `y` applies.
- [ ] `d` disconnects; Kill Switch warning is surfaced when relevant.
- [ ] Logged-out: Home shows login CTA pointing at `nordvpn login`.
- [ ] Daemon down: full-screen banner with systemctl hint.
- [ ] Binary missing: full-screen banner on startup.
- [ ] Resize to 80×24, 100×30, 140×40 — no layout breakage.
- [ ] `NO_COLOR=1` and `TERM=xterm` — still legible.

## Architecture

```
UI (Bubble Tea)  ↔  Store (pure reducers)  ↔  VPN service (exec wrapper)
                                                    │
                                                    ▼
                                               `nordvpn` CLI
```

- `internal/vpn/`   — CLI wrapper, parsers, typed errors, fake client.
- `internal/state/` — single `AppState` struct, no ad-hoc mutation.
- `internal/app/`   — Bubble Tea root model, messages, key dispatch, router.
- `internal/theme/` — palette and named Lip Gloss styles.
- `internal/views/` — per-view render functions, each pure.

Parsers live in one place. The UI never inspects raw CLI output.

## License

MIT (TBD).
