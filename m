Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3044E2BAEFA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgKTPaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgKTPaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:30:30 -0500
X-Greylist: delayed 394 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Nov 2020 07:30:30 PST
Received: from pet8032.tnsp.org (tnsp.org [IPv6:2a04:3540:1000:310:f095:b5ff:fe23:3d0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136B8C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:30:30 -0800 (PST)
Received: from nmos6502.tnsp.org (91-158-253-65.elisa-laajakaista.fi [91.158.253.65])
        by pet8032.tnsp.org (Postfix) with ESMTPSA id 21D0C196A72;
        Fri, 20 Nov 2020 17:23:51 +0200 (EET)
From:   Matti Hamalainen <ccr@tnsp.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/nouveau: fix relocations applying logic and a double-free
Date:   Fri, 20 Nov 2020 17:23:38 +0200
Message-Id: <20201120152338.1203257-1-ccr@tnsp.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 03e0d26fcf79 ("drm/nouveau: slowpath for pushbuf ioctl") included
a logic-bug which results in the relocations not actually getting
applied at all as the call to nouveau_gem_pushbuf_reloc_apply() is
never reached. This causes a regression with graphical corruption,
triggered when relocations need to be done (for example after a
suspend/resume cycle.)

Fix by setting *apply_relocs value only if there were more than 0
relocations.

Additionally, the never reached code had a leftover u_free() call,
which, after fixing the logic, now got called and resulted in a
double-free. Fix by removing one u_free(), moving the other
and adding check for errors.

Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Matti Hamalainen <ccr@tnsp.org>
Fixes: 03e0d26fcf79 ("drm/nouveau: slowpath for pushbuf ioctl")
Link: https://gitlab.freedesktop.org/drm/nouveau/-/issues/11
---
 drivers/gpu/drm/nouveau/nouveau_gem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index 549bc67feabb..c2051380d18c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -558,8 +558,10 @@ nouveau_gem_pushbuf_validate(struct nouveau_channel *chan,
 			NV_PRINTK(err, cli, "validating bo list\n");
 		validate_fini(op, chan, NULL, NULL);
 		return ret;
+	} else if (ret > 0) {
+		*apply_relocs = true;
 	}
-	*apply_relocs = ret;
+
 	return 0;
 }
 
@@ -662,7 +664,6 @@ nouveau_gem_pushbuf_reloc_apply(struct nouveau_cli *cli,
 		nouveau_bo_wr32(nvbo, r->reloc_bo_offset >> 2, data);
 	}
 
-	u_free(reloc);
 	return ret;
 }
 
@@ -872,9 +873,10 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void *data,
 				break;
 			}
 		}
-		u_free(reloc);
 	}
 out_prevalid:
+	if (!IS_ERR(reloc))
+		u_free(reloc);
 	u_free(bo);
 	u_free(push);
 

base-commit: 3494d58865ad4a47611dbb427b214cc5227fa5eb
-- 
2.29.2

