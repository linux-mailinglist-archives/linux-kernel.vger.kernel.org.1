Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F002C7452
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388647AbgK1Vtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:42 -0500
Received: from aposti.net ([89.234.176.197]:45422 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgK1RyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 12:54:12 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] drm/ingenic: Add basic PM support
Date:   Sat, 28 Nov 2020 17:16:06 +0000
Message-Id: <20201128171606.132830-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call drm_mode_config_helper_suspend() and
drm_mode_config_helper_resume() on suspend and resume, respectively.

This makes sure that the display stack is properly disabled when the
hardware is put to sleep.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 368bfef8b340..818a0e4f5bfe 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -14,6 +14,7 @@
 #include <linux/of_device.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 
 #include <drm/drm_atomic.h>
@@ -1167,6 +1168,24 @@ static int ingenic_drm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused ingenic_drm_suspend(struct device *dev)
+{
+	struct ingenic_drm *priv = dev_get_drvdata(dev);
+
+	return drm_mode_config_helper_suspend(&priv->drm);
+}
+
+static int __maybe_unused ingenic_drm_resume(struct device *dev)
+{
+	struct ingenic_drm *priv = dev_get_drvdata(dev);
+
+	drm_mode_config_helper_resume(&priv->drm);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(ingenic_drm_pm_ops, ingenic_drm_suspend, ingenic_drm_resume);
+
 static const u32 jz4740_formats[] = {
 	DRM_FORMAT_XRGB1555,
 	DRM_FORMAT_RGB565,
@@ -1246,6 +1265,7 @@ MODULE_DEVICE_TABLE(of, ingenic_drm_of_match);
 static struct platform_driver ingenic_drm_driver = {
 	.driver = {
 		.name = "ingenic-drm",
+		.pm = pm_ptr(&ingenic_drm_pm_ops),
 		.of_match_table = of_match_ptr(ingenic_drm_of_match),
 	},
 	.probe = ingenic_drm_probe,
-- 
2.29.2

