#!/usr/bin/env python3
"""يجهّز مجلد البلقن لرفع تطبيق كلود: حد 200 ملف + بلا zip داخل الملف.
   previews/ ← previews.tar · vendor/ ← vendor.tar · sfx/bank.npz ← sfx/bank.tar (ملفات npy).
   الاستخدام: pack-upload.py <مجلد video-ad-editor المنسوخ>"""
import io, sys, tarfile, shutil
from pathlib import Path
import numpy as np
P = Path(sys.argv[1])
for parent, name in ((P / "motion" / "moves", "previews"), (P / "motion", "vendor")):
    with tarfile.open(parent / (name + ".tar"), "w") as t:
        t.add(parent / name, arcname=name)
    shutil.rmtree(parent / name)
z = np.load(P / "sfx" / "bank.npz")
with tarfile.open(P / "sfx" / "bank.tar", "w") as t:
    for k in z.files:
        b = io.BytesIO(); np.save(b, z[k]); ti = tarfile.TarInfo(k + ".npy"); ti.size = b.getbuffer().nbytes; b.seek(0); t.addfile(ti, b)
(P / "sfx" / "bank.npz").unlink()
