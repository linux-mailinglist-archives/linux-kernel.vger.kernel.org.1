Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF78F2979A3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 01:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758626AbgJWXXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 19:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758617AbgJWXX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 19:23:29 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B893BC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 16:23:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id b19so1846246pld.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 16:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LqIgRaytoZbiT4gC6MyyI2BK4NdVuPOlLPLkmdt1eMA=;
        b=gwjD4X8Mki63BN2D4Xi4bEL3G2Z3WH1tRFHUlg2WkNyo6JRvgInn4mgiTavn1Mq+bA
         XP/D9Wk9BLwyZY3ht9VVe4X3B5P8OShzgBleJaurJfOIjTqBqQEDg9pfNUQiZtxDNV+C
         td4dr+eedrB4uhJe5Atxl5vzUcIb39ZWphxNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LqIgRaytoZbiT4gC6MyyI2BK4NdVuPOlLPLkmdt1eMA=;
        b=riUnippo78RmStk4vc5cpw/v9l4K9UBp6vI57FbtxIVcSfiDDDYP4EgzKTrF2bR0cS
         TXssjHqdsOxlU2aiLoLBVBcRaWqeCCxiobBrZthBdOS7+GFqstXCOB2bx+GKqM9lZXkB
         7CiHUuKEv4d3wieZ2IrPz3dTqmFUOdhG+B8s/Ocx0hWsLZgsc3pYRst+bq4b9XRyY5hp
         rPZS2lBmyYiA0Xx8pgGfFqdkMuCmPqPFSOj8ucVHrIX+OMpRN6mhyAO6L96jMotLeDon
         vGHBGJb9PnwoX8P6ACn2xUOMB57zCuw/uqk7NdkoYG06DqUsyy9STefhLqIb/obK0M2V
         yndA==
X-Gm-Message-State: AOAM531Sj07RQ/S9aPq+Js+g+FS1Ucs+mjiZV1DmiC5EnfR5nM5P7YAC
        r7AE59caAZwgAfo9M2Qm2WA1Vg==
X-Google-Smtp-Source: ABdhPJzIm383ptlg08roMSJ1XKjvtA0rR3QBqnlBzKw07+Yae7oVDxqyQsKCN/4QzSxp7+TudQT7WA==
X-Received: by 2002:a17:90a:7f81:: with SMTP id m1mr5651943pjl.197.1603495409233;
        Fri, 23 Oct 2020 16:23:29 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id v17sm3789476pjy.40.2020.10.23.16.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 16:23:28 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jkosina@suse.cz, benjamin.tissoires@redhat.com,
        gregkh@linuxfoundation.org
Cc:     andrea@borgia.bo.it, kai.heng.feng@canonical.com,
        linux-input@vger.kernel.org, swboyd@chromium.org,
        hdegoede@redhat.com, Douglas Anderson <dianders@chromium.org>,
        Aaron Ma <aaron.ma@canonical.com>,
        Daniel Playfair Cal <daniel.playfair.cal@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, Pavel Balan <admin@kryma.net>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] HID: i2c-hid: Support the Goodix GT7375P touchscreen
Date:   Fri, 23 Oct 2020 16:22:54 -0700
Message-Id: <20201023162220.v2.3.Ied4ce10d229cd7c69abf13a0361ba0b8d82eb9c4@changeid>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201023162220.v2.1.I45b53fe84e2215946f900f5b28bab1aa9d029ac7@changeid>
References: <20201023162220.v2.1.I45b53fe84e2215946f900f5b28bab1aa9d029ac7@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Goodix GT7375P touchscreen uses i2c-hid so we can support it with
just a few changes to the i2c-hid driver.  Specifically this
touchscreen needs to control a reset GPIO during its power sequencing.

The Goodix timing diagram shows this:

         +----------------------------------
         |
AVDD ----+
               +------------------------------
         | (a) |
RESET ---------+
                     +-------------
               | (b) |
I2C comm OK ---------+

Where (a) is 10 ms and (b) is 120 ms.

