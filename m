Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C87123B163
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 01:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgHCX6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 19:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbgHCX6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:58:32 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53C2C0617A9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 16:58:30 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id w12so26785718iom.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nmtj0sseyg7k7nwiC3ScnQV6X/DUHeFjJUChBIXHSNQ=;
        b=WWduK9sQnxNNP3bdn7u4Rfx2zvEH8bs68k055k1JiwDuHJokBB5Vq3VDi2BfcpKV/T
         HsgYhfTh/25Ny9wHWDLkwd8Vi6DWvHFTomF69HcnZ8GtM9kz4taQLh9igdElZJ2ehfsr
         wSbFFqw/U/W1nDKmDmovKOyvwcsGBebOWHB3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nmtj0sseyg7k7nwiC3ScnQV6X/DUHeFjJUChBIXHSNQ=;
        b=qpgU/xUon7rpyEOR0Rx2rZcRv0W/V7IOv1W7cnXMLNStmqKetB/DF4mOjOMKJvlM8Q
         i+tc2erEg/20fYzH1wPKFZ7HL/i15PbKXGdQSusoLA2T0bP69k8L8oMU5e1hjYVPOe8X
         xsAu30oNs2oFc34V6NR/ELPOhcpWWbNFU06fz8FHjS8UefKn9zVcFCYxXDgARTih1bs+
         /uyeG5d3k+MjKcsQqXdNQOZS8iSteEgfMjkJCT1Smz9ttk1PWp7ilURdAXuDSsGNSAvo
         DoKYlthVnFWmF4J8gaX9hWb4WY37YaJTygH1EvJRFVqelaG4MaNJgkxPqpQgNd+8bf7P
         /icA==
X-Gm-Message-State: AOAM5316tuOTgDMbX7GQqQS/qK+UecKyKhIRoyM18UYAwiD8UuDhTgyw
        cc7DRtC3rQGXUoLkZN1RCt6Vfg==
X-Google-Smtp-Source: ABdhPJzIVeiiDh2BWRjrdbBkI52iMdmd5Dd4GVE1yS1GHTdhX4z94WqIQHI8nnWniLxUUXz/0MexAw==
X-Received: by 2002:a6b:8dd2:: with SMTP id p201mr2461834iod.152.1596499110322;
        Mon, 03 Aug 2020 16:58:30 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id x185sm11075992iof.41.2020.08.03.16.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:58:29 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v5 11/15] iio: sx9310: Use variable to hold &client->dev
Date:   Mon,  3 Aug 2020 17:58:11 -0600
Message-Id: <20200803175559.v5.11.If9d9c0fe089e43ea2dbc7900b6d61cd05c66f1f7@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803235815.778997-1-campello@chromium.org>
References: <20200803235815.778997-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improves readability by storing &client->dev in a local variable.

Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
 - Added '\n' to dev_err()

 drivers/iio/proximity/sx9310.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index adb707e2d79612..589052d2d1146e 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -887,11 +887,12 @@ static int sx9310_set_indio_dev_name(struct device *dev,
 static int sx9310_probe(struct i2c_client *client)
 {
 	int ret;
+	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct sx9310_data *data;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
-	if (indio_dev == NULL)
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
@@ -905,17 +906,16 @@ static int sx9310_probe(struct i2c_client *client)
 
 	ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &data->whoami);
 	if (ret) {
-		dev_err(&client->dev, "error in reading WHOAMI register: %d",
-			ret);
+		dev_err(dev, "error in reading WHOAMI register: %d\n", ret);
 		return ret;
 	}
 
-	ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, data->whoami);
+	ret = sx9310_set_indio_dev_name(dev, indio_dev, data->whoami);
 	if (ret)
 		return ret;
 
-	ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(&client->dev));
-	indio_dev->dev.parent = &client->dev;
+	ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(dev));
+	indio_dev->dev.parent = dev;
 	indio_dev->channels = sx9310_channels;
 	indio_dev->num_channels = ARRAY_SIZE(sx9310_channels);
 	indio_dev->info = &sx9310_info;
@@ -927,7 +927,7 @@ static int sx9310_probe(struct i2c_client *client)
 		return ret;
 
 	if (client->irq) {
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
+		ret = devm_request_threaded_irq(dev, client->irq,
 						sx9310_irq_handler,
 						sx9310_irq_thread_handler,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
@@ -935,29 +935,29 @@ static int sx9310_probe(struct i2c_client *client)
 		if (ret)
 			return ret;
 
-		data->trig =
-			devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
-					       indio_dev->name, indio_dev->id);
+		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+						    indio_dev->name,
+						    indio_dev->id);
 		if (!data->trig)
 			return -ENOMEM;
 
-		data->trig->dev.parent = &client->dev;
+		data->trig->dev.parent = dev;
 		data->trig->ops = &sx9310_trigger_ops;
 		iio_trigger_set_drvdata(data->trig, indio_dev);
 
-		ret = devm_iio_trigger_register(&client->dev, data->trig);
+		ret = devm_iio_trigger_register(dev, data->trig);
 		if (ret)
 			return ret;
 	}
 
-	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      sx9310_trigger_handler,
 					      &sx9310_buffer_setup_ops);
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&client->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int __maybe_unused sx9310_suspend(struct device *dev)
-- 
2.28.0.163.g6104cc2f0b6-goog

