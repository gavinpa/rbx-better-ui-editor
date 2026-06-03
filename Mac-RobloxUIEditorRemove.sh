#!/usr/bin/env bash
# Removes the bundled UIEditor.rbxm plugin from RobloxStudio.app
# Re-run after every Roblox Studio update (the file gets restored).
# Built specifically for MacOS, before using, you'll need to make the file an executable:
#   1. Set the working directory to the folder the "Mac-RobloxUIEditorRemove.sh" file is in
#   2. Run this command: "chmod +x ./Mac-RobloxUIEditorRemove.sh"
#   3. That's it! You can now run the script. Note: You'll be prompted for sudo priviledges so the built-in UI editor can be removed.

set -euo pipefail

TargetFile="/Applications/RobloxStudio.app/Contents/Resources/BuiltInPlugins/Optimized_Embedded_Signature/UIEditor.rbxm"

if [[ ! -e "$TargetFile" ]]; then
    echo "Already gone: $TargetFile"
    exit 0
fi

# /Applications is root-owned, so elevate if we aren't already.
if [[ $EUID -ne 0 ]]; then
    echo "Requesting sudo to remove $TargetFile"
    exec sudo "$0" "$@"
fi

rm -f "$TargetFile"
echo "Removed: $TargetFile"
