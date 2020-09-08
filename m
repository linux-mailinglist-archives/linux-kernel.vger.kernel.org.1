Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84FD2617E6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 19:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbgIHRpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 13:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731653AbgIHQOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:14:04 -0400
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430EEC08C5E6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 07:17:07 -0700 (PDT)
Received: from trochilidae.toradex.int (31-10-206-124.static.upc.ch [31.10.206.124])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 242BF5C291F;
        Tue,  8 Sep 2020 16:17:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1599574623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=zgEgss2wZQe7k40WnKhQQKdlbF5CBIRw28RHGZ6lUxY=;
        b=UJQIUrp41CoX4tJkMQZjwC4n2RWZ/yRGCdjUFP28trwQZqTZT0PRDPq05R+boIQNJDGDJx
        okT50jeJ+iPg36wtIgZwc4/+f7WK//PACfAhybPJqdY0kRScep/J0gCMcD50F2sMqteyN+
        ENsJuQ2+fAWLTNtjB6F7dDyo+trR5PY=
From:   Stefan Agner <stefan@agner.ch>
To:     marex@denx.de, stefan@agner.ch
Cc:     laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, tomi.valkeinen@ti.com,
        linux-imx@nxp.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm: mxsfb: check framebuffer pitch
Date:   Tue,  8 Sep 2020 16:16:54 +0200
Message-Id: <20200908141654.266836-1-stefan@agner.ch>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lcdif IP does not support a framebuffer pitch (stride) other than
framebuffer width. Check for equality and reject the framebuffer
otherwise.

This prevents a distorted picture when using 640x800 and running the
Mesa graphics stack. Mesa tries to use a cache aligned stride, which
leads at that particular resolution to width != stride. Currently
Mesa has no fallback behavior, but rejecting this configuration allows
userspace to handle the issue correctly.

Fixes: 45d59d704080 ("drm: Add new driver for MXSFB controller")
Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes in v3:
- Fix typo in commit message
- Add fixes tag

Changes in v2:
- Validate pitch in fb_create callback

 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 8c549c3931af..35122aef037b 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -21,6 +21,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_irq.h>
@@ -81,8 +82,26 @@ void mxsfb_disable_axi_clk(struct mxsfb_drm_private *mxsfb)
 		clk_disable_unprepare(mxsfb->clk_axi);
 }
 
+static struct drm_framebuffer *
+mxsfb_fb_create(struct drm_device *dev, struct drm_file *file_priv,
+		const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	const struct drm_format_info *info;
+
+	info = drm_get_format_info(dev, mode_cmd);
+	if (!info)
+		return ERR_PTR(-EINVAL);
+
+	if (mode_cmd->width * info->cpp[0] != mode_cmd->pitches[0]) {
+		dev_dbg(dev->dev, "Invalid pitch: fb width must match pitch\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	return drm_gem_fb_create(dev, file_priv, mode_cmd);
+}
+
 static const struct drm_mode_config_funcs mxsfb_mode_config_funcs = {
-	.fb_create		= drm_gem_fb_create,
+	.fb_create		= mxsfb_fb_create,
 	.atomic_check		= drm_atomic_helper_check,
 	.atomic_commit		= drm_atomic_helper_commit,
 };
-- 
2.28.0

