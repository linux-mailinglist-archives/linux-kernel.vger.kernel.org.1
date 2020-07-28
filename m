Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E831230D40
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 17:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbgG1PNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 11:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbgG1PN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:13:26 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB78C0619DA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:13:24 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id g19so9022290ioh.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p2EPkQyeRIURdgFyo/f9Dyfw352T0LaZ3N6QIzNpCZs=;
        b=iP7KyadUIXxYmoNuooKYjo+SoVnssM4rOi59DcS1slyy3GG9oYkwYcxTgd9PI5yseb
         TdLPTF8xJGxo9usrHSQLQ1dhArIkFuLraWhDhUBGLA198aAOSbZzoIhKHJ+WgF5YK74M
         RD2gD/UWn/+GEKEsaUJGqJ9H+Qj1GBkWE9g4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p2EPkQyeRIURdgFyo/f9Dyfw352T0LaZ3N6QIzNpCZs=;
        b=rQG5yqtEgnsj+1dI+sUzquYR4gO/GdHgva8ccUDS8X+Ft+xupIXXkaCM/WIhTCrVD3
         BHViQRRkmXHK/nhPOoGGJNbGoahZVnXCWKOoJSJ0rILc9Hz4NXRzdd5ke7lPhCbGYFqY
         SqFT2AeXoMx91bVrDtam8RObZvmCC6xn1NNB16tn0Je3swyUbK6hyaPrs1xvxngw6gSD
         +lfjHuuUGnp8eF7L/40RaQvZ1M1KF7dnHL5pzRyBHzRkG4ChQ5B7FpYoAuXvC1B+8D//
         BPC1+nSPZUacD8iJYit1Z4sLBwwgniBinUwKjeDRVlhAG/mAewPfZJvTfYQELleaYAq7
         zK7g==
X-Gm-Message-State: AOAM533nHeG798w2PJn9Sk4zbmV7LPCp5+DmPmKs+23Njj4jMDg7Q4zS
        kJvTgUCbjXVR8fB7Jk/TOMXFfg==
X-Google-Smtp-Source: ABdhPJxzZ7Hth+BmekoFZFUxXcp70VDLjpmGKdXidtvR/JmHNpe/hZNpt3veoSJcmHkF19zBP0Eo1g==
X-Received: by 2002:a05:6638:771:: with SMTP id y17mr32809735jad.96.1595949204155;
        Tue, 28 Jul 2020 08:13:24 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id q70sm6399781ili.49.2020.07.28.08.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 08:13:23 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH 12/15] iio: sx9310: Miscellaneous format fixes
Date:   Tue, 28 Jul 2020 09:12:55 -0600
Message-Id: <20200728091057.12.Iacab204f4164af12fa47206b98505bfbf8770cf3@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200728151258.1222876-1-campello@chromium.org>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miscellaneous format fixes throughout the whole file.

Signed-off-by: Daniel Campello <campello@chromium.org>
---

 drivers/iio/proximity/sx9310.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index ba383710ef0dcf..3f981d28ee4056 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -90,28 +90,21 @@
 #define   SX9310_REG_SAR_CTRL2_SAROFFSET_DEFAULT	0x3c
 
 #define SX9310_REG_SENSOR_SEL				0x30
-
 #define SX9310_REG_USE_MSB				0x31
 #define SX9310_REG_USE_LSB				0x32
-
 #define SX9310_REG_AVG_MSB				0x33
 #define SX9310_REG_AVG_LSB				0x34
-
 #define SX9310_REG_DIFF_MSB				0x35
 #define SX9310_REG_DIFF_LSB				0x36
-
 #define SX9310_REG_OFFSET_MSB				0x37
 #define SX9310_REG_OFFSET_LSB				0x38
-
 #define SX9310_REG_SAR_MSB				0x39
 #define SX9310_REG_SAR_LSB				0x3a
-
 #define SX9310_REG_I2C_ADDR				0x40
 #define SX9310_REG_PAUSE				0x41
 #define SX9310_REG_WHOAMI				0x42
 #define   SX9310_WHOAMI_VALUE				0x01
 #define   SX9311_WHOAMI_VALUE				0x02
-
 #define SX9310_REG_RESET				0x7f
 #define   SX9310_SOFT_RESET				0xde
 
@@ -402,7 +395,7 @@ static int sx9310_read_proximity(struct sx9310_data *data,
 		goto out_disable_irq;
 
 	*val = sign_extend32(be16_to_cpu(rawval),
-			     (chan->address == SX9310_REG_DIFF_MSB ? 11 : 15));
+			     chan->address == SX9310_REG_DIFF_MSB ? 11 : 15);
 
 	if (data->client->irq) {
 		ret = sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
@@ -432,8 +425,9 @@ static int sx9310_read_proximity(struct sx9310_data *data,
 static int sx9310_read_samp_freq(struct sx9310_data *data, int *val, int *val2)
 {
 	unsigned int regval;
-	int ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &regval);
+	int ret;
 
+	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &regval);
 	if (ret)
 		return ret;
 
@@ -518,10 +512,9 @@ static irqreturn_t sx9310_irq_handler(int irq, void *private)
 		iio_trigger_poll(data->trig);
 
 	/*
-	 * Even if no event is enabled, we need to wake the thread to
-	 * clear the interrupt state by reading SX9310_REG_IRQ_SRC.  It
-	 * is not possible to do that here because regmap_read takes a
-	 * mutex.
+	 * Even if no event is enabled, we need to wake the thread to clear the
+	 * interrupt state by reading SX9310_REG_IRQ_SRC.
+	 * It is not possible to do that here because regmap_read takes a mutex.
 	 */
 	return IRQ_WAKE_THREAD;
 }
@@ -638,7 +631,7 @@ static int sx9310_write_event_config(struct iio_dev *indio_dev,
 
 static struct attribute *sx9310_attributes[] = {
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
-	NULL,
+	NULL
 };
 
 static const struct attribute_group sx9310_attribute_group = {
@@ -969,7 +962,6 @@ static int __maybe_unused sx9310_suspend(struct device *dev)
 	mutex_lock(&data->mutex);
 	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0,
 			  &data->suspend_ctrl0);
-
 	if (ret)
 		goto out;
 
@@ -1015,21 +1007,21 @@ static const struct dev_pm_ops sx9310_pm_ops = {
 static const struct acpi_device_id sx9310_acpi_match[] = {
 	{ "STH9310", SX9310_WHOAMI_VALUE },
 	{ "STH9311", SX9311_WHOAMI_VALUE },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(acpi, sx9310_acpi_match);
 
 static const struct of_device_id sx9310_of_match[] = {
 	{ .compatible = "semtech,sx9310", (void *)SX9310_WHOAMI_VALUE },
 	{ .compatible = "semtech,sx9311", (void *)SX9311_WHOAMI_VALUE },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(of, sx9310_of_match);
 
 static const struct i2c_device_id sx9310_id[] = {
 	{ "sx9310", SX9310_WHOAMI_VALUE },
 	{ "sx9311", SX9311_WHOAMI_VALUE },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, sx9310_id);
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

