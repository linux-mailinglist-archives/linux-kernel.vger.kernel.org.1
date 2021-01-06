Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD78C2EBA53
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 08:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbhAFHLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 02:11:36 -0500
Received: from atl4mhfb01.myregisteredsite.com ([209.17.115.55]:39822 "EHLO
        atl4mhfb01.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbhAFHLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:11:35 -0500
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jan 2021 02:11:34 EST
Received: from jax4mhob04.registeresite.com (jax4mhob04.myregisteredsite.com [64.69.218.84])
        by atl4mhfb01.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 10675c6M021167
        for <linux-kernel@vger.kernel.org>; Wed, 6 Jan 2021 02:05:39 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.206])
        by jax4mhob04.registeresite.com (8.14.4/8.14.4) with ESMTP id 10674fHR016558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 6 Jan 2021 02:04:42 -0500
Received: (qmail 25187 invoked by uid 0); 6 Jan 2021 07:04:41 -0000
X-TCPREMOTEIP: 83.128.90.119
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@83.128.90.119)
  by 0 with ESMTPA; 6 Jan 2021 07:04:41 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH v2] clk-si5341: Support NVM programming through sysfs
Date:   Wed,  6 Jan 2021 08:04:36 +0100
Message-Id: <20210106070436.14870-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export an attribute program_nvm_bank that when read reports the current
bank value. To program the chip's current state into NVM, write the
magic value 0xC7 into this attribute.

This allows the clock chip to be programmed "in system" to reduce boot
time by 300ms and allows the clock to be up and running before the
kernel boots (e.g. for bootloader usage). Some vendors initialize PLLs
only in their bootloader and thus need the clock running at boot.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
v2: Add description in Documentation/ABI/
    Use regmap_read_poll_timeout()
    Abort on sysfs_create_group error

 .../ABI/testing/sysfs-devices-clk-si5341      | 24 +++++++
 drivers/clk/clk-si5341.c                      | 68 +++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-clk-si5341

diff --git a/Documentation/ABI/testing/sysfs-devices-clk-si5341 b/Documentation/ABI/testing/sysfs-devices-clk-si5341
new file mode 100644
index 000000000000..7243b82a3729
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-clk-si5341
@@ -0,0 +1,24 @@
+What:		/sys/bus/i2c/devices/.../clk-si534*/program_nvm_bank
+Date:		Jan 2021
+KernelVersion:	5.12
+Contact:	Mike Looijmans <mike.looijmans@topic.nl>
+Description:	Allows programming the NVM memory of the clock chip, so it boots
+		up in the current configuration. This saves boot time (300ms
+		clock initialization) and allows the clock to be available
+		before the kernel boots (e.g. u-boot ethernet clock).
+
+		Write the magic value 0xc7 to this attribute to program the
+		chip's current settings into its NVM storage. This magic value
+		is taken from the datasheet, it's the same value that must be
+		written to the hardware to program it. Programming can only be
+		done twice in the lifetime of the chip.
+
+		Read the value to check the state of the chip. This returns the
+		raw value as read from the hardware. Possible values:
+		0x03: Not programmed
+		0x0f: Programmed once
+		0x3f: Programmed twice, can no longer be programmed
+
+Users:		User space applications for embedded boards equipped with one
+		or more Si534x programmable clock devices. Would typically be
+		used at the end of production stages.
diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index e0446e66fa64..836af718eed0 100644
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
@@ -1199,6 +1205,64 @@ static const struct regmap_config si5341_regmap_config = {
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
+	ret = regmap_read_poll_timeout(data->regmap, SI5341_DEVICE_READY, value,
+				       value == 0x0f, 0, 300000);
+	if (ret)
+		return ret;
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
@@ -1544,6 +1608,10 @@ static int si5341_probe(struct i2c_client *client,
 	for (i = 0; i < data->num_synth; ++i)
 		 devm_kfree(&client->dev, (void *)synth_clock_names[i]);
 
+	err = sysfs_create_group(&client->dev.kobj, &si5341_attr_group);
+	if (err)
+		return err;
+
 	return 0;
 }
 
-- 
2.17.1

