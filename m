Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F362277A01
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgIXUNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgIXUNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:13:34 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294DBC0613D8;
        Thu, 24 Sep 2020 13:05:18 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id h17so142912otr.1;
        Thu, 24 Sep 2020 13:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VwcvBfgUUrYSrG3GnB+pmGghnFjX4UM5Od8EP9k63Lg=;
        b=q0Q2MM7oxeVazXqMyi35imt0SSLQQ0MxZIJ5bIsrS8LOf9Zdck6pcilKGiH3oHjfy6
         aaaYOoXVT2R3fEJ98AFjWu6sYstganyEv4BqJC9w5x9HKRwDDqLhj5J+HvbLV/bZ9jSj
         knrtx/+i+5S5wkGP82MSXMZ0G1A8n+CIEH/ROVnNAmQ2YX2xAo0jLETpAWdcMidpwI0a
         DnCyA9rzh82liAnlXb0rNnAWHvHhHnUZua0uJbF1CkKyzecRtksbcsmc0hujjFqo8JXL
         KzadUQc1C2pBsPfpAtToipMapt59UNtL3yFssmIeSv68uCz0Z3Hz2ObWf4VjhLgUNFi0
         edeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VwcvBfgUUrYSrG3GnB+pmGghnFjX4UM5Od8EP9k63Lg=;
        b=DqfB+uyDqx7tz4vgKj/My8l0BgH8CDCTvA+ca4POC7LeH5ZM8sBDKkIn9UAgeAUBud
         oRdyd5aDDwYUSmIV0YLZHtPN2kv4v8gadrVPoiaoftxCnaSQOiST0L8CjBoABW48j1Jl
         bcDN5bXpOAvkpcWdnGwn/KcbgHQctACPs4B6nwDV78ai+tJlE/lkRWS5PM0wfb0UWW1B
         pZ6Pjf3QdvTZ7Z4y+OdO1wbC/PtseyyUwa3/5u2HcsTDRflKBmBK9bBz2tffsNdQAwwf
         liYoWR5lNxOXLcmvaWqB87XBTayoMutodj45YHnCstBjRNX0NFlv3ofRUXtEEkBvluGQ
         /ChQ==
X-Gm-Message-State: AOAM533Lbn+X6WPzhpSgPBAXc2NKQLagZ26VOoeZzu2GprpYVW2Oe8wA
        AoHNwhgJ0+RRTPUkHf2jaxE=
X-Google-Smtp-Source: ABdhPJxbB4d4zgaNoErV6bbn7ECJUg+b++A+hhYIvzkxOTuTuOVOuPUSMRGRVdR1R5+Ro6lejgsREg==
X-Received: by 2002:a9d:4b01:: with SMTP id q1mr584722otf.138.1600977917517;
        Thu, 24 Sep 2020 13:05:17 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id n13sm85590oic.14.2020.09.24.13.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 13:05:16 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
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
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/bridge: sii902x: Enable I/O and core VCC supplies if present
Date:   Thu, 24 Sep 2020 15:05:05 -0500
Message-Id: <20200924200507.1175888-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.25.4
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
 drivers/gpu/drm/bridge/sii902x.c | 54 ++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 33fd33f953ec..a5558d83e4c5 100644
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
+		dev_err(dev, "Failed to enable iovcc supply: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_enable(sii902x->cvcc12);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable cvcc12 supply: %d\n", ret);
+		regulator_disable(sii902x->iovcc);
+		return PTR_ERR(sii902x->cvcc12);
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

