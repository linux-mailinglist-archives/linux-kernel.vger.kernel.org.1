Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D8C2C8876
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgK3Pnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:43:47 -0500
Received: from mail-am6eur05on2046.outbound.protection.outlook.com ([40.107.22.46]:28673
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727678AbgK3Pnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:43:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGSJmwuw9844GDPT9VoT3qMHpf1QQ1niUdtKXyW6WMjeJGtzHvV5LFR2ppaPHFtkgTo2ZoYb3789K9aaN6KLmO41lg/UNEDr06zryflX9kgee6jGTJp7Q2FGt5pIx6QzWPOI1Xn+d+u4H2KIuucIH3uyzDkTL2Po0vlGSpi7D9YXUry94NJn7OuTy9TKJsppVl8sD194r3xEsCyGka6lChxtsG86MUHaboBTlohW5zPLBevjYCIK8vK/nTfSPED3l49tq49HX/8cM/vk5/zzaL3LYgfmhUsyEw2Y/DFACNPE2sajRmnv73uExtqzRZBBu2XRLjj2MpeC+nGpue16Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2bMepdN0K5jSlTiGZY7NPutg5/KSR80+NAa8nbxqHs=;
 b=FOJtcoVi/HGyDSnCE5k0fdIlJkU6LyNj+GsV6JJX7UQ5pdb4vM6i5EU1yrhn/cbzg1lyyKkz1BFQiB08s332jC6weWoHlmUGyDGwD4V6v1TB/D0i4pSbDhbR44IIrAgzH5f6vD75iCNvhnLD00Fwupk3XB1MowNb7/H1aOl1RSX5GfyJM1FGudIG9a+ZT20PEEcPkCtxruWY67GcispMuAaclPoYLdLDaOex0mU+YjrX9EPHie1VACE0Buf9DCFkV60scsvVnjE0igkCE4wTfh/VI67PudQE9ZES7fVQxfLvgmky9BxhvjrTAIolgwE/ZltGj6Ot152/6qFplWz/EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2bMepdN0K5jSlTiGZY7NPutg5/KSR80+NAa8nbxqHs=;
 b=xfyOXABXt47Ix0Xa1j3HB5Ofh8XNGfLmjdE2cBiRb/HW198NM7GcnuBSOCvsSxDvN9tSPLozNwOvdCymyoOmXZ0GSgSfowVaoWa+w1f3MuMoECln1EHVclljWEnDVh297wrSeKJKq466T3KSOwDm/4+q7hz6ojUMyBfqocdYWqE=
Received: from MR2P264CA0170.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::9) by
 VI1PR1001MB1149.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:67::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Mon, 30 Nov
 2020 15:42:53 +0000
