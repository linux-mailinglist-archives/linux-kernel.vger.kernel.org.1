Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FA02C8879
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgK3Pnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:43:50 -0500
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:28001
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727309AbgK3Pnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:43:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoisjp6tBYwoLunlg5IDlojOGranpzOwiztO18V7iy1Z1YQS2LMa6uKVfYrPNM7TGKgIiWbf0cPDj4wZw0B3JelqJTQlHaGb4o3tYFA2bKIxEjpjJ1hHkVQhWzBT5MKhm3ho7Au8+IZROLh5tamrgqdQeSTIlKpezOJ8Gfgp1FaxJGeREXqBVdUcA8whxWXWfhkEoiHI0KEROyBoVen9TV9ww8uKdmfgJdifWgQPeYwTSyetZdE0XAJewh+YoJHEQKZwGFtHHiPHggdbeauSMHpc1fAcG0YRlr+3883kbor0NmzdGBjOKvfOKLpZ6YOitygHD6DVptVyH+0bL1yftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3Rz7gkA29ruS8+JleO8Njw7VhFMISC57K6StK9FDxU=;
 b=hi92eXDD17zwE5yw6NuT3iXMvots8lWnvt/k4s9GeRBPuWcr5e70wHXPy/xR1MjHKHktCZ7/a0SaHHeIAV8Zo+Pz0ds3pyJEZyMGSOybt58GfRS3FpDkSxRupDlk5eCdcQZDQXlmJAKdbvcCHcZDeTuMQ79qhAIwl/3hR6A/Tqb5Z6a54wqbhDlr7sTqZ39VEP4Fq7Ej/jABoiALutSBv2x79fneAlp8ilFyfEviTm7AhJ+YkZ9GLZ2eAGsJheHSaEIIOmT4DLTeDTOJhVF5Jd6mWT70WpR97rAuCsa/+cfJje38jZSbhI+axULS4cer+69oJCeTz8tHJGbXqeNZ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3Rz7gkA29ruS8+JleO8Njw7VhFMISC57K6StK9FDxU=;
 b=AilWJc2PM328dmFmat6pDDaPBYb4VxM305nIlvT9IrxcfCkjhMdsHnATU0pi7mRJGW7DbJy3JANU1BoKYGg9VXABXAEv8eGYfgYmOSDQTi74YwEK1F5iJwSRAjgh/A7zWI4Id9JHeMELQjotU3qN5YZTtXf2iI8v5FMmJxsL7wo=
Received: from MR2P264CA0187.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::26) by
 AM6PR10MB2373.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:42::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.22; Mon, 30 Nov 2020 15:42:56 +0000
