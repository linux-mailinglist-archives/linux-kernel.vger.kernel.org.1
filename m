Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA51326A589
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgIOMt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:49:26 -0400
Received: from crapouillou.net ([89.234.176.41]:33166 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgIOMjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1600173515; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SnThdIg2YWGNs9dq3b6T62D7NZe5+JkYnSB4sOV6bH0=;
        b=l3R87eYCLItM1825bdqH0xrnmFEiUx4Ml7y8PW6jezQV6I1eFtT9gYmyX/0EeSMUzboTq6
        9FLOsFI9sJvszZZIaQ4tEkVhNjSyrhWOF9fOCEsDGzy2RboRaE8rqPWeT6GGEVx2JW6KvQ
        WyZgHM8L8kvwWxdXStaz4MfbT1TIoe4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/3] drm/ingenic: Add support for reserved memory
Date:   Tue, 15 Sep 2020 14:38:18 +0200
Message-Id: <20200915123818.13272-4-paul@crapouillou.net>
In-Reply-To: <20200915123818.13272-1-paul@crapouillou.net>
References: <20200915123818.13272-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for static memory reserved from Device Tree. Since we're
using GEM buffers backed by CMA, it is interesting to have an option to
specify the CMA area where the GEM buffers will be allocated.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index aa32660033d2..44b0d029095e 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
@@ -827,6 +828,11 @@ static void ingenic_drm_unbind_all(void *d)
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
@@ -848,6 +854,19 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 		return -EINVAL;
 	}
 
+	if (IS_ENABLED(CONFIG_OF_RESERVED_MEM)) {
+		ret = of_reserved_mem_device_init(dev);
+
+		if (ret && ret != -ENODEV)
+			return dev_err_probe(dev, ret, "Failed to get reserved memory\n");
+
+		if (ret != -ENODEV) {
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

