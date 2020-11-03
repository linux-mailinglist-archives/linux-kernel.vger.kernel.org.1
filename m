Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94532A47DA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 15:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgKCOSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 09:18:51 -0500
Received: from jax4mhob21.registeredsite.com ([64.69.218.109]:59124 "EHLO
        jax4mhob21.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729485AbgKCORw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:17:52 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.206])
        by jax4mhob21.registeredsite.com (8.14.4/8.14.4) with ESMTP id 0A3EHn1Z094558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Tue, 3 Nov 2020 09:17:49 -0500
Received: (qmail 23793 invoked by uid 0); 3 Nov 2020 14:17:49 -0000
X-TCPREMOTEIP: 83.128.90.119
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@83.128.90.119)
  by 0 with ESMTPA; 3 Nov 2020 14:17:49 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-clk@vger.kernel.org
Cc:     sboyd@kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] clk-si5341: Support NVM programming through sysfs
Date:   Tue,  3 Nov 2020 15:17:41 +0100
Message-Id: <20201103141741.2511-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export an attribute program_nvm_bank that when read reports the current
bank value. To program the chip's current state into NVM, write the
magic value 0xC7 into this attribute.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/clk/clk-si5341.c | 73 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index e0446e66fa64..4e025a5ea2b7 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -92,6 +92,9 @@ struct clk_si5341_output_config {
 #define SI5341_PN_BASE		0x0002
 #define SI5341_DEVICE_REV	0x0005
 #define SI5341_STATUS		0x000C
+#define SI5341_ACTIVE_NVM_BANK	0x00E2
+#define SI5341_NVM_WRITE	0x00E3
+#define SI5341_DEVICE_READY	0x00FE
 #define SI5341_SOFT_RST		0x001C
 #define SI5341_IN_SEL		0x0021
 #define SI5341_XAXB_CFG		0x090E
@@ -144,6 +147,9 @@ struct clk_si5341_output_config {
 #define SI5341_OUT_CFG_OE		BIT(1)
 #define SI5341_OUT_CFG_RDIV_FORCE2	BIT(2)
 
+/* Programming NVM, magic value to write to program the NVM */
+#define SI5341_SI5341_NVM_WRITE_COOKIE	0xC7
+
 /* Static configuration (to be moved to firmware) */
 struct si5341_reg_default {
 	u16 address;
@@ -1199,6 +1205,69 @@ static const struct regmap_config si5341_regmap_config = {
 	.volatile_table = &si5341_regmap_volatile,
 };
 
+static ssize_t program_nvm_bank_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct clk_si5341 *data = i2c_get_clientdata(client);
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(data->regmap, SI5341_ACTIVE_NVM_BANK, &regval);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%#x\n", regval);
+}
+
+static ssize_t program_nvm_bank_store(struct device *dev,
+	struct device_attribute *attr,
+	const char *buf,
+	size_t count)
+{
+	struct clk_si5341 *data = i2c_get_clientdata(to_i2c_client(dev));
+	int ret;
+	unsigned int value;
+	unsigned int timeout;
+
+	ret = kstrtouint(buf, 0, &value);
+	if (ret < 0)
+		return ret;
+
+	/* Write the magic value to this attribute to program the NVM */
+	if (value != SI5341_SI5341_NVM_WRITE_COOKIE)
+		return -EINVAL;
+
+	ret = regmap_write(data->regmap, SI5341_NVM_WRITE,
+			SI5341_SI5341_NVM_WRITE_COOKIE);
+	if (ret)
+		return ret;
+
+	/* Wait for SI5341_DEVICE_READY register to become 0x0f */
+	for (timeout = 10000; timeout; --timeout) {
+		ret = regmap_read(data->regmap, SI5341_DEVICE_READY, &value);
+		if (ret)
+			return ret;
+
+		if (value == 0x0f)
+			break;
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(program_nvm_bank);
+
+static struct attribute *si5341_sysfs_entries[] = {
+	&dev_attr_program_nvm_bank.attr,
+	NULL,
+};
+
+static struct attribute_group si5341_attr_group = {
+	.name	= NULL,	/* put in device directory */
+	.attrs	= si5341_sysfs_entries,
+};
+
 static int si5341_dt_parse_dt(struct i2c_client *client,
 	struct clk_si5341_output_config *config)
 {
@@ -1544,6 +1613,10 @@ static int si5341_probe(struct i2c_client *client,
 	for (i = 0; i < data->num_synth; ++i)
 		 devm_kfree(&client->dev, (void *)synth_clock_names[i]);
 
+	err = sysfs_create_group(&client->dev.kobj, &si5341_attr_group);
+	if (err)
+		dev_err(&client->dev, "failed to create sysfs entries\n");
+
 	return 0;
 }
 
-- 
2.17.1

