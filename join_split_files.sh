#!/bin/bash

cat system/system/priv-app/YandexApp/YandexApp.apk.* 2>/dev/null >> system/system/priv-app/YandexApp/YandexApp.apk
rm -f system/system/priv-app/YandexApp/YandexApp.apk.* 2>/dev/null
cat system/system/priv-app/YandexBrowser/YandexBrowser.apk.* 2>/dev/null >> system/system/priv-app/YandexBrowser/YandexBrowser.apk
rm -f system/system/priv-app/YandexBrowser/YandexBrowser.apk.* 2>/dev/null
cat system/system/product/app/Photos/Photos.apk.* 2>/dev/null >> system/system/product/app/Photos/Photos.apk
rm -f system/system/product/app/Photos/Photos.apk.* 2>/dev/null
cat system/system/product/app/WebViewGoogle/WebViewGoogle.apk.* 2>/dev/null >> system/system/product/app/WebViewGoogle/WebViewGoogle.apk
rm -f system/system/product/app/WebViewGoogle/WebViewGoogle.apk.* 2>/dev/null
cat system/system/product/priv-app/GmsCore/GmsCore.apk.* 2>/dev/null >> system/system/product/priv-app/GmsCore/GmsCore.apk
rm -f system/system/product/priv-app/GmsCore/GmsCore.apk.* 2>/dev/null
cat system/system/product/priv-app/Velvet/Velvet.apk.* 2>/dev/null >> system/system/product/priv-app/Velvet/Velvet.apk
rm -f system/system/product/priv-app/Velvet/Velvet.apk.* 2>/dev/null
