Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0941B2851
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 15:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgDUNo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 09:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728963AbgDUNoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:44:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D3DC061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:44:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so16557305wrx.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dX9SsJrE5hBWZMCB/PsZv22atY0++ttj3tkMV3dDs0Q=;
        b=wAdOMM8Y4A0ygcev7r3LEJy6/ZEs7Rtg9U1GZXegnRmd37n2aFQq89ytgXuMqov+aY
         8j4tKi0c6Ebm8QT9cSFKk60ivx+MNgflnxuoF+GESmrHlsGgE4Law9yevtLxqViztRl1
         xC7GyCZpBnX5loqzujb0MbfvwJqrtkN+ngJ9pnjgJ7Mcfg2cOkYFVJM42jR4bQBEbt2M
         GgwoIH8AYqJKG7RXPa0iicSVSnnyFZyYBbTswnfesr1hVaV8E2YWHcKPmm8OIV/AmVOz
         MQOR1azT28LRFB7UsSNtCGPn4xzxN+Ty7SN4oDi4jX2jzbuStybR3eKmQQ7HV9Ep/bZs
         Dtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dX9SsJrE5hBWZMCB/PsZv22atY0++ttj3tkMV3dDs0Q=;
        b=hqeHImJFfeXa0UK6Peq5kqBNzygpZIt/4fpgIOfuSuKY1YgA1/nQGJ8+A5geyjP76C
         7nZTJjMBkcuDkysj0NqaYwiQaaAtQ6bKCfBv510cgvbtqKAiQsKZUdikocmeIjYEr4EZ
         9FMYd5vE6v9/VgRpXA6ogv6vrwyij7Kh2UDNcxUA23tb3+ORDI/kzoiU+VHcP7qHrXgy
         xIYa6NigHpYlXDGuMRU/Cg6HBJkDKs90svQT4nm1pYxtDOSty3Z82CbEKeEhTv7iPefs
         8k1D9KriwOSLudzPiZWcBEK/KmKAaDalmVMxlsmCHmRQfGEGXzt8Lka1U3z71onOCL5U
         gCVA==
X-Gm-Message-State: AGi0PuaVfY7WZ+yVNxrdPR/koK28YUjysKgje8D4+upgBX6Esp3D9A/o
        KYOjzdfukX2jysqzuRYWJLYk4Q==
X-Google-Smtp-Source: APiQypIKm+M6SMpWmaYV4K+934zXv6wdnVmpZd13gbye74FjG+URTgYgVwpXyg3Nh+qlr1d4JJ5IOw==
X-Received: by 2002:adf:f146:: with SMTP id y6mr25802017wro.132.1587476656747;
        Tue, 21 Apr 2020 06:44:16 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56])
        by smtp.gmail.com with ESMTPSA id a20sm4000854wra.26.2020.04.21.06.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:44:16 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] drm/meson: add mode selection limits against specific SoC revisions
Date:   Tue, 21 Apr 2020 15:44:10 +0200
Message-Id: <20200421134410.30603-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic S805X/Y uses the same die as the S905X, but with more
limited graphics capabilities.

This adds a soc version detection adding specific limitations on the HDMI
mode selections.

Here, we limit to HDMI 1.3a max HDMI PHY clock frequency.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_drv.c     | 29 ++++++++++++++++++++++++++-
 drivers/gpu/drm/meson/meson_drv.h     |  6 ++++++
 drivers/gpu/drm/meson/meson_dw_hdmi.c |  7 +++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 6f29fab79952..621f6de0f076 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -11,6 +11,7 @@
 #include <linux/component.h>
 #include <linux/module.h>
 #include <linux/of_graph.h>
+#include <linux/sys_soc.h>
 #include <linux/platform_device.h>
 #include <linux/soc/amlogic/meson-canvas.h>
 
@@ -183,6 +184,24 @@ static void meson_remove_framebuffers(void)
 	kfree(ap);
 }
 
+struct meson_drm_soc_attr {
+	struct meson_drm_soc_limits limits;
+	const struct soc_device_attribute *attrs;
+};
+
+static const struct meson_drm_soc_attr meson_drm_soc_attrs[] = {
+	/* S805X/S805Y HDMI PLL won't lock for HDMI PHY freq > 1,65GHz */
+	{
+		.limits = {
+			.max_hdmi_phy_freq = 1650000,
+		},
+		.attrs = (const struct soc_device_attribute []) {
+			{ .soc_id = "GXL (S805*)", },
+			{ /* sentinel */ },
+		}
+	},
+};
+
 static int meson_drv_bind_master(struct device *dev, bool has_components)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -191,7 +210,7 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	struct drm_device *drm;
 	struct resource *res;
 	void __iomem *regs;
-	int ret;
+	int ret, i;
 
 	/* Checks if an output connector is available */
 	if (!meson_vpu_has_available_connectors(dev)) {
@@ -281,6 +300,14 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	if (ret)
 		goto free_drm;
 
+	/* Assign limits per soc revision/package */
+	for (i = 0 ; i < ARRAY_SIZE(meson_drm_soc_attrs) ; ++i) {
+		if (soc_device_match(meson_drm_soc_attrs[i].attrs)) {
+			priv->limits = &meson_drm_soc_attrs[i].limits;
+			break;
+		}
+	}
+
 	/* Remove early framebuffers (ie. simplefb) */
 	meson_remove_framebuffers();
 
diff --git a/drivers/gpu/drm/meson/meson_drv.h b/drivers/gpu/drm/meson/meson_drv.h
index 04fdf3826643..5b23704a80d6 100644
--- a/drivers/gpu/drm/meson/meson_drv.h
+++ b/drivers/gpu/drm/meson/meson_drv.h
@@ -30,6 +30,10 @@ struct meson_drm_match_data {
 	struct meson_afbcd_ops *afbcd_ops;
 };
 
+struct meson_drm_soc_limits {
+	unsigned int max_hdmi_phy_freq;
+};
+
 struct meson_drm {
 	struct device *dev;
 	enum vpu_compatible compat;
@@ -48,6 +52,8 @@ struct meson_drm {
 	struct drm_plane *primary_plane;
 	struct drm_plane *overlay_plane;
 
+	const struct meson_drm_soc_limits *limits;
+
 	/* Components Data */
 	struct {
 		bool osd1_enabled;
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index e8c94915a4fc..dc3d5122475a 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -695,6 +695,13 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
 	dev_dbg(connector->dev->dev, "%s: vclk:%d phy=%d venc=%d hdmi=%d\n",
 		__func__, phy_freq, vclk_freq, venc_freq, hdmi_freq);
 
+	/* Check against soc revision/package limits */
+	if (priv->limits) {
+		if (priv->limits->max_hdmi_phy_freq &&
+		    phy_freq > priv->limits->max_hdmi_phy_freq)
+			return MODE_CLOCK_HIGH;
+	}
+
 	return meson_vclk_vic_supported_freq(phy_freq, vclk_freq);
 }
 
-- 
2.22.0

