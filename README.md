# PicoPrint

Print from Windows to the **LX-D02** Bluetooth thermal mini printer, the one
that normally works only with the *Funny Print* phone app.

PicoPrint adds the LX-D02 as a regular Windows printer. You can then print from
any program (Word, the browser, the photo viewer) with **Ctrl+P**.

> Free and open source. Not affiliated with the printer manufacturer or with the
> Funny Print app.

*Italiano più sotto.*

## Status

Early but working. Tested on Windows 11 with an LX-D02. Text, images and
documents print through the Windows print dialog.

Planned work:

- [ ] tray app with printer status, battery and paper alerts, and auto-reconnect
- [ ] one-click installer
- [ ] friendly paper size names (continuous roll / labels)

## Requirements

- Windows 10 or 11 with Bluetooth 4.0 or later (Bluetooth LE). A cheap USB
  dongle works too.
- An LX-D02 printer. **Do not pair it** in Windows Bluetooth settings, because
  PicoPrint connects to it directly.
- To build from source: [Go](https://go.dev/dl/) 1.25 or later.

## Quick start (for now)

```powershell
git clone https://github.com/bigtower17/picoprint
cd picoprint
go build -o tp.exe ./cmd/tp

# 1. start the print server (keep the printer on and close the phone app)
.\scripts\start-server.ps1

# 2. add "LX-D02 Termica" as a Windows printer (asks for admin once)
Start-Process powershell -Verb RunAs -ArgumentList '-ExecutionPolicy','Bypass','-File',"$PWD\scripts\install-printer.ps1"
```

Then print from any app, choosing **LX-D02 Termica**.

Command line printing works too:

```powershell
"Hello!" | .\tp.exe text -
.\tp.exe image photo.jpg
```

## How it works

```
Any Windows app ─Ctrl+P─▶ Windows (IPP class driver) ─PWG raster─▶ tp server (127.0.0.1:6310) ─BLE─▶ LX-D02
```

## What PicoPrint changes compared with thermoprint

- **LX-D02 authentication ("app check")**. Without it, some printers silently
  ignore all print data. See [doc/lx-d02-app-check.md](doc/lx-d02-app-check.md).
- **Windows compatibility of the IPP server**. Printer attributes are now sent
  in the IPP printer-attributes group, which Windows requires, plus a few
  attributes Windows asks for. Windows can now install the printer with its
  built-in driver.

## Credits

PicoPrint stands on the shoulders of:

- **[@rusq](https://github.com/rusq)**, [thermoprint](https://github.com/rusq/thermoprint):
  the LX-D02 driver, rasteriser and IPP server PicoPrint is built on (MIT).
  The original README is in [doc/THERMOPRINT_README.md](doc/THERMOPRINT_README.md).
- **[@big-vl](https://github.com/big-vl)**, [catcombo](https://github.com/big-vl/catcombo):
  the original LX-D02 protocol research.
- **[@morluto](https://github.com/morluto)**, [REA](https://github.com/morluto/rea):
  "Reverse engineer anything", used to analyse the Android app.
- **[P1 Security](https://github.com/P1sec)**, [hermes-dec](https://github.com/P1sec/hermes-dec):
  React Native Hermes bytecode decompiler.

## License

MIT. See [LICENSE](LICENSE).

The protocol was studied for interoperability purposes only. No code from the
original app is included.

---

## Italiano

**PicoPrint** permette di usare la stampantina termica Bluetooth **LX-D02**
(quella dell'app *Funny Print*) come una normale stampante di Windows, per
stampare da qualsiasi programma con **Ctrl+P**. È gratuito e open source.

Per ora l'installazione richiede qualche passaggio manuale (vedi *Quick start*
sopra). Sono in arrivo un installer con un clic e un'icona nell'area di
notifica, con stato della stampante e riconnessione automatica.

Non associare la stampante dalle impostazioni Bluetooth di Windows: PicoPrint
si collega da solo. Prima di stampare dal PC chiudi l'app sul telefono.
