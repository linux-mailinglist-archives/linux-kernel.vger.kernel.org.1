Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0133926F9ED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIRKJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:09:52 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:41959 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgIRKJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:09:51 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MfHQp-1kzioY3oj5-00gtZg; Fri, 18 Sep 2020 12:09:33 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, hch@lst.de,
        linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/3] fbdev: simplify fb_getput_cmap()
Date:   Fri, 18 Sep 2020 12:09:04 +0200
Message-Id: <20200918100926.1447563-1-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200918100812.1447443-1-arnd@arndb.de>
References: <20200918100812.1447443-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qTgjU2sPJm0CtwAKfelk8EKx/cY7OswKlwGh4NJZIDPMM4UJmUa
 ApsbULj9LW7rbHjUIz1A/i0NUp0GCZEkUeR45RFfhJofLOW7W5UZQXrFwxabzkSPKBUC3O4
 4iyxGZQkD/CfW/upMjj+If3hjxf2OaTt5NAhb6N8DJtpZgN492yoUHypNo5oZFBnV+Jkf0L
 8qjEN/cBHKUVWweeaMiHg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:I+M0M0vLS9c=:8VbCZOe/5X9mGc8IGCZSOi
 w59EzSnuxAFLSCTYm7Z6XvrIpjwepuMVc4I1v3tpUF0kSr3n2puXQTR1xZoZR2Orh4MGeTKEV
 vmq+uRoKksxPivfo+tO2P6pTTwHoW+B4KD+dXz04fwUH16m8+ZJkpTC0gnYUEIUnECBxeJRTN
 g4XYRTE9cMapwomMvPYzwq6mvoZK69tcl1kGAIgZpVQrQu9w+pJNwM4+eLq5KajqIFPeGpqbI
 8SLY9hntJUJI/fUuZt5Jh7dF5BjHvQ8P2pxPXMJ7B3wPxiJpQAKwbN+6/lmfMdOp+QWm5sCwG
 uOrWwsLkZt9vb1WT6QuYk9Fza93qwRoHqAWeAU0GpXC/f4H/rAIE/uBmVPtTM8JD8wr63IQj2
 Fg8aM8PP9eE99364fcS/0qZWVWq4sRimAIDPjW3OGVYUbdY+zamNtOXTBqOLH8CPDK7HPMAMN
 rN8kb2ngRIeWlh5K16+MpsBT6nJXJ+xopNj9sttTc4I1WNUZ48SkoUE5MqUghBfwpn1o3ao1A
 4+5ouJ2+JFMVRgSBmUMxA12l/i3ukveBZToIN9bh0YwLXTUejKhezMbEYgH9uPMLP1hc5+Hih
 fcKkanKMD9VlxczrC0xKE6prQKLxq0WLRhFYY8xh2qspUPYb0ZPlchIXjpUWHa6JnQPflpf74
 PhwVCn/be9m0Sg7eABsFrJlqKh6PTtie7sDrNiMNKCztnozy33LjxKv8pUp0/W5N4pWcds93i
 dErwUnVzi5skKzf5evz5kKNnQabqCWtXl54/5aS1oSKpqLaqOR/ih05EJ9I6ERDO9Nk1QmKZT
 V5N85oprolQMJxEJkjOSdX/GMlBAMnMChfDPWMFQUGkzNd4KxUZqQcMC2CFU52PrOhJ1/nZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is one of the remaining users of compat_alloc_user_space()
and copy_in_user().

Clean it up by copying to a local data structure copy instead,
which also leads to more readable code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/core/fbmem.c | 44 ++++++++++++++------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index da7c88ffaa6a..4e162e3d3538 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1211,36 +1211,30 @@ struct fb_cmap32 {
 static int fb_getput_cmap(struct fb_info *info, unsigned int cmd,
 			  unsigned long arg)
 {
-	struct fb_cmap_user __user *cmap;
-	struct fb_cmap32 __user *cmap32;
-	__u32 data;
-	int err;
-
-	cmap = compat_alloc_user_space(sizeof(*cmap));
-	cmap32 = compat_ptr(arg);
+	struct fb_cmap32 cmap32;
+	struct fb_cmap cmap_from;
+	struct fb_cmap_user cmap;
 
-	if (copy_in_user(&cmap->start, &cmap32->start, 2 * sizeof(__u32)))
+	if (copy_from_user(&cmap32, compat_ptr(arg), sizeof(cmap32)))
 		return -EFAULT;
 
-	if (get_user(data, &cmap32->red) ||
-	    put_user(compat_ptr(data), &cmap->red) ||
-	    get_user(data, &cmap32->green) ||
-	    put_user(compat_ptr(data), &cmap->green) ||
-	    get_user(data, &cmap32->blue) ||
-	    put_user(compat_ptr(data), &cmap->blue) ||
-	    get_user(data, &cmap32->transp) ||
-	    put_user(compat_ptr(data), &cmap->transp))
-		return -EFAULT;
+	cmap = (struct fb_cmap_user) {
+		.start	= cmap32.start,
+		.len	= cmap32.len,
+		.red	= compat_ptr(cmap32.red),
+		.green	= compat_ptr(cmap32.green),
+		.blue	= compat_ptr(cmap32.blue),
+		.transp	= compat_ptr(cmap32.transp),
+	};
 
-	err = do_fb_ioctl(info, cmd, (unsigned long) cmap);
+	if (cmd == FBIOPUTCMAP)
+		return fb_set_user_cmap(&cmap, info);
 
-	if (!err) {
-		if (copy_in_user(&cmap32->start,
-				 &cmap->start,
-				 2 * sizeof(__u32)))
-			err = -EFAULT;
-	}
-	return err;
+	lock_fb_info(info);
+	cmap_from = info->cmap;
+	unlock_fb_info(info);
+
+	return fb_cmap_to_user(&cmap_from, &cmap);
 }
 
 static int do_fscreeninfo_to_user(struct fb_fix_screeninfo *fix,
-- 
2.27.0

