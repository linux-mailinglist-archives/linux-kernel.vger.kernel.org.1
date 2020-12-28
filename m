Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C522E3505
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 09:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgL1IWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 03:22:22 -0500
Received: from m15113.mail.126.com ([220.181.15.113]:49687 "EHLO
        m15113.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgL1IWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 03:22:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=kR7LsGQMcBZUF10Xfd
        CEdaJ3jGd0gRg41YQhRD78f9s=; b=peIfPa56K5rFNIkPG8ED515puQ9JYRT0rb
        0Mg0SaQwN9L9l6US8MK1B+QAheN22sIjK1MGWKBNSmMdHwjJX6CxisPzsa9Tq9K8
        wEpRQhIbaB/RUjvfHspEv8ApsaOMMPy9b4zutgMtD30mAdQ0ziI6tmucYfza2JNK
        4/BV53MvU=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp3 (Coremail) with SMTP id DcmowACXzgUAR+lffFgTNQ--.5617S2;
        Mon, 28 Dec 2020 10:46:25 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     tomi.valkeinen@ti.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Defang Bo <bodefang@126.com>
Subject: [PATCH] drm/omapdrm: don't deref error pointer in the omap_fbdev_create error path
Date:   Mon, 28 Dec 2020 10:46:13 +0800
Message-Id: <1609123573-227288-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DcmowACXzgUAR+lffFgTNQ--.5617S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF45trWfur1UGw17Zw13Jwb_yoWkKrc_Wa
        4v9wn3J3W2kF1UuFnxC3yqvr97K3Z3Zr4rJw48tan3Gry3Wa4rXFWfZrnrXrWrWF42gr95
        Cwn7JrZ8J34xKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUq2MUUUUUU==
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbiYwEJ11x5bW4KXwAAsP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit<789d4c300e10>("drm/msm: don't deref error pointer in the msm_fbdev_create error path"),
the error pointer returned by omap_framebuffer_init() gets passed to drm_framebuffer_remove.
The latter handles only Null pointers,thus a nasty crash will occur.
Drop the unnecessary checks in label fail.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 drivers/gpu/drm/omapdrm/omap_fbdev.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
index 3f6cfc2..7ba07c8 100644
--- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
+++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
@@ -141,8 +141,7 @@ static int omap_fbdev_create(struct drm_fb_helper *helper,
 		 * to unref the bo:
 		 */
 		drm_gem_object_put(fbdev->bo);
-		ret = PTR_ERR(fb);
-		goto fail;
+		return PTR_ERR(fb);
 	}
 
 	/* note: this keeps the bo pinned.. which is perhaps not ideal,
@@ -199,12 +198,7 @@ static int omap_fbdev_create(struct drm_fb_helper *helper,
 	return 0;
 
 fail:
-
-	if (ret) {
-		if (fb)
-			drm_framebuffer_remove(fb);
-	}
-
+	drm_framebuffer_remove(fb);
 	return ret;
 }
 
-- 
2.7.4

