Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E8C23B107
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 01:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgHCXmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 19:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbgHCXmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:42:10 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE634C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 16:42:09 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id v6so25113132iow.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cgcuBq5jHSYe9tQ6i4PG5OfxXeQhbT6N/XwGKE+NjOI=;
        b=U2yUHmHhcvu/mBtiyhM1jv7Ry0ocXHKyTp5EcP7Z3OwBPyxmH0aaBBawIEG1Zp+F/5
         CoU5KUTT8loPxM5XOqUQpvUMbby0MmojztMTziPDZVRth8V6jRbvql3ZlgNjKVdQkWAw
         ps43BRoag7INeMVdoGvm3MVp6afTydpV5cQow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cgcuBq5jHSYe9tQ6i4PG5OfxXeQhbT6N/XwGKE+NjOI=;
        b=EUbUiF2tFUxdbFuR+ZzlTPZ2MaJ03gNKYOQj1E1DWjVAo8cNGHKI95rs6MHymI0kFT
         Vv2bmryZMEoe7KW8Zn4iSHt3g8YngqJ14Go19Mzza6jr7WkQd154oOJ79V8mo7gpVjxj
         pkByqnT7SnFQuJIo/8JZtvBJTHnkC8iBS+RK5a66xn9IJ6PBDkOW6aWVuoSAy1VzapaO
         vZw03CQ2qXmt3vS5cYg+xgm9L25jE0welB53TgMB63emuPFfjTfRgbKfsSxQ7w5Z1sbV
         x940PaTIZ0mp7rZjggjLCJndE9IKQYNUP5t721ZSmk3WGEcr5EEiWJpKxHFAaajjYuAd
         1idw==
X-Gm-Message-State: AOAM532pMpJOdwOxFPWYU2wFdAAe8JGcKCt/j/ekDwW6bJve4W0ZMscY
        SASwRuavJB1jCe4MxICmhx86+A==
X-Google-Smtp-Source: ABdhPJwv2fTnB+Rq2fK6YsQLu1jLeYv1LFlkDxw2Ajc1fqC4cDIIKUKd5EiTfyJkEJ7JRtntY3ZkEw==
X-Received: by 2002:a02:84c1:: with SMTP id f59mr2565425jai.106.1596498129388;
        Mon, 03 Aug 2020 16:42:09 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id g2sm5468435ioe.4.2020.08.03.16.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:42:09 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v4 10/15] iio: sx9310: Simplify error return handling
Date:   Mon,  3 Aug 2020 17:41:49 -0600
Message-Id: <20200803131544.v4.10.I071b118136317d3ff77fc598079f21e4ed0e347f@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803234154.320400-1-campello@chromium.org>
References: <20200803234154.320400-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checks for non-zero return values to signal error conditions.

Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/iio/proximity/sx9310.c | 56 +++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index fa5009e39605ca..563ab08de37051 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -346,7 +346,7 @@ static int sx9310_read_prox_data(struct sx9310_data *data,
 	int ret;
 
 	ret = regmap_write(data->regmap, SX9310_REG_SENSOR_SEL, chan->channel);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	return regmap_bulk_read(data->regmap, chan->address, val, sizeof(*val));
@@ -362,7 +362,7 @@ static int sx9310_wait_for_sample(struct sx9310_data *data)
 	unsigned int val;
 
 	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &val);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	val = FIELD_GET(SX9310_REG_PROX_CTRL0_SCANPERIOD_MASK, val);
@@ -375,17 +375,17 @@ static int sx9310_wait_for_sample(struct sx9310_data *data)
 static int sx9310_read_proximity(struct sx9310_data *data,
 				 const struct iio_chan_spec *chan, int *val)
 {
-	int ret = 0;
+	int ret;
 	__be16 rawval;
 
 	mutex_lock(&data->mutex);
 
 	ret = sx9310_get_read_channel(data, chan->channel);
-	if (ret < 0)
+	if (ret)
 		goto out;
 
 	ret = sx9310_enable_irq(data, SX9310_CONVDONE_IRQ);
-	if (ret < 0)
+	if (ret)
 		goto out_put_channel;
 
 	mutex_unlock(&data->mutex);
@@ -399,22 +399,22 @@ static int sx9310_read_proximity(struct sx9310_data *data,
 
 	mutex_lock(&data->mutex);
 
-	if (ret < 0)
+	if (ret)
 		goto out_disable_irq;
 
 	ret = sx9310_read_prox_data(data, chan, &rawval);
-	if (ret < 0)
+	if (ret)
 		goto out_disable_irq;
 
 	*val = sign_extend32(be16_to_cpu(rawval),
 			     (chan->address == SX9310_REG_DIFF_MSB ? 11 : 15));
 
 	ret = sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
-	if (ret < 0)
+	if (ret)
 		goto out_put_channel;
 
 	ret = sx9310_put_read_channel(data, chan->channel);
-	if (ret < 0)
+	if (ret)
 		goto out;
 
 	mutex_unlock(&data->mutex);
@@ -436,7 +436,7 @@ static int sx9310_read_samp_freq(struct sx9310_data *data, int *val, int *val2)
 	unsigned int regval;
 	int ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &regval);
 
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	regval = FIELD_GET(SX9310_REG_PROX_CTRL0_SCANPERIOD_MASK, regval);
@@ -538,7 +538,7 @@ static void sx9310_push_events(struct iio_dev *indio_dev)
 
 	/* Read proximity state on all channels */
 	ret = regmap_read(data->regmap, SX9310_REG_STAT0, &val);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(&data->client->dev, "i2c transfer error in irq\n");
 		return;
 	}
