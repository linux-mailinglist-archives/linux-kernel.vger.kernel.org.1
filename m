Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627762E272D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 14:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgLXNTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 08:19:47 -0500
Received: from mail.zju.edu.cn ([61.164.42.155]:9192 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727320AbgLXNTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 08:19:46 -0500
Received: from localhost.localdomain (unknown [10.192.85.18])
        by mail-app2 (Coremail) with SMTP id by_KCgDn7+vqlORflDEBAA--.6180S4;
        Thu, 24 Dec 2020 21:17:33 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        James Jones <jajones@nvidia.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: Fix memleak in nv50_wndw_new_
Date:   Thu, 24 Dec 2020 21:17:34 +0800
Message-Id: <20201224131736.9584-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgDn7+vqlORflDEBAA--.6180S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWfZr1DCw4DKry8GrW8Crg_yoW8Cw4UpF
        42kFyUAry0van5J3ySyrs2k3W3u3yvqr4xWF129wnxJ3WYyr17Zr4FyF92grsIqrW7G340
        grs7GF98ZF1UG3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgYEBlZdtRrnPQAAs4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When nv50_lut_init() fails, *pwndw should be freed
just like when drm_universal_plane_init() fails.
It's the same for the subsequent error paths.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/gpu/drm/nouveau/dispnv50/wndw.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
index 0356474ad6f6..47ce1df2ae5f 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
@@ -732,18 +732,15 @@ nv50_wndw_new_(const struct nv50_wndw_func *func, struct drm_device *dev,
 				       format, nformat,
 				       nouveau_display(dev)->format_modifiers,
 				       type, "%s-%d", name, index);
-	if (ret) {
-		kfree(*pwndw);
-		*pwndw = NULL;
-		return ret;
-	}
+	if (ret)
+		goto err_free;
 
 	drm_plane_helper_add(&wndw->plane, &nv50_wndw_helper);
 
 	if (wndw->func->ilut) {
 		ret = nv50_lut_init(disp, mmu, &wndw->ilut);
 		if (ret)
-			return ret;
+			goto err_free;
 	}
 
 	wndw->notify.func = nv50_wndw_notify;
@@ -752,26 +749,31 @@ nv50_wndw_new_(const struct nv50_wndw_func *func, struct drm_device *dev,
 		ret = drm_plane_create_zpos_property(&wndw->plane,
 				nv50_wndw_zpos_default(&wndw->plane), 0, 254);
 		if (ret)
-			return ret;
+			goto err_free;
 
 		ret = drm_plane_create_alpha_property(&wndw->plane);
 		if (ret)
-			return ret;
+			goto err_free;
 
 		ret = drm_plane_create_blend_mode_property(&wndw->plane,
 				BIT(DRM_MODE_BLEND_PIXEL_NONE) |
 				BIT(DRM_MODE_BLEND_PREMULTI) |
 				BIT(DRM_MODE_BLEND_COVERAGE));
 		if (ret)
-			return ret;
+			goto err_free;
 	} else {
 		ret = drm_plane_create_zpos_immutable_property(&wndw->plane,
 				nv50_wndw_zpos_default(&wndw->plane));
 		if (ret)
-			return ret;
+			goto err_free;
 	}
 
 	return 0;
+
+err_free:
+	kfree(*pwndw);
+	*pwndw = NULL;
+	return ret;
 }
 
 int
-- 
2.17.1