Received: from VE1EUR02FT045.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:501:0:cafe::b5) by MR2P264CA0170.outlook.office365.com
 (2603:10a6:501::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 15:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT045.mail.protection.outlook.com (10.152.12.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3589.20 via Frontend Transport; Mon, 30 Nov 2020 15:42:52 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 30 Nov 2020 16:42:47 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 A96C73FBE8; Mon, 30 Nov 2020 15:42:47 +0000 (GMT)
Message-ID: <08a09b7975e1f233cbb0e7b297b13bde47febef9.1606750000.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606750000.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606750000.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 30 Nov 2020 15:42:47 +0000
Subject: [PATCH V2 3/9] regulator: da9121: Add device variant regmaps
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1234d2f8-5f67-477b-e33f-08d8954699ba
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1149:
X-Microsoft-Antispam-PRVS: <VI1PR1001MB1149C0279FE56B46D201B34CCBF50@VI1PR1001MB1149.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iDT7erMui2eJU1PsfxWO9LDb1U7K0Aa0KjuULjlCNmydSGNomjS1kypxCU7SBgsYMSCa0MXP3oCmb0EyHRIhq1ULfCiDv/tgWXualCxnI8sQAwKF0EWMzVKv4WTHUyKE7JF8i6VUsIEeyD8igjO3uuPPq10gxbO/y61Pz8ckbFQcXuLXaawQSFR0n9nlIskgm1sH9tgjHOWx4PNXEDwWQ6Gu3L0Weu3lfIgVt42AO70GRXRU97wCnOnyZgRUQMV8DNygpj+2AQ1pa8EfqH0lXKqdO3bb1YqrnIxQfdGwjCRFwH8iCDQouI4b8JdDVOPW/tXEfLmw2MdXetQGjxP4vBjH2WZSIWdYbCvRQfYr3ohkqoBpUjJQgVMAQnbMfTdgL1JmcvOo3u0UDceXiibM9A==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966005)(4326008)(2616005)(356005)(30864003)(83380400001)(8676002)(82310400003)(81166007)(2906002)(70206006)(336012)(70586007)(316002)(186003)(6266002)(107886003)(36756003)(5660300002)(42186006)(82740400003)(478600001)(86362001)(8936002)(47076004)(54906003)(426003)(110136005)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 15:42:52.9577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1234d2f8-5f67-477b-e33f-08d8954699ba
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT045.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1149
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ability to probe device and validate configuration, then apply a regmap
configuration for a single or dual buck device accordingly.

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/Kconfig            |  14 +-
 drivers/regulator/da9121-regulator.c | 244 ++++++++++++++++++++++++++++++++---
 include/linux/regulator/da9121.h     |  25 ++++
 3 files changed, 262 insertions(+), 21 deletions(-)
 create mode 100644 include/linux/regulator/da9121.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index ca908bd..5371709 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -313,13 +313,21 @@ config REGULATOR_DA9063
 	  will be called da9063-regulator.
 
 config REGULATOR_DA9121
-	tristate "Dialog Semiconductor DA9121 regulator"
+	tristate "Dialog Semiconductor DA9121/DA9122/DA9220/DA9217/DA9130/DA9131/DA9132 regulator"
 	depends on I2C && OF
 	select REGMAP_I2C
 	help
 	  Say y here to support for the Dialog Semiconductor DA9121.  The
-	  DA9210 is a dual-phase buck converter controlled through an I2C
-	  interface.
+	  DA9121 is a single channel dual-phase buck converter controlled
+	  through an I2C interface.
+
+	  DA9121 Single-channel dual-phase 10A buck converter
+	  DA9130 Single-channel dual-phase 10A buck converter (Automotive)
+	  DA9217 Single-channel dual-phase  6A buck converter
+	  DA9122 Dual-channel single-phase  5A buck converter
+	  DA9131 Dual-channel single-phase  5A buck converter (Automotive)
+	  DA9220 Dual-channel single-phase  3A buck converter
+	  DA9132 Dual-channel single-phase  3A buck converter (Automotive)
 
 	  This driver can also be built as a module. If so, the module
 	  will be called da9121-regulator.
diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index 5bebdb2..137b1df 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -1,5 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (C) 2020 Axis Communications AB */
+//
+// DA9121 Single-channel dual-phase 10A buck converter
+//
+// Copyright (C) 2020 Axis Communications AB
+//
+// DA9130 Single-channel dual-phase 10A buck converter (Automotive)
+// DA9217 Single-channel dual-phase  6A buck converter
+// DA9122 Dual-channel single-phase  5A buck converter
+// DA9131 Dual-channel single-phase  5A buck converter (Automotive)
+// DA9220 Dual-channel single-phase  3A buck converter
+// DA9132 Dual-channel single-phase  3A buck converter (Automotive)
+//
+// Copyright (C) 2020 Dialog Semiconductor
 
 #include <linux/of_device.h>
 #include <linux/regulator/of_regulator.h>
@@ -9,26 +21,17 @@
 #include <linux/regmap.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/regulator/da9121.h>
+
 #include "da9121-regulator.h"
 
 /* Chip data */
 struct da9121 {
 	struct device *dev;
+	struct regmap *regmap;
 	int variant_id;
 };
 
-#define DA9121_MIN_MV		300
-#define DA9121_MAX_MV		1900
-#define DA9121_STEP_MV		10
-#define DA9121_MIN_SEL		(DA9121_MIN_MV / DA9121_STEP_MV)
-#define DA9121_N_VOLTAGES	(((DA9121_MAX_MV - DA9121_MIN_MV) / DA9121_STEP_MV) \
-				 + 1 + DA9121_MIN_SEL)
-
-static const struct regmap_config da9121_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-};
-
 static const struct regulator_ops da9121_buck_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
