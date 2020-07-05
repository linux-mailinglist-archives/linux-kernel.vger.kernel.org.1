Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53D82149E3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 05:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgGEDrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jul 2020 23:47:49 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:59206 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbgGEDrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 23:47:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 9160720160D4;
        Sun,  5 Jul 2020 11:47:43 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IEW-Spsv79FO; Sun,  5 Jul 2020 11:47:43 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 72A772016B15;
        Sun,  5 Jul 2020 11:47:43 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 702DDC01F9E;
        Sun,  5 Jul 2020 11:47:43 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 64B952002E9; Sun,  5 Jul 2020 11:47:43 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] hwmon: shtc1: add support for device tree bindings
Date:   Sun,  5 Jul 2020 11:47:25 +0800
Message-Id: <20200705034727.1429-2-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200705034727.1429-1-chris.ruehl@gtsys.com.hk>
References: <20200705034727.1429-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for DTS bindings for the sensirion shtc1,shtw1 and shtc3.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 drivers/hwmon/shtc1.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/shtc1.c b/drivers/hwmon/shtc1.c
index a0078ccede03..61e9275eb666 100644
--- a/drivers/hwmon/shtc1.c
+++ b/drivers/hwmon/shtc1.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/platform_data/shtc1.h>
+#include <linux/of.h>
 
 /* commands (high precision mode) */
 static const unsigned char shtc1_cmd_measure_blocking_hpm[]    = { 0x7C, 0xA2 };
@@ -196,6 +197,7 @@ static int shtc1_probe(struct i2c_client *client,
 	enum shtcx_chips chip = id->driver_data;
 	struct i2c_adapter *adap = client->adapter;
 	struct device *dev = &client->dev;
+	struct device_node *np = dev->of_node;
 
 	if (!i2c_check_functionality(adap, I2C_FUNC_I2C)) {
 		dev_err(dev, "plain i2c transactions not supported\n");
@@ -233,8 +235,13 @@ static int shtc1_probe(struct i2c_client *client,
 	data->client = client;
 	data->chip = chip;
 
-	if (client->dev.platform_data)
+	if (np) {
+		data->setup.blocking_io = of_property_read_bool(np, "sensirion,blocking_io");
+		data->setup.high_precision = of_property_read_bool(np, "sensicon,low_precision");
+	}
+	else if (client->dev.platform_data)
 		data->setup = *(struct shtc1_platform_data *)dev->platform_data;
+
 	shtc1_select_command(data);
 	mutex_init(&data->update_lock);
 
@@ -257,8 +264,19 @@ static const struct i2c_device_id shtc1_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, shtc1_id);
 
+static const struct of_device_id shtc1_of_match[] = {
+	{ .compatible = "sensirion,shtc1" },
+	{ .compatible = "sensirion,shtw1" },
+	{ .compatible = "sensirion,shtc3" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, shtc1_of_match);
+
 static struct i2c_driver shtc1_i2c_driver = {
-	.driver.name  = "shtc1",
+	.driver = {
+		.name = "shtc1",
+		.of_match_table = shtc1_of_match,
+	},
 	.probe        = shtc1_probe,
 	.id_table     = shtc1_id,
 };
-- 
2.20.1

