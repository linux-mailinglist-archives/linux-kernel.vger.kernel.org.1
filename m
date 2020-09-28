Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51D927B336
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 19:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgI1RbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 13:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgI1RbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 13:31:05 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE746C061755;
        Mon, 28 Sep 2020 10:31:05 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g96so1696889otb.12;
        Mon, 28 Sep 2020 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z9O7mA5D7c+JFa4r/JG3w4qFephERKS0m6X1DHUded8=;
        b=WHMnVkAxMyPFWTIQbQLltT+fVWIrpiHBADBt822NXrX/eDAk9s75vYda2zOto5xSuc
         dtWkBhgcOvHUyMUJtFYKgXwozc5rM0SrgZEH7PN/FosqEmsVolWqTv8YTGfs95Pcr8P/
         QS2Y9j7gC4WxOPie1rv/UKEjPMavlgV03pmWgTvSf/zSWNBjpOvOXJNecJkXIQTtODIN
         y6mhjTGKH4RkyOpczNvkfakPDCjZ3LQ3THbA47AZxon1PqAUw14ex1fc9HnGhHIrLWdh
         swj7eEMuWsfs4P6H3bna5+ryGgljvpePEA62GXODfv73NiiCrZaEoWYrnNvz6Q2kyMZN
         QHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z9O7mA5D7c+JFa4r/JG3w4qFephERKS0m6X1DHUded8=;
        b=oqnXa8yrOhM42nqJEuOFirKaZ2vRcdTN7k9dOGBMlqgE7TQwSPxOTRb5okypDFeL7N
         YbOTUEPhjH4kdo3rLfIOT2LgO8hxnWnQuEYzz3A/vBHwM7MGrnP++UOmfhtWMCzshbVO
         BQfRPOB1v0cNuIqQN3oVEBEWYIqWQstd48DjDVrXV+nLDxb+d4cLG1t+WB7EJAB6lzWQ
         L98wPC1Tnax6eT1+Z/xUcR92+SJk5nSFoyTxyz1liovUYqh7gIcQHBKz8w7QEoMQy0YF
         CAPuDSqpV7DSHLi9zBuROI8u4SU7sJBQlukk/kSefiWjstBC209Or347fwHsYfxvv1hp
         gfyw==
X-Gm-Message-State: AOAM531Sie2YnyMYFurpg590CyLIiTFOyFvhosytFMdUvbcIUtk/4V86
        1Y1Qrgcc26XufK5ME5XxumF/QXcdWRA=
X-Google-Smtp-Source: ABdhPJwzVfBPEjYgV08nL3dPU+C4ZfWoVQGO2PnCk2vQeWROCT5ejZauBS+aXEV4jBfN4SG3OGPK1A==
X-Received: by 2002:a9d:7f0c:: with SMTP id j12mr44331otq.53.1601314264882;
        Mon, 28 Sep 2020 10:31:04 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id g23sm2348484ooh.45.2020.09.28.10.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 10:31:04 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] drm/bridge: sii902x: Enable I/O and core VCC supplies if present
Date:   Mon, 28 Sep 2020 12:30:53 -0500
Message-Id: <20200928173056.1674274-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200924200507.1175888-1-mr.nuke.me@gmail.com>
References: <20200924200507.1175888-1-mr.nuke.me@gmail.com>
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

 drivers/gpu/drm/bridge/sii902x.c | 54 ++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 33fd33f953ec..d15e9f2c0d8a 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/clk.h>
 
 #include <drm/drm_atomic_helper.h>
@@ -168,6 +169,8 @@ struct sii902x {
 	struct drm_connector connector;
 	struct gpio_desc *reset_gpio;
 	struct i2c_mux_core *i2cmux;
+	struct regulator *iovcc;
+	struct regulator *cvcc12;
 	/*
 	 * Mutex protects audio and video functions from interfering
 	 * each other, by keeping their i2c command sequences atomic.
@@ -954,13 +957,13 @@ static const struct drm_bridge_timings default_sii902x_timings = {
 		 | DRM_BUS_FLAG_DE_HIGH,
 };
 
+static int sii902x_init(struct sii902x *sii902x);
+
 static int sii902x_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
-	unsigned int status = 0;
 	struct sii902x *sii902x;
-	u8 chipid[4];
 	int ret;
 
 	ret = i2c_check_functionality(client->adapter,
@@ -989,6 +992,43 @@ static int sii902x_probe(struct i2c_client *client,
 
 	mutex_init(&sii902x->mutex);
 
+	sii902x->iovcc = devm_regulator_get(dev, "iovcc");
+	if (IS_ERR(sii902x->iovcc))
+		return PTR_ERR(sii902x->iovcc);
+
+	sii902x->cvcc12 = devm_regulator_get(dev, "cvcc12");
+	if (IS_ERR(sii902x->cvcc12))
+		return PTR_ERR(sii902x->cvcc12);
+
+	ret = regulator_enable(sii902x->iovcc);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "Failed to enable iovcc supply");
+		return ret;
+	}
+
+	ret = regulator_enable(sii902x->cvcc12);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "Failed to enable cvcc12 supply");
+		regulator_disable(sii902x->iovcc);
+		return ret;
+	}
+
+	ret = sii902x_init(sii902x);
+	if (ret < 0) {
+		regulator_disable(sii902x->cvcc12);
+		regulator_disable(sii902x->iovcc);
+	}
+
+	return ret;
+}
+
+static int sii902x_init(struct sii902x *sii902x)
+{
+	struct device *dev = &sii902x->i2c->dev;
+	unsigned int status = 0;
+	u8 chipid[4];
+	int ret;
+
 	sii902x_reset(sii902x);
 
 	ret = regmap_write(sii902x->regmap, SII902X_REG_TPI_RQB, 0x0);
@@ -1012,11 +1052,11 @@ static int sii902x_probe(struct i2c_client *client,
 	regmap_read(sii902x->regmap, SII902X_INT_STATUS, &status);
 	regmap_write(sii902x->regmap, SII902X_INT_STATUS, status);
 
-	if (client->irq > 0) {
+	if (sii902x->i2c->irq > 0) {
 		regmap_write(sii902x->regmap, SII902X_INT_ENABLE,
 			     SII902X_HOTPLUG_EVENT);
 
-		ret = devm_request_threaded_irq(dev, client->irq, NULL,
+		ret = devm_request_threaded_irq(dev, sii902x->i2c->irq, NULL,
 						sii902x_interrupt,
 						IRQF_ONESHOT, dev_name(dev),
 						sii902x);
@@ -1031,9 +1071,9 @@ static int sii902x_probe(struct i2c_client *client,
 
 	sii902x_audio_codec_init(sii902x, dev);
 
-	i2c_set_clientdata(client, sii902x);
+	i2c_set_clientdata(sii902x->i2c, sii902x);
 
-	sii902x->i2cmux = i2c_mux_alloc(client->adapter, dev,
+	sii902x->i2cmux = i2c_mux_alloc(sii902x->i2c->adapter, dev,
 					1, 0, I2C_MUX_GATE,
 					sii902x_i2c_bypass_select,
 					sii902x_i2c_bypass_deselect);
@@ -1051,6 +1091,8 @@ static int sii902x_remove(struct i2c_client *client)
 
 	i2c_mux_del_adapters(sii902x->i2cmux);
 	drm_bridge_remove(&sii902x->bridge);
+	regulator_disable(sii902x->cvcc12);
+	regulator_disable(sii902x->iovcc);
 
 	return 0;
 }
-- 
2.25.4

