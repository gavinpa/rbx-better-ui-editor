# Better UI Editor

A faster, friendlier replacement for Roblox Studio's built-in UI editor — with grid snapping,
sibling/spacing snapping, align & distribute, quick actions, distance lines, and a configurable
settings editor.

---

## ⚠️ Remove Roblox's built-in UI editor first

Studio ships its UI editor as a single bundled plugin file, **`UIEditor.rbxm`**, inside the Studio
install. If you leave it in place, its selection box, resize handles, and yellow overlays draw on
top of Better UI Editor's and get in the way. Deleting that one file disables the built-in editor
cleanly — nothing else in Studio is affected.

> **Heads up:** Roblox **restores this file on every Studio update.** Re-run the removal after each
> update (the scripts below make this a one-liner).

### Where the file lives

| OS | Path |
| --- | --- |
| **macOS** | `/Applications/RobloxStudio.app/Contents/Resources/BuiltInPlugins/Optimized_Embedded_Signature/UIEditor.rbxm` |
| **Windows** | `%LOCALAPPDATA%\Roblox\Versions\<version>\BuiltInPlugins\UIEditor.rbxm` |

On Windows there's one folder per installed version under `Versions`, so the file may exist in more
than one `<version>\BuiltInPlugins\` folder — delete it from each.

**Close Roblox Studio before removing the file, then reopen it.**

### Option A — one-line scripts (recommended)

Save and run one of the scripts included in this repo. Each one finds the file, elevates if needed,
deletes it, and is safe to re-run (it just says "already gone" if the file isn't there).

**macOS / Linux (bash):**

```bash
chmod +x ClearRobloxUIEditor.sh
./ClearRobloxUIEditor.sh        # prompts for sudo to remove the root-owned file
```

**Windows / macOS (PowerShell 7+):**

```powershell
pwsh ./ClearRobloxUIEditor.ps1
```

### Option B — delete it manually

**macOS** (requires admin — the app bundle is root-owned):

```bash
sudo rm -f "/Applications/RobloxStudio.app/Contents/Resources/BuiltInPlugins/Optimized_Embedded_Signature/UIEditor.rbxm"
```

**Windows** (PowerShell — removes it from every installed version):

```powershell
Get-ChildItem "$env:LOCALAPPDATA\Roblox\Versions" -Recurse -Filter UIEditor.rbxm |
  Where-Object FullName -match '\\BuiltInPlugins\\' |
  Remove-Item -Force
```

Reopen Studio, select a GUI element, and you should now see **only** Better UI Editor's adornments.

---

## Usage tips

- **Drag** a selected element to move it; release on a snap guide to align to edges, centers, or
  matched sibling spacing.
- **Hold `Ctrl`** while dragging to disable snapping.
- **Hold `Alt`** while dragging to snap the position to a configurable pixel grid.
- **Hold `Alt`** while resizing to scale from the center (all sides at once).
- **Hold `Shift`** while resizing to lock the aspect ratio.
- **`Ctrl` + Arrow keys** nudge the selection (scale-aware).
- Click the **Config** toolbar button to edit settings (snap threshold, grid size, colors, quick
  actions, and more).