@@ -38,6 +41,13 @@ struct da9121 {
 	.list_voltage = regulator_list_voltage_linear,
 };
 
+#define DA9121_MIN_MV		300
+#define DA9121_MAX_MV		1900
+#define DA9121_STEP_MV		10
+#define DA9121_MIN_SEL		(DA9121_MIN_MV / DA9121_STEP_MV)
+#define DA9121_N_VOLTAGES	(((DA9121_MAX_MV - DA9121_MIN_MV) / DA9121_STEP_MV) \
+				 + 1 + DA9121_MIN_SEL)
+
 static const struct regulator_desc da9121_reg = {
 	.name = "da9121",
 	.of_match = "buck1",
@@ -58,6 +68,205 @@ struct da9121 {
 	.enable_time = 20,
 };
 
+/* DA9121 chip register model */
+static const struct regmap_range da9121_1ch_readable_ranges[] = {
+	regmap_reg_range(DA9121_REG_SYS_STATUS_0, DA9121_REG_SYS_MASK_3),
+	regmap_reg_range(DA9121_REG_SYS_CONFIG_2, DA9121_REG_SYS_CONFIG_3),
+	regmap_reg_range(DA9121_REG_SYS_GPIO0_0, DA9121_REG_SYS_GPIO2_1),
+	regmap_reg_range(DA9121_REG_BUCK_BUCK1_0, DA9121_REG_BUCK_BUCK1_6),
+	regmap_reg_range(DA9121_REG_OTP_DEVICE_ID, DA9121_REG_OTP_CONFIG_ID),
+};
+
+static const struct regmap_access_table da9121_1ch_readable_table = {
+	.yes_ranges = da9121_1ch_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(da9121_1ch_readable_ranges),
+};
+
+static const struct regmap_range da9121_2ch_readable_ranges[] = {
+	regmap_reg_range(DA9121_REG_SYS_STATUS_0, DA9121_REG_SYS_MASK_3),
+	regmap_reg_range(DA9121_REG_SYS_CONFIG_2, DA9121_REG_SYS_CONFIG_3),
+	regmap_reg_range(DA9121_REG_SYS_GPIO0_0, DA9121_REG_SYS_GPIO2_1),
+	regmap_reg_range(DA9121_REG_BUCK_BUCK1_0, DA9121_REG_BUCK_BUCK1_7),
+	regmap_reg_range(DA9xxx_REG_BUCK_BUCK2_0, DA9xxx_REG_BUCK_BUCK2_7),
+	regmap_reg_range(DA9121_REG_OTP_DEVICE_ID, DA9121_REG_OTP_CONFIG_ID),
+};
+
+static const struct regmap_access_table da9121_2ch_readable_table = {
+	.yes_ranges = da9121_2ch_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(da9121_2ch_readable_ranges),
+};
+
+static const struct regmap_range da9121_1ch_writeable_ranges[] = {
+	regmap_reg_range(DA9121_REG_SYS_EVENT_0, DA9121_REG_SYS_MASK_3),
+	regmap_reg_range(DA9121_REG_SYS_CONFIG_2, DA9121_REG_SYS_CONFIG_3),
+	regmap_reg_range(DA9121_REG_SYS_GPIO0_0, DA9121_REG_SYS_GPIO2_1),
+	regmap_reg_range(DA9121_REG_BUCK_BUCK1_0, DA9121_REG_BUCK_BUCK1_2),
+	regmap_reg_range(DA9121_REG_BUCK_BUCK1_4, DA9121_REG_BUCK_BUCK1_6),
+};
+
+static const struct regmap_access_table da9121_1ch_writeable_table = {
+	.yes_ranges = da9121_1ch_writeable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(da9121_1ch_writeable_ranges),
+};
+
+static const struct regmap_range da9121_2ch_writeable_ranges[] = {
+	regmap_reg_range(DA9121_REG_SYS_EVENT_0, DA9121_REG_SYS_MASK_3),
+	regmap_reg_range(DA9121_REG_SYS_CONFIG_2, DA9121_REG_SYS_CONFIG_3),
+	regmap_reg_range(DA9121_REG_SYS_GPIO0_0, DA9121_REG_SYS_GPIO2_1),
+	regmap_reg_range(DA9121_REG_BUCK_BUCK1_0, DA9121_REG_BUCK_BUCK1_2),
+	regmap_reg_range(DA9121_REG_BUCK_BUCK1_4, DA9121_REG_BUCK_BUCK1_7),
+	regmap_reg_range(DA9xxx_REG_BUCK_BUCK2_0, DA9xxx_REG_BUCK_BUCK2_2),
+	regmap_reg_range(DA9xxx_REG_BUCK_BUCK2_4, DA9xxx_REG_BUCK_BUCK2_7),
+};
+
+static const struct regmap_access_table da9121_2ch_writeable_table = {
+	.yes_ranges = da9121_2ch_writeable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(da9121_2ch_writeable_ranges),
+};
+
+
+static const struct regmap_range da9121_volatile_ranges[] = {
+	regmap_reg_range(DA9121_REG_SYS_STATUS_0, DA9121_REG_SYS_EVENT_2),
+	regmap_reg_range(DA9121_REG_SYS_GPIO0_0, DA9121_REG_SYS_GPIO2_1),
+	regmap_reg_range(DA9121_REG_BUCK_BUCK1_0, DA9121_REG_BUCK_BUCK1_6),
+};
+
+static const struct regmap_access_table da9121_volatile_table = {
+	.yes_ranges = da9121_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(da9121_volatile_ranges),
+};
+
+/* DA9121 regmap config for 1 channel variants */
+static struct regmap_config da9121_1ch_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = DA9121_REG_OTP_CONFIG_ID,
+	.rd_table = &da9121_1ch_readable_table,
+	.wr_table = &da9121_1ch_writeable_table,
+	.volatile_table = &da9121_volatile_table,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+/* DA9121 regmap config for 2 channel variants */
+static struct regmap_config da9121_2ch_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = DA9121_REG_OTP_CONFIG_ID,
+	.rd_table = &da9121_2ch_readable_table,
+	.wr_table = &da9121_2ch_writeable_table,
+	.volatile_table = &da9121_volatile_table,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static int da9121_check_device_type(struct i2c_client *i2c, struct da9121 *chip)
+{
+	u32 device_id;
+	u8 chip_id = chip->variant_id;
+	u32 variant_id;
+	u8 variant_mrc, variant_vrc;
+	char *type;
+	const char *name;
+	bool config_match = false;
+	int ret = 0;
+
+	ret = regmap_read(chip->regmap, DA9121_REG_OTP_DEVICE_ID, &device_id);
+	if (ret < 0) {
+		dev_err(chip->dev, "Cannot read device ID: %d\n", ret);
+		goto error;
+	}
+
+	ret = regmap_read(chip->regmap, DA9121_REG_OTP_VARIANT_ID, &variant_id);
+	if (ret < 0) {
+		dev_err(chip->dev, "Cannot read variant ID: %d\n", ret);
+		goto error;
+	}
+
+	if (device_id != DA9121_DEVICE_ID) {
+		dev_err(chip->dev, "Invalid device ID: 0x%02x\n", device_id);
+		ret = -ENODEV;
+		goto error;
+	}
+
+	variant_vrc = variant_id & DA9121_MASK_OTP_VARIANT_ID_VRC;
+
+	switch (variant_vrc) {
+	case DA9121_VARIANT_VRC:
+		type = "DA9121/DA9130";
+		config_match = (chip_id == DA9121_TYPE_DA9121_DA9130);
+		break;
+	case DA9220_VARIANT_VRC:
+		type = "DA9220/DA9132";
+		config_match = (chip_id == DA9121_TYPE_DA9220_DA9132);
+		break;
+	case DA9122_VARIANT_VRC:
+		type = "DA9122/DA9131";
+		config_match = (chip_id == DA9121_TYPE_DA9122_DA9131);
+		break;
+	case DA9217_VARIANT_VRC:
+		type = "DA9217";
+		config_match = (chip_id == DA9121_TYPE_DA9217);
+		break;
+	default:
+		type = "Unknown";
+		break;
+	}
+
+	dev_info(chip->dev,
+		 "Device detected (device-ID: 0x%02X, var-ID: 0x%02X, %s)\n",
+		 device_id, variant_id, type);
+
+	if (!config_match) {
+		dev_err(chip->dev, "Device tree configuration '%s' does not match detected device.\n", name);
+		ret = -EINVAL;
+		goto error;
+	}
+
+	variant_mrc = (variant_id & DA9121_MASK_OTP_VARIANT_ID_MRC)
+			>> DA9121_SHIFT_OTP_VARIANT_ID_MRC;
+
+	if ((device_id == DA9121_DEVICE_ID) &&
+	    (variant_mrc < DA9121_VARIANT_MRC_BASE)) {
+		dev_err(chip->dev,
+			"Cannot support variant MRC: 0x%02X\n", variant_mrc);
+		ret = -EINVAL;
+	}
+error:
+	return ret;
+}
+
+static int da9121_assign_chip_model(struct i2c_client *i2c,
+			struct da9121 *chip)
+{
+	struct regmap_config *regmap;
+	int ret = 0;
+
+	chip->dev = &i2c->dev;
+
+	switch (chip->variant_id) {
+	case DA9121_TYPE_DA9121_DA9130:
+		fallthrough;
+	case DA9121_TYPE_DA9217:
+		regmap = &da9121_1ch_regmap_config;
+		break;
+	case DA9121_TYPE_DA9122_DA9131:
+		fallthrough;
+	case DA9121_TYPE_DA9220_DA9132:
+		regmap = &da9121_2ch_regmap_config;
+		break;
+	}
+
+	chip->regmap = devm_regmap_init_i2c(i2c, regmap);
+	if (IS_ERR(chip->regmap)) {
+		ret = PTR_ERR(chip->regmap);
+		dev_err(chip->dev, "Failed to configure a register map: %d\n",
+			ret);
+	}
+
+	ret = da9121_check_device_type(i2c, chip);
+
+	return ret;
+}
+
 static const struct of_device_id da9121_dt_ids[] = {
 	{ .compatible = "dlg,da9121", .data = (void *) DA9121_TYPE_DA9121_DA9130 },
 	{ .compatible = "dlg,da9130", .data = (void *) DA9121_TYPE_DA9121_DA9130 },
@@ -89,7 +298,6 @@ static int da9121_i2c_probe(struct i2c_client *i2c,
 	struct device *dev = &i2c->dev;
 	struct regulator_config config = {};
 	struct regulator_dev *rdev;
-	struct regmap *regmap;
 
 	chip = devm_kzalloc(&i2c->dev, sizeof(struct da9121), GFP_KERNEL);
 	if (!chip) {
@@ -99,13 +307,13 @@ static int da9121_i2c_probe(struct i2c_client *i2c,
 
 	chip->variant_id = da9121_of_get_id(&i2c->dev);
 
-	regmap = devm_regmap_init_i2c(i2c, &da9121_regmap_config);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	ret = da9121_assign_chip_model(i2c, chip);
+	if (ret < 0)
+		goto error;
 
 	config.dev = &i2c->dev;
 	config.of_node = dev->of_node;
-	config.regmap = regmap;
+	config.regmap = chip->regmap;
 
 	rdev = devm_regulator_register(&i2c->dev, &da9121_reg, &config);
 	if (IS_ERR(rdev)) {
diff --git a/include/linux/regulator/da9121.h b/include/linux/regulator/da9121.h
new file mode 100644
index 0000000..c31180d
--- /dev/null
+++ b/include/linux/regulator/da9121.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * DA9121 Single-channel dual-phase 10A buck converter
+ * DA9130 Single-channel dual-phase 10A buck converter (Automotive)
+ * DA9217 Single-channel dual-phase  6A buck converter
+ * DA9122 Dual-channel single-phase  5A buck converter
+ * DA9131 Dual-channel single-phase  5A buck converter (Automotive)
+ * DA9220 Dual-channel single-phase  3A buck converter
+ * DA9132 Dual-channel single-phase  3A buck converter (Automotive)
+ *
+ * Copyright (C) 2020  Dialog Semiconductor
+ *
+ * Authors: Adam Ward, Dialog Semiconductor
+ */
+
+#ifndef __LINUX_REGULATOR_DA9121_H
+#define __LINUX_REGULATOR_DA9121_H
+
+enum {
+	DA9121_IDX_BUCK1,
+	DA9121_IDX_BUCK2,
+	DA9121_IDX_MAX
+};
+
+#endif
-- 
1.9.1

