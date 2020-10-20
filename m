Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A954294500
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 00:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438976AbgJTWPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 18:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438925AbgJTWPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 18:15:12 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFAAC0613CE;
        Tue, 20 Oct 2020 15:15:12 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id f10so78998otb.6;
        Tue, 20 Oct 2020 15:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qgb/6FQ5Y+5ks3gJUSbI0OvSC559NlxqqVqZk7W8uig=;
        b=uNfpqwWZTEG9jrnDv2yMwFvts2SeACpm4RaAGrMNM27LXCj16ykn3WxaPn/YyuJ1jl
         UKWNwa/WOMeMkK/PiT0CesDhjV8GryPrl+vMpvcqDWctvZ89EA7xNlvBrOb0WphNGtZ1
         JR6YIpnujy0WRYKxi/zSsai1kJdGJ5HHmGuk7H/dWwdj0gNJFmLJKveYdoYoQa8F6JrL
         iUvp8jzDDDZ0NGBZ3gKmNRM9G60zxOGYLocpLuuK8KUBKnjmZXwleNYKvB3Phr/vtpkm
         ypHTaZzSumnz8IC4ap3RywWe4SYkhKbs7iZHvO51xkkno0wHcYU7m0DtLjh8ORc47WNn
         gb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qgb/6FQ5Y+5ks3gJUSbI0OvSC559NlxqqVqZk7W8uig=;
        b=Yj1SY1fdMOMdSRpkEc+KEXBPnZMBcg4NogWT4x9DRjp8Y575sNS2yr2M2QLYncCO6B
         QMI33fcKo4F4UsvR+shrYYPyVzbv/DybvR1j0d860wPvfi8neGZCS2BFvtgmFHrzW8nI
         HRFnVcokTjXScOk5oiinCjvyjubE5oTFgJbHqZD9D9BGVes9tHfwXQt/0PvQEWFscMFt
         v7hwRWCbUi5lcrgpPchUTQQV72SKglXlvBTWBGE4ZWRDpe46CcRFaUWpwi6Pd17TyMJH
         hvS0jG1sZSm0pH91Ifz5zij4BD8KZqJPLVlrcDBmIDfh4nv2pPszaHwwFpU2XzonuJyB
         Idiw==
X-Gm-Message-State: AOAM532TzrEcyoph9lD+3Neyn1GHKL9SPPguczzQ/fwMu3Wds/W/a0pz
        a1Ygy3F6OAmqdz+rbNqBCRso6r47uvjzNw==
X-Google-Smtp-Source: ABdhPJzMVl1/tXVTDSiL+yi4uPPZsH0uG/LZGzfJtSt79m3oerf91yhSp/3Z8o1/prH6Ai4t3uCepA==
X-Received: by 2002:a05:6830:2434:: with SMTP id k20mr358136ots.205.1603232112128;
        Tue, 20 Oct 2020 15:15:12 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id 81sm57005oti.79.2020.10.20.15.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 15:15:11 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     sam@ravnborg.org, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/3] drm/bridge: sii902x: Enable I/O and core VCC supplies if present
Date:   Tue, 20 Oct 2020 17:14:58 -0500
Message-Id: <20201020221501.260025-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928173056.1674274-1-mr.nuke.me@gmail.com>
References: <20200928173056.1674274-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the SII9022, the IOVCC and CVCC12 supplies must reach the correct
voltage before the reset sequence is initiated. On most boards, this
assumption is true at boot-up, so initialization succeeds.

However, when we try to initialize the chip with incorrect supply
voltages, it will not respond to I2C requests. sii902x_probe() fails
with -ENXIO.

To resolve this, look for the "iovcc" and "cvcc12" regulators, and
make sure they are enabled before starting the reset sequence. If
these supplies are not available in devicetree, then they will default
to dummy-regulator. In that case everything will work like before.

This was observed on a STM32MP157C-DK2 booting in u-boot falcon mode.
On this board, the supplies would be set by the second stage
bootloader, which does not run in falcon mode.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
Changes since v1:
  * Fix return code after regulator_enable(sii902x->iovcc) fails (Fabio Estevam)
  * Use dev_err_probe() instead of dev_err() where appropriate (Sam Ravnborg)

Changes since v2:
  * Eliminate prototype for static functionn sii902x_init (Sam Ravnborg)
  * Bundled supplies under regulator_bulk_get/enable/disable()
  
 drivers/gpu/drm/bridge/sii902x.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index f78c17f49887..5bab51a6b55c 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/clk.h>
 
 #include <drm/drm_atomic_helper.h>
@@ -168,6 +169,7 @@ struct sii902x {
 	struct drm_connector connector;
 	struct gpio_desc *reset_gpio;
 	struct i2c_mux_core *i2cmux;
+	struct regulator_bulk_data supplies[2];
 	/*
 	 * Mutex protects audio and video functions from interfering
 	 * each other, by keeping their i2c command sequences atomic.
@@ -1049,7 +1051,26 @@ static int sii902x_probe(struct i2c_client *client,
 
 	mutex_init(&sii902x->mutex);
 
+	sii902x->supplies[0].supply = "iovcc";
+	sii902x->supplies[1].supply = "cvcc12";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(sii902x->supplies),
+				      sii902x->supplies);
+	if (ret < 0)
+		return ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(sii902x->supplies),
+				    sii902x->supplies);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "Failed to enable supplies");
+		return ret;
+	}
+
 	ret = sii902x_init(sii902x);
+	if (ret < 0) {
+		regulator_bulk_disable(ARRAY_SIZE(sii902x->supplies),
+					sii902x->supplies);
+	}
+
 	return ret;
 }
 
@@ -1060,6 +1081,8 @@ static int sii902x_remove(struct i2c_client *client)
 
 	i2c_mux_del_adapters(sii902x->i2cmux);
 	drm_bridge_remove(&sii902x->bridge);
+	regulator_bulk_disable(ARRAY_SIZE(sii902x->supplies),
+				sii902x->supplies);
 
 	return 0;
 }
-- 
2.26.2

