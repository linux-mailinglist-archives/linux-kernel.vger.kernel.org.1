Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDD42BA9E9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 13:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgKTMPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 07:15:02 -0500
Received: from mail-db8eur05on2077.outbound.protection.outlook.com ([40.107.20.77]:42176
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727197AbgKTMO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:14:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0o1fJqpfusLjUFEr1mZ37Hv2siSRfvSSRjnMXPRDofn50dTeGxktVFSkl9cVHzTcnWPEGrelF8bsYmBqgs9EdXtj8PSCFirTicbTkAuBNBSofmjcojKE0RqobrkCayKKml0a3Czk8KuXZF4lK8lCDPc0YNRY1991cDeRw3JLiZsZpAhF38l8pMcfmEDVWKbp5BxQPNsYN8btIqqS0tPI5YrImMwu5TkdPIclQ5UtK2u3KIYYL3Zwl9yfWBpfDYepV1QMmHvHqDnmZkbYEcIfd8Io+z/JXTR3h3g8TqsLbgrkdYNZ7zpX7/KuLRmzBq2fengIinUFRmM3Unk3ef0Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jl7wkP04iEr2GMYtgsyX5TJtWRuAHZlBmk+VZds7f34=;
 b=UbyYL+XYaaH1asy8hH09pORmfZWDtFLYATezLs9kU9k5of2SFOiNdEtAUdk6QtoKg4Tp0/Vt5/YVuTvFIkR6mncGVjyeaglmXoU0N1OLihHmzUmw3EXS4DFHpN1Mytl2WrNZJqE50thfwBiGPG1u/lVeEESnCk5OE1PptUyeafiukIYxptoGE/tNjEqgp9vMfVlfvIu1dOVpXy3vIVEeU2yfwAlXm9ajb4Yp7vdi+uqxcT15vyxSsfMqi+mYe8iub3TjEo6YWoS5TKXEXx+zZRkz50xbL8aTkfhe8mGd5VurcGbT/ySPGwayQT+sLwBtvkwNzoIYb3z4L2NC16VsIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jl7wkP04iEr2GMYtgsyX5TJtWRuAHZlBmk+VZds7f34=;
 b=D79WUCx2Iz9URz93O1NAXpyzB9f3EJk8O7rl766sO0M1iPA3e0zPU4Oe2ifEA/UXwjQMAsMKdRX0lH77lppjZCoCYq7WNADBeJOEkMY+LGmuUB1wuptqtBEyRLAMxIOPzjAxqJW5Addq6a5fzqMOeC/gRwsUTO7c4d5VI2+K0Co=
Received: from AM7PR04CA0002.eurprd04.prod.outlook.com (2603:10a6:20b:110::12)
 by AM0PR10MB3698.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:158::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 20 Nov
 2020 12:14:56 +0000
Received: from AM5EUR02FT003.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:110:cafe::98) by AM7PR04CA0002.outlook.office365.com
 (2603:10a6:20b:110::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Fri, 20 Nov 2020 12:14:56 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT003.mail.protection.outlook.com (10.152.8.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 12:14:56 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Fri, 20 Nov 2020 13:14:55 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 0B2A63FBAB; Fri, 20 Nov 2020 12:14:55 +0000 (GMT)
Message-ID: <f5c4446ff019173127fba460948f152dc6f8cf6f.1605868780.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <adam.ward@diasemi.com>
Date:   Fri, 20 Nov 2020 12:14:55 +0000
Subject: [PATCH 5/9] regulator: da9121: Add support for device variants via
 devicetree
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ac3a0b1-4d07-40ae-1faf-08d88d4de4da
X-MS-TrafficTypeDiagnostic: AM0PR10MB3698:
X-Microsoft-Antispam-PRVS: <AM0PR10MB36988E076C70AE54DCED5380CBFF0@AM0PR10MB3698.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1E56WD2j/R2bUO4yFe17KzeGjKNkeFQai6+60rUAI5zTOzDZLBdrl33q+hgr2QUDMpxWJnQq3GkvMW2ri0LVFeqpGXpHzX/hP0SM0A1bG8JMyj01UhA/0MUu1cawygDjo84qh4j6j8dQl4Gzk25dc7l3cVhgbIwT4Kroamj/GyCOiNq/aVumhxbtqzvspeF3dL9bljudMDgn+bAR7jkYuJBLB4zGlDIPJML0pmWfxVfSzGBjh1wdGiZ7gr6+LJpEpiqw/tAKgQSucMgHhdFkpu26QzKGIumYfsMqNX5p2ZPzuj0QuILMRuUwZpilUAHqa2GEuMLswc92i981+fvYu8g15fMBVuu2oFWXoMkh4kw/DRardNn06KJM0ZicqjbDFtxoglnILFp5DmcFqibHjKUsk9K4SIsd30bAQsGtfxlcbxgj4vrWCFrsdNjoKuH/
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966005)(82740400003)(81166007)(44832011)(47076004)(33310700002)(83380400001)(6266002)(186003)(42186006)(316002)(36756003)(336012)(54906003)(110136005)(426003)(356005)(36906005)(2906002)(4326008)(26005)(2616005)(478600001)(8936002)(5660300002)(82310400003)(8676002)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 12:14:56.2094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac3a0b1-4d07-40ae-1faf-08d88d4de4da
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT003.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3698
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree configuration and device variant parameters. Use the latter to
enable the check and use of parameters specific to dual buck variants.

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 157 ++++++++++++++++++++++++++++++++++-
 include/linux/regulator/da9121.h     |  11 +++
 2 files changed, 167 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index 76932ba..5020774 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -1,7 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (C) 2020 Axis Communications AB */
+/* Copyright (C) 2020 Axis Communications AB
+ *
+ * DA9121 Single-channel dual-phase 10A buck converter
+ *
+ * Copyright (C) 2020 Dialog Semiconductor
+ *
+ * DA9130 Single-channel dual-phase 10A buck converter (Automotive)
+ * DA9217 Single-channel dual-phase  6A buck converter
+ * DA9122 Dual-channel single-phase  5A buck converter
+ * DA9131 Dual-channel single-phase  5A buck converter (Automotive)
+ * DA9220 Dual-channel single-phase  3A buck converter
+ * DA9132 Dual-channel single-phase  3A buck converter (Automotive)
+ *
+ */
 
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/driver.h>
@@ -16,11 +30,68 @@
 /* Chip data */
 struct da9121 {
 	struct device *dev;
+	struct da9121_pdata *pdata;
 	struct regmap *regmap;
 	struct regulator_dev *rdev[DA9121_IDX_MAX];
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
@@ -163,6 +234,86 @@ struct da9121 {
 	[DA9121_TYPE_DA9217] = { &da9217_reg, NULL },
 };
 
+#ifdef CONFIG_OF
+static struct da9121_pdata *da9121_parse_regulators_dt(struct da9121 *chip)
+{
+	struct da9121_pdata *pdata;
+	struct device_node *node;
+	int num = 0;
+	int ret = 0;
+	int i, n;
+	enum gpiod_flags flags = GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE;
+
+	node = of_get_child_by_name(chip->dev->of_node, "regulators");
+	if (!node) {
+		dev_err(chip->dev, "Regulators node not found\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	num = of_regulator_match(chip->dev, node, da9121_matches,
+				 ARRAY_SIZE(da9121_matches));
+	of_node_put(node);
+	if (num < 0) {
+		dev_err(chip->dev, "Failed to match regulators\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* interrupt assumptions require at least one buck to be configured */
+	if (num == 0) {
+		dev_err(chip->dev, "Did not match any regulators in the DT\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	pdata = devm_kzalloc(chip->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	pdata->num_buck = num;
+
+	n = 0;
+	for (i = 0; i < ARRAY_SIZE(da9121_matches); i++) {
+		if (!da9121_matches[i].init_data)
+			continue;
+
+		pdata->init_data[n] = da9121_matches[i].init_data;
+		pdata->reg_node[n] = da9121_matches[i].of_node;
+		pdata->gpiod_ren[n] = devm_gpiod_get_from_of_node(chip->dev,
+				da9121_matches[i].of_node,
+				"enable-gpios",
+				0,
+				flags,
+				"da9121-enable");
+
+		if (IS_ERR(pdata->gpiod_ren[n]))
+			pdata->gpiod_ren[n] = NULL;
+
+		if (variant_parameters[chip->variant_id].num_bucks == 2) {
+			uint32_t ripple_cancel;
+			uint32_t reg = (i ? DA9xxx_REG_BUCK_BUCK2_7
+					  : DA9121_REG_BUCK_BUCK1_7);
+			if (!of_property_read_u32(da9121_matches[i].of_node,
+				  "dlg,ripple-cancel",
+				  &ripple_cancel)) {
+				//write to BUCK_BUCKx_7 : CHx_RIPPLE_CANCEL
+				ret = regmap_update_bits(chip->regmap, reg,
+					DA9xxx_MASK_BUCK_BUCKx_7_CHx_RIPPLE_CANCEL,
+					ripple_cancel);
+				if (ret < 0)
+					dev_err(chip->dev, "Cannot update BUCK register %02x, err: %d\n", reg, ret);
+			}
+		}
+		n++;
+	}
+
+	return pdata;
+}
+#else
+static struct da9121_pdata *da9121_parse_regulators_dt(struct da9121 *chip)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif
+
 /* DA9121 chip register model */
 static const struct regmap_range da9121_1ch_readable_ranges[] = {
 	regmap_reg_range(DA9121_REG_SYS_STATUS_0, DA9121_REG_SYS_MASK_3),
@@ -445,12 +596,16 @@ static int da9121_i2c_probe(struct i2c_client *i2c,
 		goto error;
 	}
 
+	chip->pdata = i2c->dev.platform_data;
 	chip->variant_id = da9121_of_get_id(&i2c->dev);
 
 	ret = da9121_assign_chip_model(i2c, chip);
 	if (ret < 0)
 		goto error;
 
+	if (!chip->pdata)
+		chip->pdata = da9121_parse_regulators_dt(chip);
+
 	config.dev = &i2c->dev;
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