@@ -572,7 +572,7 @@ static irqreturn_t sx9310_irq_thread_handler(int irq, void *private)
 	mutex_lock(&data->mutex);
 
 	ret = regmap_read(data->regmap, SX9310_REG_IRQ_SRC, &val);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(&data->client->dev, "i2c transfer error in irq\n");
 		goto out;
 	}
@@ -615,20 +615,20 @@ static int sx9310_write_event_config(struct iio_dev *indio_dev,
 	mutex_lock(&data->mutex);
 	if (state) {
 		ret = sx9310_get_event_channel(data, chan->channel);
-		if (ret < 0)
+		if (ret)
 			goto out_unlock;
 		if (!(data->chan_event & ~BIT(chan->channel))) {
 			ret = sx9310_enable_irq(data, eventirq);
-			if (ret < 0)
+			if (ret)
 				sx9310_put_event_channel(data, chan->channel);
 		}
 	} else {
 		ret = sx9310_put_event_channel(data, chan->channel);
-		if (ret < 0)
+		if (ret)
 			goto out_unlock;
 		if (!data->chan_event) {
 			ret = sx9310_disable_irq(data, eventirq);
-			if (ret < 0)
+			if (ret)
 				sx9310_get_event_channel(data, chan->channel);
 		}
 	}
@@ -667,7 +667,7 @@ static int sx9310_set_trigger_state(struct iio_trigger *trig, bool state)
 		ret = sx9310_enable_irq(data, SX9310_CONVDONE_IRQ);
 	else if (!data->chan_read)
 		ret = sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
-	if (ret < 0)
+	if (ret)
 		goto out;
 
 	data->trigger_enabled = state;
@@ -696,7 +696,7 @@ static irqreturn_t sx9310_trigger_handler(int irq, void *private)
 			 indio_dev->masklength) {
 		ret = sx9310_read_prox_data(data, &indio_dev->channels[bit],
 					    &val);
-		if (ret < 0)
+		if (ret)
 			goto out;
 
 		data->buffer.channels[i++] = val;
@@ -803,13 +803,13 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
 	unsigned int ctrl0;
 
 	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &ctrl0);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	/* run the compensation phase on all channels */
 	ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
 			   ctrl0 | SX9310_REG_PROX_CTRL0_SENSOREN_MASK);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ret = regmap_read_poll_timeout(data->regmap, SX9310_REG_STAT1, val,
@@ -835,21 +835,21 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
 	unsigned int i, val;
 
 	ret = regmap_write(data->regmap, SX9310_REG_RESET, SX9310_SOFT_RESET);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	usleep_range(1000, 2000); /* power-up time is ~1ms. */
 
 	/* Clear reset interrupt state by reading SX9310_REG_IRQ_SRC. */
 	ret = regmap_read(data->regmap, SX9310_REG_IRQ_SRC, &val);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	/* Program some sane defaults. */
 	for (i = 0; i < ARRAY_SIZE(sx9310_default_regs); i++) {
 		initval = &sx9310_default_regs[i];
 		ret = regmap_write(data->regmap, initval->reg, initval->def);
-		if (ret < 0)
+		if (ret)
 			return ret;
 	}
 
@@ -903,14 +903,14 @@ static int sx9310_probe(struct i2c_client *client)
 		return PTR_ERR(data->regmap);
 
 	ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &data->whoami);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(&client->dev, "error in reading WHOAMI register: %d",
 			ret);
 		return ret;
 	}
 
 	ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, data->whoami);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(&client->dev));
@@ -922,7 +922,7 @@ static int sx9310_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, indio_dev);
 
 	ret = sx9310_init_device(indio_dev);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	if (client->irq) {
@@ -931,7 +931,7 @@ static int sx9310_probe(struct i2c_client *client)
 						sx9310_irq_thread_handler,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 						"sx9310_event", indio_dev);
-		if (ret < 0)
+		if (ret)
 			return ret;
 
 		data->trig =
@@ -953,7 +953,7 @@ static int sx9310_probe(struct i2c_client *client)
 					      iio_pollfunc_store_time,
 					      sx9310_trigger_handler,
 					      &sx9310_buffer_setup_ops);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	return devm_iio_device_register(&client->dev, indio_dev);
-- 
2.28.0.163.g6104cc2f0b6-goog

