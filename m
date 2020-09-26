Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F126279B1F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 19:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbgIZRFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 13:05:24 -0400
Received: from crapouillou.net ([89.234.176.41]:38728 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgIZRFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 13:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1601139910; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4dKx0iyOA32oFUtWLpsntW1t7mf/nGBpfmUGlu82Qug=;
        b=cWzKY+YpKFcJxQdxjkzfwzfZWAo7RzcJpv4885Wl3nsRE/9Qzdc7Y3x8mkbToKSOv5C6vf
        XWgYFkZIk985JXBKJDaw2Ar0hS5U0YHqBB4f0EhJASgoXwYbLcK1fAdlCCKc/ppwA+FtEp
        9prsIk337LJWb0QVWOOtfN+kU8qCFng=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/7] drm/ingenic: Add support for reserved memory
Date:   Sat, 26 Sep 2020 19:04:56 +0200
Message-Id: <20200926170501.1109197-3-paul@crapouillou.net>
In-Reply-To: <20200926170501.1109197-1-paul@crapouillou.net>
References: <20200926170501.1109197-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for static memory reserved from Device Tree. Since we're
using GEM buffers backed by CMA, it is interesting to have an option to
specify the CMA area where the GEM buffers will be allocated.

v2: Don't abort probe if reserved memory cannot be obtained. The driver
    will still work fine provided the kernel configuration is sane.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index eadfe3a20bf1..d34e76f5f57d 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
@@ -837,6 +838,11 @@ static void ingenic_drm_unbind_all(void *d)
 	component_unbind_all(priv->dev, &priv->drm);
 }
 
+static void __maybe_unused ingenic_drm_release_rmem(void *d)
+{
+	of_reserved_mem_device_release(d);
+}
+
 static int ingenic_drm_bind(struct device *dev, bool has_components)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -858,6 +864,19 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 		return -EINVAL;
 	}
 
+	if (IS_ENABLED(CONFIG_OF_RESERVED_MEM)) {
+		ret = of_reserved_mem_device_init(dev);
+
+		if (ret && ret != -ENODEV)
+			dev_warn(dev, "Failed to get reserved memory: %d\n", ret);
+
+		if (!ret) {
+			ret = devm_add_action_or_reset(dev, ingenic_drm_release_rmem, dev);
+			if (ret)
+				return ret;
+		}
+	}
+
 	priv = devm_drm_dev_alloc(dev, &ingenic_drm_driver_data,
 				  struct ingenic_drm, drm);
 	if (IS_ERR(priv))
-- 
2.28.0

