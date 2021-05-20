# cat update.sh
set -xe

readonly app_root="/data/app"
readonly updater_root="/data/media/0/Android/data/com.lyricspeaker.lyricsync/files/updater"

# Update LS-Proxy if newer file exists
if [[ -f "$updater_root/proxy.zip" ]]; then
  echo "LS-Proxy updater found."
  rm -rf "$app_root/LS-Proxy.old"
  mkdir "$app_root/LS-Proxy.new"
  busybox unzip -d "$app_root/LS-Proxy.new" "$updater_root/proxy.zip"
  chmod +x "$app_root/LS-Proxy.new/LS-Proxy"
  mv "$app_root/LS-Proxy" "$app_root/LS-Proxy.old"
  mv "$app_root/LS-Proxy.new" "$app_root/LS-Proxy"
  rm "$updater_root/proxy.zip"
fi

# Update LS-Unity if newer file exists
if [[ -f "$updater_root/unity.apk" ]]; then
  echo "LS-Unity updater found!"
  pm install -r -g -d "$updater_root/unity.apk"
  rm "$updater_root/unity.apk"
fi


# Update TinkerBoard
if
	readonly dest_root=""
	readonly src_root="/data/media/0/Android/data/com.lyricspeaker.lyricsync/files/updater"
	mount -o remount,rw /system
	cp "$src_root/ls2d.sh" "$dest_root/"
	mount -o remount,ro /system
	//then need reboot
fi