Received: from VE1EUR02FT045.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:501:0:cafe::3b) by MR2P264CA0187.outlook.office365.com
 (2603:10a6:501::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 15:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT045.mail.protection.outlook.com (10.152.12.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3589.20 via Frontend Transport; Mon, 30 Nov 2020 15:42:56 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 30 Nov 2020 16:42:49 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 B0F4B3FC09; Mon, 30 Nov 2020 15:42:49 +0000 (GMT)
Message-ID: <27f6365fc251f88c1cc47068acb84be8c1996ebe.1606750000.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606750000.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606750000.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 30 Nov 2020 15:42:49 +0000
Subject: [PATCH V2 5/9] regulator: da9121: Add support for device variants via
 devicetree
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 515a6b05-7be1-4010-7080-08d895469b94
X-MS-TrafficTypeDiagnostic: AM6PR10MB2373:
X-Microsoft-Antispam-PRVS: <AM6PR10MB2373C72CF5B2568BDE5B22B2CBF50@AM6PR10MB2373.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oNZE7S+Hmza4YhOctBodQrIyWouYM6i6Oqz1K9HbeYbP8LI9+8arjfpLVcA2eG6jQJScmv3lTgMw0AIt3zwp27/k0m/S9bxIn86EVh43PgMSzD51zrHXTkzxDYW5olFQ6XgDqtd/bEK7hC3PnXyYBgzPzRbFNfFp/JYfyYZUe1WaiBuHOT8FF1wveFDB3DL7j6mfpUQ+h5SWmOFS4p1LWLkVbdi8uMwAn0EmJuJNgdbWrVCtvGfKyxUpvZmGlf6RF88J9vfpMz8hfJeNjhnBVyNhShwH8uSQOQqZpQltszhNvjU3zyJXhd2T8zhvj3YULiDaq+cbz+Nz/1PrTuO7iKQOsxUxokvxACnCxJ6kM9shXRs0wO0LrsuH2cy4wewBKx4cGc+FUpgxQl4kPlAnCQ==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(46966005)(36756003)(6266002)(336012)(8676002)(86362001)(478600001)(81166007)(186003)(8936002)(5660300002)(26005)(356005)(426003)(47076004)(4326008)(82310400003)(316002)(82740400003)(2616005)(107886003)(70206006)(70586007)(2906002)(110136005)(83380400001)(54906003)(42186006);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 15:42:56.0632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 515a6b05-7be1-4010-7080-08d895469b94
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT045.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2373
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree configuration and device variant parameters. Use the latter
to enable the check and use of parameters specific to dual buck variants.

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 119 +++++++++++++++++++++++++++++++++++
 include/linux/regulator/da9121.h     |  11 ++++
 2 files changed, 130 insertions(+)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index a717e2b..1f74371 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -14,6 +14,7 @@
 // Copyright (C) 2020 Dialog Semiconductor
 
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/driver.h>
@@ -28,10 +29,67 @@
 /* Chip data */
 struct da9121 {
 	struct device *dev;
+	struct da9121_pdata *pdata;
 	struct regmap *regmap;
 	int variant_id;
 };
 
+/* Define ranges for different variants, enabling translation to/from
+ * registers. Maximums give scope to allow for transients.
+ */
+struct da9121_range {
+	int val_min;
+	int val_max;
+	int val_stp;
+	int reg_min;
+	int reg_max;
+};
+
+struct da9121_range da9121_10A_2phase_current = {
+	.val_min =  7000000,
+	.val_max = 20000000,
+	.val_stp =  1000000,
+	.reg_min = 1,
+	.reg_max = 14,
+};
+
+struct da9121_range da9121_6A_2phase_current = {
+	.val_min =  7000000,
+	.val_max = 12000000,
+	.val_stp =  1000000,
+	.reg_min = 1,
+	.reg_max = 6,
+};
+
+struct da9121_range da9121_5A_1phase_current = {
+	.val_min =  3500000,
+	.val_max = 10000000,
+	.val_stp =   500000,
+	.reg_min = 1,
+	.reg_max = 14,
+};
+
+struct da9121_range da9121_3A_1phase_current = {
+	.val_min = 3500000,
+	.val_max = 6000000,
+	.val_stp =  500000,
+	.reg_min = 1,
+	.reg_max = 6,
+};
+
+struct da9121_variant_info {
+	int num_bucks;
+	int num_phases;
+	struct da9121_range *current_range;
+};
+
+static const struct da9121_variant_info variant_parameters[] = {
+	{ 1, 2, &da9121_10A_2phase_current },	//DA9121_TYPE_DA9121_DA9130
+	{ 2, 1, &da9121_3A_1phase_current  },	//DA9121_TYPE_DA9220_DA9132
+	{ 2, 1, &da9121_5A_1phase_current  },	//DA9121_TYPE_DA9122_DA9131
+	{ 1, 2, &da9121_6A_2phase_current  },	//DA9121_TYPE_DA9217
+};
+
 static const struct regulator_ops da9121_buck_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
@@ -46,6 +104,59 @@ struct da9121 {
 	[DA9121_IDX_BUCK2] = { .name = "buck2" },
 };
 
+static int da9121_of_parse_cb(struct device_node *np,
+				const struct regulator_desc *desc,
+				struct regulator_config *config)
+{
+	struct da9121 *chip = config->driver_data;
+	struct da9121_pdata *pdata;
+	struct gpio_desc *ena_gpiod;
+
+	if (chip->pdata == NULL) {
+		pdata = devm_kzalloc(chip->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata)
+			return -ENOMEM;
+	} else {
+		pdata = chip->pdata;
+	}
+
+	pdata->num_buck++;
+
+	if (pdata->num_buck > variant_parameters[chip->variant_id].num_bucks) {
+		dev_err(chip->dev, "Error: excessive regulators for device\n");
+		return -ENODEV;
+	}
+
+	ena_gpiod = fwnode_gpiod_get_index(of_fwnode_handle(np), "enable", 0,
+						GPIOD_OUT_HIGH |
+						GPIOD_FLAGS_BIT_NONEXCLUSIVE,
+						"da9121-enable");
+	if (!IS_ERR(ena_gpiod))
+		config->ena_gpiod = ena_gpiod;
+
+	if (variant_parameters[chip->variant_id].num_bucks == 2) {
+		uint32_t ripple_cancel;
+		uint32_t ripple_reg;
+		int ret;
+
+		if (of_property_read_u32(da9121_matches[pdata->num_buck].of_node,
+				"dlg,ripple-cancel", &ripple_cancel)) {
+			if (pdata->num_buck > 1)
+				ripple_reg = DA9xxx_REG_BUCK_BUCK2_7;
+			else
+				ripple_reg = DA9121_REG_BUCK_BUCK1_7;
+
+			ret = regmap_update_bits(chip->regmap, ripple_reg,
+				DA9xxx_MASK_BUCK_BUCKx_7_CHx_RIPPLE_CANCEL,
+				ripple_cancel);
+			if (ret < 0)
+				dev_err(chip->dev, "Cannot set ripple mode, err: %d\n", ret);
+		}
+	}
+
+	return 0;
+}
+
 #define DA9121_MIN_MV		300
 #define DA9121_MAX_MV		1900
 #define DA9121_STEP_MV		10
@@ -57,6 +168,7 @@ struct da9121 {
 	.id = DA9121_IDX_BUCK1,
 	.name = "da9121",
 	.of_match = "buck1",
+	.of_parse_cb = da9121_of_parse_cb,
 	.owner = THIS_MODULE,
 	.regulators_node = of_match_ptr("regulators"),
 	.ops = &da9121_buck_ops,
@@ -80,6 +192,7 @@ struct da9121 {
 		.id = DA9121_IDX_BUCK1,
 		.name = "DA9220/DA9132 BUCK1",
 		.of_match = "buck1",
+		.of_parse_cb = da9121_of_parse_cb,
 		.owner = THIS_MODULE,
 		.regulators_node = of_match_ptr("regulators"),
 		.ops = &da9121_buck_ops,
@@ -97,6 +210,7 @@ struct da9121 {
 		.id = DA9121_IDX_BUCK2,
 		.name = "DA9220/DA9132 BUCK2",
 		.of_match = "buck2",
+		.of_parse_cb = da9121_of_parse_cb,
 		.owner = THIS_MODULE,
 		.regulators_node = of_match_ptr("regulators"),
 		.ops = &da9121_buck_ops,
@@ -117,6 +231,7 @@ struct da9121 {
 		.id = DA9121_IDX_BUCK1,
 		.name = "DA9122/DA9131 BUCK1",
 		.of_match = "buck1",
+		.of_parse_cb = da9121_of_parse_cb,
 		.owner = THIS_MODULE,
 		.regulators_node = of_match_ptr("regulators"),
 		.ops = &da9121_buck_ops,
@@ -134,6 +249,7 @@ struct da9121 {
 		.id = DA9121_IDX_BUCK2,
 		.name = "DA9122/DA9131 BUCK2",
 		.of_match = "buck2",
+		.of_parse_cb = da9121_of_parse_cb,
 		.owner = THIS_MODULE,
 		.regulators_node = of_match_ptr("regulators"),
 		.ops = &da9121_buck_ops,
@@ -153,6 +269,7 @@ struct da9121 {
 	.id = DA9121_IDX_BUCK1,
 	.name = "DA9217 BUCK1",
 	.of_match = "buck1",
+	.of_parse_cb = da9121_of_parse_cb,
 	.owner = THIS_MODULE,
 	.regulators_node = of_match_ptr("regulators"),
 	.ops = &da9121_buck_ops,
@@ -415,6 +532,7 @@ static int da9121_i2c_probe(struct i2c_client *i2c,
 		goto error;
 	}
 
+	chip->pdata = i2c->dev.platform_data;
 	chip->variant_id = da9121_of_get_id(&i2c->dev);
 
 	ret = da9121_assign_chip_model(i2c, chip);
@@ -422,6 +540,7 @@ static int da9121_i2c_probe(struct i2c_client *i2c,
 		goto error;
 
 	config.dev = &i2c->dev;
+	config.driver_data = chip;
 	config.of_node = dev->of_node;
 	config.regmap = chip->regmap;
 
diff --git a/include/linux/regulator/da9121.h b/include/linux/regulator/da9121.h
index c31180d..62d9d257 100644
--- a/include/linux/regulator/da9121.h
+++ b/include/linux/regulator/da9121.h
@@ -16,10 +16,21 @@
 #ifndef __LINUX_REGULATOR_DA9121_H
 #define __LINUX_REGULATOR_DA9121_H
 
+#include <linux/regulator/machine.h>
+
+struct gpio_desc;
+
 enum {
 	DA9121_IDX_BUCK1,
 	DA9121_IDX_BUCK2,
 	DA9121_IDX_MAX
 };
 
+struct da9121_pdata {
+	int num_buck;
+	struct gpio_desc *gpiod_ren[DA9121_IDX_MAX];
+	struct device_node *reg_node[DA9121_IDX_MAX];
+	struct regulator_init_data *init_data[DA9121_IDX_MAX];
+};
+
 #endif
-- 
1.9.1

