# WAKAM Video

**Code Your Dreams.** WAKAM's video studio for Claude: you talk to the camera (or hand over clips, a script, or a podcast recording) and get back a finished, publish-ready video — no editing software.

## Skills

| Skill | What it does |
|---|---|
| `video-ad-editor` | Talking-head video → 9:16 reel or ad: removes silences, word-timed Arabic captions, motion graphics |
| `review-video` | Product review reel: voiceover over product shots, tracking lines, spec cards, discount card |
| `motion-video` | 3D motion-graphics film from text or an idea; website/app walkthroughs; "how does it work" machine explainers |
| `podcast-video` | Multi-camera podcast → reels with hooks, or the full 16:9 episode |
| `montage-video` | Folder of clips without speech → one beat-synced 9:16 montage |
| `thumbnail-video` | Reel covers and YouTube thumbnails sized to read on a phone |

## WAKAM brand defaults

Applied automatically until you save your own choices from the setup page:

| | |
|---|---|
| Background | `#000000` |
| Text | `#FFFFFF` |
| Accent | `#0090FF` |
| Logo | `video-ad-editor/brand/logo.png` |
| End card | "Code Your Dreams" + WAKAM |

To change them, edit `BRAND_PROFILE` in `video-ad-editor/scripts/00_onboard.py` (or say "غيّر إعداداتي" to open the setup page; what you save there overrides the defaults).

## Build

`bash tools/build-release.sh` → `dist/wakam-video.plugin`

## License

MIT — see `LICENSE`.
