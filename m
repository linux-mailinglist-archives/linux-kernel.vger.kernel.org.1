Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A2D1FC434
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 04:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgFQCiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 22:38:51 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:41008 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgFQCiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 22:38:50 -0400
Received: from njvxl5505.vivo.xyz (unknown [157.0.31.125])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 65297261496;
        Wed, 17 Jun 2020 10:38:47 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] gpu/drm: remove drm_modeset_lock protection for drm_error
Date:   Wed, 17 Jun 2020 10:38:40 +0800
Message-Id: <20200617023840.11637-1-bernard@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGhhDHkhOSU0fSBlMVkpOQklITUpOSUxOQ0NVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MyI6Tgw4CzgyMw4sM00VSxcM
        FxhPCUlVSlVKTkJJSE1KTklDS0pIVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU5ZV1kIAVlBSUtCSjcG
X-HM-Tid: 0a72c024a8f19375kuws65297261496
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function drm_atomic_helper_shutdown, maybe there is no need
to protect DRM_ERROR log in DRM_MODESET_LOCK_ALL_BEGIN &
DRM_MODESET_LOCK_ALL_END. This change is to make code run a bit
fast.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 85d163f16801..8902fd6316fc 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3100,12 +3100,10 @@ void drm_atomic_helper_shutdown(struct drm_device *dev)
 	int ret;
 
 	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
-
 	ret = drm_atomic_helper_disable_all(dev, &ctx);
+	DRM_MODESET_LOCK_ALL_END(ctx, ret);
 	if (ret)
 		DRM_ERROR("Disabling all crtc's during unload failed with %i\n", ret);
-
-	DRM_MODESET_LOCK_ALL_END(ctx, ret);
 }
 EXPORT_SYMBOL(drm_atomic_helper_shutdown);
 
-- 
2.17.1

