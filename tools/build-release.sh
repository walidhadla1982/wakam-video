#!/bin/bash
# يبني ملف الإصدار من آخر كوميت بهالمستودع:   bash tools/build-release.sh   →   dist/wakam-video.plugin
# لا ينشر شي.
set -euo pipefail
REPO="$(cd "$(dirname "$0")/.." && pwd)"; cd "$REPO"
DIRS=".claude-plugin video-ad-editor motion-video podcast-video montage-video review-video thumbnail-video"
[ -z "$(git status --porcelain -- $DIRS)" ] || { echo "❌ فيه تعديلات مو مكومتة — كوميت أول"; exit 1; }
T="$(mktemp -d)"; trap 'rm -rf "$T"' EXIT
git archive HEAD $DIRS LICENSE | tar -x -C "$T"
P="$T/video-ad-editor"
# مو للتشغيل: صور الشرح وملفات npm وملفات جيت الداخلية
rm -rf "$P/img" "$P/package.json" "$P/package-lock.json" "$P/motion/.gitignore" "$P/studio/README.md"
# حد 200 ملف لرفع تطبيق كلود + بلا zip داخل الملف: المعاينات و three.js وبنك الأصوات ← tar (تنفك أول مرة)
python3 tools/pack-upload.py "$P"
rm -f "$T/.claude-plugin/marketplace.json"
mkdir -p dist; rm -f dist/wakam-video.plugin
( cd "$T" && zip -qr "$REPO/dist/wakam-video.plugin" $DIRS LICENSE -x '*/.DS_Store' )
# فحوص
N="$(unzip -Z1 dist/wakam-video.plugin | grep -vc '/$')"; [ "$N" -le 200 ] || { echo "❌ wakam-video.plugin فيه $N ملف (الحد 200)"; exit 1; }; echo "  wakam-video.plugin: $N ملف"
! unzip -Z1 dist/wakam-video.plugin | grep -qE '\.(zip|npz|skill|plugin)$' || { echo "❌ فيه zip داخل الملف"; exit 1; }
V="$(python3 -c "import json;print(json.load(open('$T/.claude-plugin/plugin.json'))['version'])")"
( cd "$T" && claude plugin validate . >/dev/null && claude plugin validate .claude-plugin/plugin.json >/dev/null ) || { echo "❌ فحص الـplugin فشل"; exit 1; }
echo "✅ v$V جاهز بـdist/ — .plugin $(du -h dist/wakam-video.plugin | cut -f1)"
