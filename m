Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F3F213272
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 05:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgGCD5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 23:57:21 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:51998 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgGCD5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 23:57:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id D4D0320139A6;
        Fri,  3 Jul 2020 11:49:03 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P5YtLoJ427bH; Fri,  3 Jul 2020 11:49:03 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id BBEBD20139A9;
        Fri,  3 Jul 2020 11:49:03 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id B92D2C01B7B;
        Fri,  3 Jul 2020 11:49:03 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id B0B042002E9; Fri,  3 Jul 2020 11:49:03 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwmon: shtc1: add support for device tree bindings
Date:   Fri,  3 Jul 2020 11:48:54 +0800
Message-Id: <20200703034856.12846-2-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703034856.12846-1-chris.ruehl@gtsys.com.hk>
References: <20200703034856.12846-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for DTS bindings to the shtc driver, use CONFIG_OF
to compile in the code if needed.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 drivers/hwmon/shtc1.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/hwmon/shtc1.c b/drivers/hwmon/shtc1.c
index a0078ccede03..3bcabc1cbce8 100644
--- a/drivers/hwmon/shtc1.c
+++ b/drivers/hwmon/shtc1.c
@@ -14,6 +14,9 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/platform_data/shtc1.h>
+#ifdef CONFIG_OF
+#include <linux/of.h>
+#endif
 
 /* commands (high precision mode) */
 static const unsigned char shtc1_cmd_measure_blocking_hpm[]    = { 0x7C, 0xA2 };
@@ -196,6 +199,10 @@ static int shtc1_probe(struct i2c_client *client,
 	enum shtcx_chips chip = id->driver_data;
 	struct i2c_adapter *adap = client->adapter;
 	struct device *dev = &client->dev;
+#ifdef CONFIG_OF
+	struct device_node *np = dev->of_node;
+	u8 value;
+#endif
 
 	if (!i2c_check_functionality(adap, I2C_FUNC_I2C)) {
 		dev_err(dev, "plain i2c transactions not supported\n");
@@ -235,6 +242,20 @@ static int shtc1_probe(struct i2c_client *client,
 
 	if (client->dev.platform_data)
 		data->setup = *(struct shtc1_platform_data *)dev->platform_data;
+
+#ifdef CONFIG_OF
+	if (np) {
+		if (of_property_read_bool(np, "sensirion,blocking_io")) {
+			of_property_read_u8(np, "sensirion,blocking_io", &value);
+			data->setup.blocking_io = (value > 0) ? true : false;
+		}
+		if (of_property_read_bool(np, "sensicon,high_precision")) {
+			of_property_read_u8(np, "sensirion,high_precision", &value);
+			data->setup.high_precision = (value > 0) ? true : false;
+		}
+	}
+#endif
+
 	shtc1_select_command(data);
 	mutex_init(&data->update_lock);
 
@@ -257,6 +278,15 @@ static const struct i2c_device_id shtc1_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, shtc1_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id shtc1_of_match[] = {
+	{ .compatible = "sensirion,shtc1" },
+	{ .compatible = "sensirion,shtw1" },
+	{ .compatible = "sensirion,shtc3" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, shtc1_of_match);
+#endif
 static struct i2c_driver shtc1_i2c_driver = {
 	.driver.name  = "shtc1",
 	.probe        = shtc1_probe,
-- 
2.20.1

