Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0F62BFECF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 04:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgKWDrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 22:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbgKWDrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 22:47:24 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4346C061A4C
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 19:47:24 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t21so13005956pgl.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 19:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D107g9ZBNTod+jLTCSbl9CuDKvxuScy2P8EkIE9S/Eo=;
        b=NORWF+ovtP0SodsjQEdxEAQ2LdrlD3D4BNqeFDITFkM12Bvh1UDsTDi5KtObPCmaaC
         MgOQ5jdhhA/Tk0AEK/tAg31MdRsFzzeo9O8rYTvMIdOGeGXkSxhuy7sBnM1S2FQ0pswq
         eGOSumAvHHNsZzsElZiJKT4amStt/ZWrXfPhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D107g9ZBNTod+jLTCSbl9CuDKvxuScy2P8EkIE9S/Eo=;
        b=IWVCXaaVA46eujcp7eGVvjUZoQzbqo30R40OXZ6R+8dTIBLF20DPqkV4HiPFSsTP8H
         l/wBqPEIgHyKgR0TDj7hB6CpavTLla3SatW3trZY7gpQHEYXuy3pudx5tTJ6ewi7wMXT
         H/kyYojEv0Gb0fEMv3t0yFaI+6o0x8IJ10+KGqC97YPg8UEAlbQVrCM3UHmh4BxrSc33
         kmQJfW+rfOfZDcp94nEZAqKKRv4bfbEEMd0Vr1d5wr4uaxzzmM+esNFLdSq9qWHgHz60
         kY8kuQEGBkyatCbOFverc/88pfOCQwD8BLNjl7Ie0HMEfUPu1+m7dJOGHnigIY+2PlKQ
         9CAQ==
X-Gm-Message-State: AOAM530GPAnDgOx68STzXhMzL/h/Xt3XKia8J/ITNJ/KXLoVCP/6F8bC
        RHWd4Np2AjlnvUWKxMUAfc9X1Q==
X-Google-Smtp-Source: ABdhPJzrYPJfIVIbCKqGaDUUZUhn2bRpKIaSoZTNOX8zHL/bGVGXf4HljtWGezhOz5188uJCqfRhBA==
X-Received: by 2002:a62:8cd6:0:b029:18b:ad92:503b with SMTP id m205-20020a628cd60000b029018bad92503bmr23606716pfd.77.1606103244068;
        Sun, 22 Nov 2020 19:47:24 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id m13sm149245pfa.115.2020.11.22.19.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 19:47:23 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Xin Ji <xji@analogixsemi.com>, Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v2 2/2] drm/bridge: anx7625: disable regulators when power off
Date:   Mon, 23 Nov 2020 11:46:54 +0800
Message-Id: <20201123034652.3660584-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201123034652.3660584-1-hsinyi@chromium.org>
References: <20201123034652.3660584-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When suspending the driver, anx7625_power_standby() will be called to
turn off reset-gpios and enable-gpios. However, power supplies are not
disabled. To save power, the driver can get the power supply regulators
and turn off them in anx7625_power_standby().

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
Change:
v2: none
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 25 +++++++++++++++++++++++
 drivers/gpu/drm/bridge/analogix/anx7625.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 65cc05982f82..eb9c4cc2504a 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
@@ -875,12 +876,20 @@ static int sp_tx_edid_read(struct anx7625_data *ctx,
 static void anx7625_power_on(struct anx7625_data *ctx)
 {
 	struct device *dev = &ctx->client->dev;
+	int ret;
 
 	if (!ctx->pdata.low_power_mode) {
 		DRM_DEV_DEBUG_DRIVER(dev, "not low power mode!\n");
 		return;
 	}
 
+	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->pdata.supplies),
+				    ctx->pdata.supplies);
+	if (ret < 0) {
+		DRM_DEV_DEBUG_DRIVER(dev, "cannot enable regulators %d\n", ret);
+		return;
+	}
+
 	/* Power on pin enable */
 	gpiod_set_value(ctx->pdata.gpio_p_on, 1);
 	usleep_range(10000, 11000);
@@ -894,6 +903,7 @@ static void anx7625_power_on(struct anx7625_data *ctx)
 static void anx7625_power_standby(struct anx7625_data *ctx)
 {
 	struct device *dev = &ctx->client->dev;
+	int ret;
 
 	if (!ctx->pdata.low_power_mode) {
 		DRM_DEV_DEBUG_DRIVER(dev, "not low power mode!\n");
@@ -904,6 +914,12 @@ static void anx7625_power_standby(struct anx7625_data *ctx)
 	usleep_range(1000, 1100);
 	gpiod_set_value(ctx->pdata.gpio_p_on, 0);
 	usleep_range(1000, 1100);
+
+	ret = regulator_bulk_disable(ARRAY_SIZE(ctx->pdata.supplies),
+				     ctx->pdata.supplies);
+	if (ret < 0)
+		DRM_DEV_DEBUG_DRIVER(dev, "cannot disable regulators %d\n", ret);
+
 	DRM_DEV_DEBUG_DRIVER(dev, "power down\n");
 }
 
@@ -1742,6 +1758,15 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 	platform->client = client;
 	i2c_set_clientdata(client, platform);
 
+	pdata->supplies[0].supply = "vdd10";
+	pdata->supplies[1].supply = "vdd18";
+	pdata->supplies[2].supply = "vdd33";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(pdata->supplies),
+				      pdata->supplies);
+	if (ret) {
+		DRM_DEV_ERROR(dev, "fail to get power supplies: %d\n", ret);
+		return ret;
+	}
 	anx7625_init_gpio(platform);
 
 	atomic_set(&platform->power_status, 0);
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
index 193ad86c5450..e4a086b3a3d7 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.h
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
@@ -350,6 +350,7 @@ struct s_edid_data {
 struct anx7625_platform_data {
 	struct gpio_desc *gpio_p_on;
 	struct gpio_desc *gpio_reset;
+	struct regulator_bulk_data supplies[3];
 	struct drm_bridge *panel_bridge;
 	int intp_irq;
 	u32 low_power_mode;
-- 
2.29.2.454.gaff20da3a2-goog

