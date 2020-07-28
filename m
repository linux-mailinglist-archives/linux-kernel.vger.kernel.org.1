Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06A62315FC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 01:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbgG1XFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 19:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730125AbgG1XFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 19:05:45 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB711C0619D4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 16:05:44 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id g19so10492680ioh.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 16:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w9NYXEErfPlhUgTVpphUm6AV/grBnexP1fodtrhxNXw=;
        b=XIN03hwwvE69sJDFLKE1l1w88A9pUCi5GPv807heBJI0WEPBh1HhZZZlDj58prVFfx
         duK57zkihtaLHvS9WOu9I1gjC85IiIEbNBwX4/dxkmp/e0q5fmZ0wf+mxw5v/D93XXLo
         t88w7qsMaKOu+JT5E1k/hqUMNRBvQWNKDl7ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w9NYXEErfPlhUgTVpphUm6AV/grBnexP1fodtrhxNXw=;
        b=IPsNSeDyZ/4T5G9HkeY86aemKzWqn1QP+lLMGLC/H5vuPnjvzgxUv+7WsqK2NUb9vj
         LCriU6ZN12LqqTIsL7gpSeZWuIjPqYUtY7A4n6eeF5o75gZxs1Q4ddAFWWD+lM7px+3H
         Ld18LAx5zDkRWNqrynOC4mj8s5FUljfl7GHH6/EME3/BqameOHvUAq2JfsgDljwftxw+
         CqSBRfvPuc0uk9kflnBq/s7RB03LG7juPSC10FUdmo/bqZulMxlc/aiyDOVUvhKaYRS0
         3dTYZMbKZDGvyPfEAphT2IbVd0DLRcvGDdJJPiw94gv6ooVadT4kccn6zS9gdtcQK7y5
         MZ5A==
X-Gm-Message-State: AOAM530rbVy4vdJnK+XH9vatBqdliULHrWjlA+wvqnB6KL0P/tFiYmDE
        MtJhqR/BM16k4g2vL+h315XznQ==
X-Google-Smtp-Source: ABdhPJxEN2nczGNxV19TkDGq7QzPu0aAo8UERqBuaHBzN3yS9BhqFA05M8Xc04vq5wkVGkWcCRC4Ww==
X-Received: by 2002:a02:9a05:: with SMTP id b5mr5000537jal.123.1595977544172;
        Tue, 28 Jul 2020 16:05:44 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id w10sm148945ilo.10.2020.07.28.16.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 16:05:43 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH v2 10/14] iio: sx9310: Simplify error return handling
Date:   Tue, 28 Jul 2020 17:05:16 -0600
Message-Id: <20200728170317.v2.10.I071b118136317d3ff77fc598079f21e4ed0e347f@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200728230520.2011240-1-campello@chromium.org>
References: <20200728151258.1222876-1-campello@chromium.org>
 <20200728230520.2011240-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checks for non-zero return values to signal error conditions.

Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v2: None

 drivers/iio/proximity/sx9310.c | 52 +++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 964fae90fefc25..f43ca6a0acf2fc 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -339,7 +339,7 @@ static int sx9310_read_prox_data(struct sx9310_data *data,
 	int ret;
 
 	ret = regmap_write(data->regmap, SX9310_REG_SENSOR_SEL, chan->channel);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	return regmap_bulk_read(data->regmap, chan->address, val, sizeof(*val));
@@ -355,7 +355,7 @@ static int sx9310_wait_for_sample(struct sx9310_data *data)
 	unsigned int val;
 
 	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &val);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	val = (val & SX9310_REG_PROX_CTRL0_SCANPERIOD_MASK) >>
@@ -369,13 +369,13 @@ static int sx9310_wait_for_sample(struct sx9310_data *data)
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
 
 	if (data->client->irq) {
@@ -395,11 +395,11 @@ static int sx9310_read_proximity(struct sx9310_data *data,
 
 	mutex_lock(&data->mutex);
 
-	if (ret < 0)
+	if (ret)
 		goto out_disable_irq;
 
 	ret = sx9310_read_prox_data(data, chan, &rawval);
-	if (ret < 0)
+	if (ret)
 		goto out_disable_irq;
 
 	*val = sign_extend32(be16_to_cpu(rawval),
@@ -412,7 +412,7 @@ static int sx9310_read_proximity(struct sx9310_data *data,
 	}
 
 	ret = sx9310_put_read_channel(data, chan->channel);
-	if (ret < 0)
+	if (ret)
 		goto out;
 
 	mutex_unlock(&data->mutex);
@@ -435,7 +435,7 @@ static int sx9310_read_samp_freq(struct sx9310_data *data, int *val, int *val2)
 	unsigned int regval;
 	int ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &regval);
 
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	regval = (regval & SX9310_REG_PROX_CTRL0_SCANPERIOD_MASK) >>
@@ -537,7 +537,7 @@ static void sx9310_push_events(struct iio_dev *indio_dev)
 
 	/* Read proximity state on all channels */
 	ret = regmap_read(data->regmap, SX9310_REG_STAT0, &val);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(&data->client->dev, "i2c transfer error in irq\n");
 		return;
 	}
@@ -571,7 +571,7 @@ static irqreturn_t sx9310_irq_thread_handler(int irq, void *private)
 	mutex_lock(&data->mutex);
 
 	ret = regmap_read(data->regmap, SX9310_REG_IRQ_SRC, &val);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(&data->client->dev, "i2c transfer error in irq\n");
 		goto out;
 	}
@@ -614,20 +614,20 @@ static int sx9310_write_event_config(struct iio_dev *indio_dev,
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
@@ -666,7 +666,7 @@ static int sx9310_set_trigger_state(struct iio_trigger *trig, bool state)
 		ret = sx9310_enable_irq(data, SX9310_CONVDONE_IRQ);
 	else if (!data->chan_read)
 		ret = sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
-	if (ret < 0)
+	if (ret)
 		goto out;
 
 	data->trigger_enabled = state;
@@ -695,7 +695,7 @@ static irqreturn_t sx9310_trigger_handler(int irq, void *private)
 			 indio_dev->masklength) {
 		ret = sx9310_read_prox_data(data, &indio_dev->channels[bit],
 					    &val);
-		if (ret < 0)
+		if (ret)
 			goto out;
 
 		data->buffer[i++] = val;
@@ -802,13 +802,13 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
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
@@ -834,21 +834,21 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
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
 
@@ -902,14 +902,14 @@ static int sx9310_probe(struct i2c_client *client)
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
@@ -921,7 +921,7 @@ static int sx9310_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, indio_dev);
 
 	ret = sx9310_init_device(indio_dev);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	if (client->irq) {
@@ -930,7 +930,7 @@ static int sx9310_probe(struct i2c_client *client)
 						sx9310_irq_thread_handler,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 						"sx9310_event", indio_dev);
-		if (ret < 0)
+		if (ret)
 			return ret;
 
 		data->trig =
@@ -952,7 +952,7 @@ static int sx9310_probe(struct i2c_client *client)
 					      iio_pollfunc_store_time,
 					      sx9310_trigger_handler,
 					      &sx9310_buffer_setup_ops);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	return devm_iio_device_register(&client->dev, indio_dev);
-- 
2.28.0.163.g6104cc2f0b6-goog

