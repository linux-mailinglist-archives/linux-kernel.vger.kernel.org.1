Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E5D2944FE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 00:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438966AbgJTWPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 18:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438925AbgJTWPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 18:15:10 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05277C0613CE;
        Tue, 20 Oct 2020 15:15:10 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id u17so3829344oie.3;
        Tue, 20 Oct 2020 15:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+CpEO8YhmbVOZXzaRTTlPwKKMh8ff8K9DvXivuST1qc=;
        b=Wt1L2chonevKKt3UJIbVeNDb+bYA161TTXwmzFBs+lABdRQxknsdeHXkEp8yzzTZIo
         7BNOKfubqjn+jNKiQKJRRunBp/upoEvvKVgJN1wKvQz4hhFOHGRlHWdac3u+feevyYO+
         HBxKwu6edrm+woL8n6yvlIK3NlUYR8hxCZ1mipEe29n0GuBgNGbY3ozp63u0o/9Z368o
         K+sKlL+1cVabaySLHgmx5o+KI8uQTqH+zjen16e2qtxpMGkv2bWkStEMytU7SjKe+rvM
         O7ny6I8iCeSA+ppkNZEJYXMmYStnyQWUtdt4YpiGaetODkOHIBvVr4nysBkiilU0ALLQ
         t28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+CpEO8YhmbVOZXzaRTTlPwKKMh8ff8K9DvXivuST1qc=;
        b=bkVCT2WyK5hod5gYl5Tb/zKO3TzVZ70RFJVmX9pDQlnODM/mhLlnnC8LpXlioj2eXT
         K9KcC5oKct06ZwHEfmjeT6YI94UojUxfz2+DQplB0Sh1I6ZU0o6uZ/qVaWC1jMuGUIFu
         a3I6CHkiVkCvxyWmVDj1jgom08cAsY+saSAFGjyjtrmJGNTuivqe/cy4nBS+paS/ewSy
         DKoBPaDY2ZkCTJTBUJc9APHMrdBx2mWDCOqwTa34NawPmsiJeBmkb9QLSw10aiVcs9HD
         70bMAHDdxu62eCKsXM3YIBCahoqQcNh1fIoLVyT15jotitTzxCnoscbg4R1kvALLHBFw
         1U+A==
X-Gm-Message-State: AOAM533uIJAa+pH7U9K0kjE6lCDBZxZAIF31Yl32n4RYaFa66jKgK/+b
        A3iKHJuqohJShJ1dDUsQMS4=
X-Google-Smtp-Source: ABdhPJxfNRSrioVTPpQ0lhQURF8C6l5m0Fewl/pKBJDVDbUIqIKC5y3LfPoelGxitYrmKAMxp/NY4g==
X-Received: by 2002:aca:1105:: with SMTP id 5mr156072oir.46.1603232109349;
        Tue, 20 Oct 2020 15:15:09 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id 81sm57005oti.79.2020.10.20.15.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 15:15:08 -0700 (PDT)
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
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/3] drm/bridge: sii902x: Refactor init code into separate function
Date:   Tue, 20 Oct 2020 17:14:57 -0500
Message-Id: <20201020221501.260025-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928173056.1674274-1-mr.nuke.me@gmail.com>
References: <20200928173056.1674274-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the hardware initialization code from setting up the data
structures and parsing the device tree. The purpose of this change is
to provide a single exit point and avoid a waterfall of 'goto's in
the subsequent patch.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
Changes since v1/and v2:
  * Separated this from main patch to better show diff

 drivers/gpu/drm/bridge/sii902x.c | 77 ++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 33fd33f953ec..f78c17f49887 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -954,41 +954,13 @@ static const struct drm_bridge_timings default_sii902x_timings = {
 		 | DRM_BUS_FLAG_DE_HIGH,
 };
 
-static int sii902x_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int sii902x_init(struct sii902x *sii902x)
 {
-	struct device *dev = &client->dev;
+	struct device *dev = &sii902x->i2c->dev;
 	unsigned int status = 0;
-	struct sii902x *sii902x;
 	u8 chipid[4];
 	int ret;
 
-	ret = i2c_check_functionality(client->adapter,
-				      I2C_FUNC_SMBUS_BYTE_DATA);
-	if (!ret) {
-		dev_err(dev, "I2C adapter not suitable\n");
-		return -EIO;
-	}
-
-	sii902x = devm_kzalloc(dev, sizeof(*sii902x), GFP_KERNEL);
-	if (!sii902x)
-		return -ENOMEM;
-
-	sii902x->i2c = client;
-	sii902x->regmap = devm_regmap_init_i2c(client, &sii902x_regmap_config);
-	if (IS_ERR(sii902x->regmap))
-		return PTR_ERR(sii902x->regmap);
-
-	sii902x->reset_gpio = devm_gpiod_get_optional(dev, "reset",
-						      GPIOD_OUT_LOW);
-	if (IS_ERR(sii902x->reset_gpio)) {
-		dev_err(dev, "Failed to retrieve/request reset gpio: %ld\n",
-			PTR_ERR(sii902x->reset_gpio));
-		return PTR_ERR(sii902x->reset_gpio);
-	}
-
-	mutex_init(&sii902x->mutex);
-
 	sii902x_reset(sii902x);
 
 	ret = regmap_write(sii902x->regmap, SII902X_REG_TPI_RQB, 0x0);
@@ -1012,11 +984,11 @@ static int sii902x_probe(struct i2c_client *client,
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
@@ -1031,9 +1003,9 @@ static int sii902x_probe(struct i2c_client *client,
 
 	sii902x_audio_codec_init(sii902x, dev);
 
-	i2c_set_clientdata(client, sii902x);
+	i2c_set_clientdata(sii902x->i2c, sii902x);
 
-	sii902x->i2cmux = i2c_mux_alloc(client->adapter, dev,
+	sii902x->i2cmux = i2c_mux_alloc(sii902x->i2c->adapter, dev,
 					1, 0, I2C_MUX_GATE,
 					sii902x_i2c_bypass_select,
 					sii902x_i2c_bypass_deselect);
@@ -1044,6 +1016,43 @@ static int sii902x_probe(struct i2c_client *client,
 	return i2c_mux_add_adapter(sii902x->i2cmux, 0, 0, 0);
 }
 
+static int sii902x_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct sii902x *sii902x;
+	int ret;
+
+	ret = i2c_check_functionality(client->adapter,
+				      I2C_FUNC_SMBUS_BYTE_DATA);
+	if (!ret) {
+		dev_err(dev, "I2C adapter not suitable\n");
+		return -EIO;
+	}
+
+	sii902x = devm_kzalloc(dev, sizeof(*sii902x), GFP_KERNEL);
+	if (!sii902x)
+		return -ENOMEM;
+
+	sii902x->i2c = client;
+	sii902x->regmap = devm_regmap_init_i2c(client, &sii902x_regmap_config);
+	if (IS_ERR(sii902x->regmap))
+		return PTR_ERR(sii902x->regmap);
+
+	sii902x->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(sii902x->reset_gpio)) {
+		dev_err(dev, "Failed to retrieve/request reset gpio: %ld\n",
+			PTR_ERR(sii902x->reset_gpio));
+		return PTR_ERR(sii902x->reset_gpio);
+	}
+
+	mutex_init(&sii902x->mutex);
+
+	ret = sii902x_init(sii902x);
+	return ret;
+}
+
 static int sii902x_remove(struct i2c_client *client)
 
 {
-- 
2.26.2

