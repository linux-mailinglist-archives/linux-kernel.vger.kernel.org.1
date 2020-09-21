Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A889B271D0D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 10:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgIUIEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 04:04:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13740 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726553AbgIUICS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 04:02:18 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E0748222A75F2A36BE81;
        Mon, 21 Sep 2020 16:02:15 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 16:02:07 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Dave Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Liu Shixin" <liushixin2@huawei.com>
Subject: [PATCH -next] drm/ast: simplify the return expression of ast_* function
Date:   Mon, 21 Sep 2020 16:24:32 +0800
Message-ID: <20200921082432.2591253-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/gpu/drm/ast/ast_drv.c  | 7 +------
 drivers/gpu/drm/ast/ast_mode.c | 7 +------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index f0b4af1c390a..a2a3f32260f9 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -160,15 +160,10 @@ static int ast_drm_thaw(struct drm_device *dev)
 
 static int ast_drm_resume(struct drm_device *dev)
 {
-	int ret;
-
 	if (pci_enable_device(dev->pdev))
 		return -EIO;
 
-	ret = ast_drm_thaw(dev);
-	if (ret)
-		return ret;
-	return 0;
+	return ast_drm_thaw(dev);
 }
 
 static int ast_pm_suspend(struct device *dev)
diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 834a156e3a75..4dca4ff01d41 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -636,18 +636,13 @@ ast_cursor_plane_helper_prepare_fb(struct drm_plane *plane,
 	struct drm_framebuffer *fb = new_state->fb;
 	struct drm_crtc *crtc = new_state->crtc;
 	struct ast_private *ast;
-	int ret;
 
 	if (!crtc || !fb)
 		return 0;
 
 	ast = to_ast_private(plane->dev);
 
-	ret = ast_cursor_blit(ast, fb);
-	if (ret)
-		return ret;
-
-	return 0;
+	return ast_cursor_blit(ast, fb);
 }
 
 static int ast_cursor_plane_helper_atomic_check(struct drm_plane *plane,
-- 
2.25.1

