Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229E82CA473
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391403AbgLANxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:53:32 -0500
Received: from mail-vi1eur05on2070.outbound.protection.outlook.com ([40.107.21.70]:59104
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391383AbgLANx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:53:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYO8Y0MLQc6GgG9vzekGty3NDJvQoVdgE4xaYAW/EfI6ztkSOe/KmaMi2c2NxSeBqe0Ocn3/2WiH8AnNb+LUoupRNMOL4+Pkq6E5tIe8MWmOeLdz+X8btdwUz/e7ldPIYAodWnqMGFROvYqdpa7+wDOp20mWE6faFJXzpnH1Hlct53NUwOx8VMjzwIsjeu7rSaJMn+M/7hYtNUriDkDVVIvzkcvFW02jXiy3xANAjVzOiD7wHnqAWu/q+qMu+JoenBqynWalH8lXUixv6o7w2x/PPtFz4bmM7dzX9p0z+6A5NVgSl1EYyMcE/XsqfprVWtJUqzW24g5GAV/JdXstXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3Rz7gkA29ruS8+JleO8Njw7VhFMISC57K6StK9FDxU=;
 b=mMDuFFKYJrUCqPKL+/o0/hwOixawxld03/QInaI7deLTjNYRC298+rIWbSWE7orOWQBH+XQLtmdQ+qicCZ5UfDecIDPa0PfiyKXCY96gw8KfdeAhQn2ha6v4GI01NquHar2h1534hTgKEFFqtkZjwKIRoC+GzWMzJIifypyno0Lf7UdNzHCqwf+6UVmgwsI4esMoBQ0iA9CaL/Sy1lbzBadmPAYHRpkBRdqfi68kZhPUlkVqmo6+psPFjelAQuVdMpdDK2NLAc6f/2mgWbmf6x5nD8qch6Ffz8cx1DIwOW2cOE7oyxZ0NeJ9gwdCn28+aksM9jLiUjmhM3ZKST3R3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3Rz7gkA29ruS8+JleO8Njw7VhFMISC57K6StK9FDxU=;
 b=PJeTkPxPSY+vAqDzTssUZL2vxVWp1QUZLAK/wj5/qTyZ0HOPllTZP9MPPaCZq7b0hPf23q5fAbTAbO/PFNBj9fcOYfqhXikQLdY+GwCIPW0eHM+wZqYXtNvz6IJD8h8ewnsUmgKiimBTXOxY9kmrcxT+m/diIdloqRRpG518+hY=
Received: from AM9P195CA0025.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::30)
 by AM6PR10MB3013.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:ec::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Tue, 1 Dec
 2020 13:52:39 +0000
Received: from AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:21f:cafe::e1) by AM9P195CA0025.outlook.office365.com
 (2603:10a6:20b:21f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Tue, 1 Dec 2020 13:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT064.mail.protection.outlook.com (10.152.9.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3611.23 via Frontend Transport; Tue, 1 Dec 2020 13:52:38 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 1 Dec 2020 14:52:32 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 8294E3FBE7; Tue,  1 Dec 2020 13:52:32 +0000 (GMT)
Message-ID: <5849ce60595aef1018bdde7dcfb54a7397597545.1606830377.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606830377.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606830377.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 1 Dec 2020 13:52:32 +0000
Subject: [PATCH V4 06/10] regulator: da9121: Add support for device variants
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
X-MS-Office365-Filtering-Correlation-Id: c85ca2c2-5efd-4296-7cf7-08d896005d8e
X-MS-TrafficTypeDiagnostic: AM6PR10MB3013:
X-Microsoft-Antispam-PRVS: <AM6PR10MB30132929A49C848231FDB631CBF40@AM6PR10MB3013.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4eTYKzUL/Uv4/DCEbc8X6PnwHImmOxU8992a29k3G/l1lJfafFKcwYB7lfIBLaLOl+aKULdJJmVbNG3qI0M6NoEZCnAfSKnlo4LQHa7Tzp7JWd8nSUEU5G1oWg//C4IvKGUBWWNP4tNALuzHXDHpFrx/Dk1iMHnr90hi3AKD3icpc1bz27f+BTa+bNO/ol/Q2OXFwvke1XwPOWWPcytZYQyCKVwE0XVFHrpXi6ePUCQ+FFtKbBk3dcrs81LLbzwlddAJDi8WeIsRjLW3jmO3VKZSRQCrleJKinJhObBuh6xUzKzE2FSqgVvgQ95UqN/COTMhuwZt5Y15PKwqGGAiDeV+O+Nj2Ih52RjuHbJBv15RY97OFyMh44kSgOxX/v+IWY3rV/8gNsWYlaaIYtHUmQ==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966005)(186003)(6266002)(42186006)(110136005)(36756003)(54906003)(356005)(498600001)(4326008)(336012)(426003)(5660300002)(86362001)(2906002)(8676002)(107886003)(81166007)(26005)(8936002)(70206006)(2616005)(70586007)(82310400003)(83380400001)(47076004);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 13:52:38.4311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c85ca2c2-5efd-4296-7cf7-08d896005d8e
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB3013
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