While we could just add some properties and specify this generically
in the device tree, the guidance from the device tree maintainer is
that it's better to list the specific model and infer everything from
there.  Thus that's what this patch implements.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Use a separate compatible string for this new touchscreen.
- Get timings based on the compatible string.

 drivers/hid/i2c-hid/i2c-hid-core.c    | 50 ++++++++++++++++++++++++++-
 include/linux/platform_data/i2c-hid.h |  5 +++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 786e3e9af1c9..0b2cd78b05e1 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -71,6 +71,12 @@ do {									  \
 		dev_printk(KERN_DEBUG, &(ihid)->client->dev, fmt, ##arg); \
 } while (0)
 
+struct i2c_hid_match_data {
+	u16 hid_descriptor_address;
+	int post_power_delay_ms;
+	int post_gpio_reset_delay_ms;
+};
+
 struct i2c_hid_desc {
 	__le16 wHIDDescLength;
 	__le16 bcdVersion;
@@ -962,6 +968,21 @@ static inline void i2c_hid_acpi_enable_wakeup(struct device *dev) {}
 #endif
 
 #ifdef CONFIG_OF
+static bool i2c_hid_init_from_of_match(struct device *dev,
+				       struct i2c_hid_platform_data *pdata)
+{
+	const struct i2c_hid_match_data *match_data = device_get_match_data(dev);
+
+	if (!match_data)
+		return false;
+
+	pdata->hid_descriptor_address = match_data->hid_descriptor_address;
+	pdata->post_power_delay_ms = match_data->post_power_delay_ms;
+	pdata->post_gpio_reset_delay_ms = match_data->post_gpio_reset_delay_ms;
+
+	return true;
+}
+
 static int i2c_hid_of_probe(struct i2c_client *client,
 		struct i2c_hid_platform_data *pdata)
 {
@@ -969,6 +990,11 @@ static int i2c_hid_of_probe(struct i2c_client *client,
 	u32 val;
 	int ret;
 
+	/* Try getting everything based on the compatible string first */
+	if (i2c_hid_init_from_of_match(&client->dev, pdata))
+		return 0;
+
+	/* Fallback to getting hid-descr-addr from a property */
 	ret = of_property_read_u32(dev->of_node, "hid-descr-addr", &val);
 	if (ret) {
 		dev_err(&client->dev, "HID register address not provided\n");
@@ -984,8 +1010,15 @@ static int i2c_hid_of_probe(struct i2c_client *client,
 	return 0;
 }
 
+static const struct i2c_hid_match_data goodix_gt7375p_match_data = {
+	.hid_descriptor_address = 0x0001,
+	.post_power_delay_ms = 10,
+	.post_gpio_reset_delay_ms = 120,
+};
+
 static const struct of_device_id i2c_hid_of_match[] = {
-	{ .compatible = "hid-over-i2c" },
+	{ .compatible = "goodix,gt7375p", .data = &goodix_gt7375p_match_data },
+	{ .compatible = "hid-over-i2c" }, /* Deprecated */
 	{},
 };
 MODULE_DEVICE_TABLE(of, i2c_hid_of_match);
@@ -1053,6 +1086,12 @@ static int i2c_hid_probe(struct i2c_client *client,
 	ihid->pdata.supplies[0].supply = "vdd";
 	ihid->pdata.supplies[1].supply = "vddl";
 
+	/* Start out with reset asserted */
+	ihid->pdata.reset_gpio =
+		devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ihid->pdata.reset_gpio))
+		return PTR_ERR(ihid->pdata.reset_gpio);
+
 	ret = devm_regulator_bulk_get(&client->dev,
 				      ARRAY_SIZE(ihid->pdata.supplies),
 				      ihid->pdata.supplies);
@@ -1067,6 +1106,10 @@ static int i2c_hid_probe(struct i2c_client *client,
 	if (ihid->pdata.post_power_delay_ms)
 		msleep(ihid->pdata.post_power_delay_ms);
 
+	gpiod_set_value_cansleep(ihid->pdata.reset_gpio, 0);
+	if (ihid->pdata.post_gpio_reset_delay_ms)
+		msleep(ihid->pdata.post_gpio_reset_delay_ms);
+
 	i2c_set_clientdata(client, ihid);
 
 	ihid->client = client;
@@ -1163,6 +1206,7 @@ static int i2c_hid_remove(struct i2c_client *client)
 	if (ihid->bufsize)
 		i2c_hid_free_buffers(ihid);
 
+	gpiod_set_value_cansleep(ihid->pdata.reset_gpio, 1);
 	regulator_bulk_disable(ARRAY_SIZE(ihid->pdata.supplies),
 			       ihid->pdata.supplies);
 
@@ -1228,6 +1272,10 @@ static int i2c_hid_resume(struct device *dev)
 
 		if (ihid->pdata.post_power_delay_ms)
 			msleep(ihid->pdata.post_power_delay_ms);
+
+		gpiod_set_value_cansleep(ihid->pdata.reset_gpio, 0);
+		if (ihid->pdata.post_gpio_reset_delay_ms)
+			msleep(ihid->pdata.post_gpio_reset_delay_ms);
 	} else if (ihid->irq_wake_enabled) {
 		wake_status = disable_irq_wake(client->irq);
 		if (!wake_status)
diff --git a/include/linux/platform_data/i2c-hid.h b/include/linux/platform_data/i2c-hid.h
index c628bb5e1061..b2150223ffa6 100644
--- a/include/linux/platform_data/i2c-hid.h
+++ b/include/linux/platform_data/i2c-hid.h
@@ -12,6 +12,7 @@
 #ifndef __LINUX_I2C_HID_H
 #define __LINUX_I2C_HID_H
 
+#include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/types.h>
 
@@ -20,6 +21,8 @@
  * @hid_descriptor_address: i2c register where the HID descriptor is stored.
  * @supplies: regulators for powering on the device.
  * @post_power_delay_ms: delay after powering on before device is usable.
+ * @post_gpio_reset_delay_ms: delay after reset via GPIO.
+ * @reset_gpio: optional gpio to de-assert after post_power_delay_ms.
  *
  * Note that it is the responsibility of the platform driver (or the acpi 5.0
  * driver, or the flattened device tree) to setup the irq related to the gpio in
@@ -36,6 +39,8 @@ struct i2c_hid_platform_data {
 	u16 hid_descriptor_address;
 	struct regulator_bulk_data supplies[2];
 	int post_power_delay_ms;
+	int post_gpio_reset_delay_ms;
+	struct gpio_desc *reset_gpio;
 };
 
 #endif /* __LINUX_I2C_HID_H */
-- 
2.29.0.rc1.297.gfa9743e501-goog

