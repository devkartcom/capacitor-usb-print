# @devkartcom/capacitor-usb-print

Capacitor plugin that sends raw printer bytes (ESC/POS etc.) to a USB receipt printer
on **Android**. iOS and web reject every call with the code `NOT_SUPPORTED`.

```ts
import { UsbPrint } from '@devkartcom/capacitor-usb-print';

const { printers } = await UsbPrint.listPrinters();
// [{ deviceId: '0416:5011', name: 'POS58 VID:0416 PID:5011 ...', connected: false }]

await UsbPrint.connectPrinter({ deviceId: printers[0].deviceId });
await UsbPrint.printRaw({ data: btoa(String.fromCharCode(...escposBytes)) });
```

## API

| Method | Returns | Notes |
|---|---|---|
| `listPrinters()` | `{ printers: { deviceId, name, connected }[] }` | Every attached USB device. `deviceId` is `VID:PID` in hex, so it survives a re-plug. |
| `connectPrinter({ deviceId })` | `{ connected }` | Asks Android for USB permission the first time. |
| `disconnectPrinter()` | `{ connected }` | |
| `printRaw({ data })` | `{ success }` | `data` is the raw bytes, base64-encoded. |
| `getStatus()` | `{ connected, printerName }` | |
| `printReceipt({ receipt })` | `{ success }` | Kept for older kiosk builds. New code uses `printRaw`. |

## Printer selection

A `deviceId` that matches a device's `VID:PID` exactly always wins. Otherwise the plugin
falls back to the first device with a USB printer-class interface, but **never to a Star
Micronics printer** (vendor `0519`): those go through the StarXpand path, and their
graphics-only models discard raw text while still reporting success. Assign a Star printer
explicitly by its `VID:PID` if you really want it here.

## Install

The package is installed from a git tag; `dist/` is committed so no build step runs on
install.

```sh
npm i github:devkartcom/capacitor-usb-print#v0.1.2
npx cap sync android
```

Peer dependency: `@capacitor/core >= 8.0.0`.

## About Devkart

Built and maintained by [Devkart Technologies LLP](https://devkart.com): custom software,
SaaS platforms and MVPs. We run this plugin in production in our own two products:

- **[Supaorder](https://www.supaorder.com)**: white-label online ordering for restaurants.
  Orders go straight into Clover, Square or Toast, and restaurants pay a flat monthly fee
  instead of a commission.
- **[SuperApp](https://www.superapphq.com)**: a white-label multi-vertical marketplace
  platform for food delivery, retail and supermarkets.

Questions or issues: open a GitHub issue, or write to contact@devkart.com.

## License

MIT © Devkart Technologies LLP
