Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3862C8A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgK3RAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:00:16 -0500
Received: from mail-am6eur05on2060.outbound.protection.outlook.com ([40.107.22.60]:45027
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729125AbgK3RAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:00:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5t3qOLrxi4wCtTpCS/yoqL3ZLAzML1JttHXfXBCmZDH4G0OZ1KX2RYIVRUkbjsNNC61Wpx9mkPjjMospkJSC/IZQM40cAxkPfKg++CMUVvatgon+c/UT9bpd7hOonMr74KQiT6F4ghwTgji9VVLSPhh7WmrZwL33akTBn5ZPayPNUWYnAUvfprLe65ZPsNlywl6Rpi5Jjv8D1PWHGHmAOK+Bd0JXq6rxzt7tz1AOiwBr5sNmPJ7DfFDG1ZlmPpgQxl9tQvNMRvVpqdweOjFhQ2jW7YAn0G0FCu4sB2tCPWlekGtvN308XVLYXAneBe3vSLljcTDLO8xIpAEO7Ji0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3Rz7gkA29ruS8+JleO8Njw7VhFMISC57K6StK9FDxU=;
 b=WQDJXxf18RMrsSWBBgMfkkQQ2rOyxYXP7OqBQnI+OAWznySvcrRArVPuxjO4jta7uMHOBD9cHxcxBGbf0M37GeO7KtoKDB7LO91vJBYrJgzsH7AOioiMJ/HrYZFrqnIBPqxvrTUH1lL3d1EjZNW65zS9++hT5wF976JrtcPPL7FxByoZfkFakBXfICsISyt1D7xP/4tBDnAgYZBBpgAnZRDmdTpVZDNNuViOZO2KwrdvZseyn3IgaIHBBgv5XKxIwIcVZ4AAF9xps1yEiZe5DEX39J2yHZlpcxzc/vtwg8PjUCO9iv4lPgc/J91SrxJjv5ZtDUNvW6+wAzKQ76+GBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3Rz7gkA29ruS8+JleO8Njw7VhFMISC57K6StK9FDxU=;
 b=JCa8q5ipiMjaTw9BbooJ8c0eYV3CJvwvMwHCaiEHt0NMc3TRUl1ea/vqe2Iw9KkOmMrSMyKBBntJmKzti+PBSwjUYZrmlnVS1fcj7rgNrJ+J8jx1kJw+Ix5KHL9eb6lyHJESXCQiO1KSoOwbHYDT4cSRmnt9j2TIey/pRhXsi7c=
Received: from AM6PR0502CA0063.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::40) by AM0PR10MB3442.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:163::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 16:59:25 +0000
Received: from VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::2b) by AM6PR0502CA0063.outlook.office365.com
 (2603:10a6:20b:56::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend
 Transport; Mon, 30 Nov 2020 16:59:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT054.mail.protection.outlook.com (10.152.13.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3611.23 via Frontend Transport; Mon, 30 Nov 2020 16:59:24 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 30 Nov 2020 17:59:10 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 C2B0B3FC0E; Mon, 30 Nov 2020 16:59:10 +0000 (GMT)
Message-ID: <5849ce60595aef1018bdde7dcfb54a7397597545.1606755367.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606755367.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606755367.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 30 Nov 2020 16:59:10 +0000
Subject: [PATCH V3 06/10] regulator: da9121: Add support for device variants
 via devicetree
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5a18772-26e6-4d66-898d-08d895514a96
X-MS-TrafficTypeDiagnostic: AM0PR10MB3442:
X-Microsoft-Antispam-PRVS: <AM0PR10MB3442CDA1836E182AC4FBC257CBF50@AM0PR10MB3442.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aL+/NTkh4jW7yXaqldhae7wtPjGFCukYdq/WzSPkWpbjFREeJ4U+PH75hNSDzsFbq0X8edbDs0kHNLVw2ZX4UWtESo/xXBWplXMOfmggHlqDjkiHiivwxLaEm+IkTpZKOxwxXl4lJNEqMwZV11GGm0O2Dig4yH7nfnNaUP6C4N/auztYYTpVdu/kfGhmfujeaeTGnfWMAVH2PB3SxGQ0Hn8t6QU0cReGC+hYPHJjazfQw3aBi9z/RatUo0JzhE/7WdH05gOgCfSxy/9Rzz7EC+aMjPEAkMAtUC3oqIGshNzvwfLV4napRzrcGa1MaD4CG5H9RMXsAv544yhHN1mRfqM3ShjtuC7U15o7WCcxQ48WV7Y1qdYjk57nZYbrmfG5Wi28jOzzKZLK7zqDI+b1EA==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(46966005)(6266002)(8676002)(54906003)(110136005)(42186006)(2906002)(316002)(82310400003)(8936002)(107886003)(4326008)(36756003)(356005)(81166007)(70586007)(86362001)(478600001)(5660300002)(47076004)(70206006)(83380400001)(82740400003)(26005)(186003)(426003)(336012)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 16:59:24.6515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a18772-26e6-4d66-898d-08d895514a96
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3442
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

