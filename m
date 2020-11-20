Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B6A2BA9F0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 13:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgKTMPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 07:15:10 -0500
Received: from mail-eopbgr40050.outbound.protection.outlook.com ([40.107.4.50]:11014
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727070AbgKTMPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:15:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRQHxIFqfSzIuaP4e3RPzORQ+7T8l/GVEn9IsvHilE7gvrUG/Byri6Mhe9ktkC3VC+rmS8TzKWkLyfyQDjDtZcDzvsCjk8xBRK8ZW/V8Vrnmh5gdQYfDT0CWbq+zWOC2NtPzWc0bGNSB869Ub5vzzXqxfj9CeT0h/q0HyvuIdGob3hMrBTFM568KxOdcnA92rrxBgN5/ATVjvngicbR5GXEI3VZMSFa+1sr/bq6rTAzNPfUxR3yexVUreZ1+hP+GdlXHgVYuH7R/qLsn+xAH6SWJtFIvC2Xe+k8jPR7cydCcJVRgM0lptrN4Tkaycx3BWYcZxGNxTjs9pFfh0V2cyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUEXkFqxOW0MUJLXmo3/B5kGATOWbl5RL90Bslg4s1U=;
 b=dhU63af0VVrLVeqltAx50AUBxD73G9hjPLreiRiUsDt4FVRSqQq2AukBpAZMSjiXR5O1tViHCq/bQfRKjLIfjWiZYFOF/JRisv5dFZmTsDsQNSmFSj7pAy0oJEZDGPwRPaHzoYne1OxMeIX2G19DsAiyHlVJEYDZSpiAuWjG7Xn9H4ZjIW1Mi+SVLYnxVTYYWFcNmepuD38y9J3Wp1fIZcKXtYXWPptEs3KASxNlw9wvpTevyqd3ShrgWfzqxd7O7XxXU81qszr7+bI0ttWG1srXnL8nQ92ueabTYHTU0powuuepumDhWge8ratlEBgqop94+9UWER43MVBqh/UFzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUEXkFqxOW0MUJLXmo3/B5kGATOWbl5RL90Bslg4s1U=;
 b=j/QWkgGmlYGNkVmlHTeHejs0PEmyDnQeV4ON5SlMU/3DG+Hu+CfbXijBtkJUZtutNTcRo6KaGyoVY3zegsw7FcHNTr9m1wnaNl1RG9n14Qdwy87vrI91MprFV0soG0f0RAieb5JMB5ALX1kiicHepvXC8UH1sf6ZCgh30K4J4kI=
Received: from AM6P192CA0052.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::29)
 by AM0PR10MB3555.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Fri, 20 Nov
 2020 12:14:54 +0000
Received: from AM5EUR02FT046.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:82:cafe::bd) by AM6P192CA0052.outlook.office365.com
 (2603:10a6:209:82::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Fri, 20 Nov 2020 12:14:54 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT046.mail.protection.outlook.com (10.152.8.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 12:14:54 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Fri, 20 Nov 2020 13:14:54 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 0717A3FBE0; Fri, 20 Nov 2020 12:14:54 +0000 (GMT)
Message-ID: <e3f0e227c099a2dc560af5aae92f13e4d2a112cb.1605868780.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <adam.ward@diasemi.com>
Date:   Fri, 20 Nov 2020 12:14:54 +0000
Subject: [PATCH 4/9] regulator: da9121: Add device variant details and
 respective regmaps
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7faaaf9-7bde-40de-00ee-08d88d4de3eb
X-MS-TrafficTypeDiagnostic: AM0PR10MB3555:
X-Microsoft-Antispam-PRVS: <AM0PR10MB35551F5DF90E3F2E85402D6BCBFF0@AM0PR10MB3555.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jBEBeAiEvxlPC+NImrmKpFH/+j+3ZwQnSfKs+je/a9ICSXAnTPxpLpIGFsRoPzot2VPDZ9+1Rcg8uthdKdEfWHhH/TRPzI8nQmXe2swnIcOv1VPCT1BO9hNcOcNuH9qF21gZZOovrqb8Ywb1S51CsbzDOqoCmvEmSXbsmAQRTOlqcoN+nC0TSHCv/2iRrtMNQ9glw4zDPS3dzpG7xZSB6wMH9zO63iE6XPYzHe/YCYwY2s27IGTI4ouQ7E7tBGgYQdhXGDiAMvDkZaOYn5UQQ/wQCVVe0d9zKA1GgLz9QDqBwsx4AzzVvurp8esLWwo9YAn9B0OtzfgrIFgkMmi28tLMMnBWgqj4s8v7eURK8XqjRYmIdocDgYI3p6sBu1hGyB8bIb+/bBMRJ4XZgyRbgXQr7z7v51cmFGp47ZOTdnvS81YjhS9B6VzMGnTX+ybM
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(46966005)(44832011)(186003)(2616005)(26005)(478600001)(2906002)(4326008)(6266002)(83380400001)(82310400003)(5660300002)(30864003)(110136005)(81166007)(47076004)(82740400003)(42186006)(336012)(426003)(70586007)(8676002)(36756003)(54906003)(70206006)(33310700002)(316002)(8936002)(356005)(36906005);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 12:14:54.6381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7faaaf9-7bde-40de-00ee-08d88d4de3eb
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT046.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3555
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ability to probe device and validate configuration, then apply a regmap
configuration for a single or dual buck device accordingly.

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/Kconfig            |  14 +-
 drivers/regulator/da9121-regulator.c | 382 +++++++++++++++++++++++++++++++++--
 include/linux/regulator/da9121.h     |  25 +++
 3 files changed, 401 insertions(+), 20 deletions(-)
 create mode 100644 include/linux/regulator/da9121.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 005a603..68f1bbd 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -304,13 +304,21 @@ config REGULATOR_DA9063
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
index 5bebdb2..76932ba 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -9,26 +9,18 @@
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
+	struct regulator_dev *rdev[DA9121_IDX_MAX];
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
@@ -38,10 +30,24 @@ struct da9121 {
 	.list_voltage = regulator_list_voltage_linear,
 };
 
+static struct of_regulator_match da9121_matches[] = {
+	[DA9121_IDX_BUCK1] = { .name = "buck1" },
+	[DA9121_IDX_BUCK2] = { .name = "buck2" },
+};
+
+#define DA9121_MIN_MV		300
+#define DA9121_MAX_MV		1900
+#define DA9121_STEP_MV		10
+#define DA9121_MIN_SEL		(DA9121_MIN_MV / DA9121_STEP_MV)
+#define DA9121_N_VOLTAGES	(((DA9121_MAX_MV - DA9121_MIN_MV) / DA9121_STEP_MV) \
+				 + 1 + DA9121_MIN_SEL)
+
 static const struct regulator_desc da9121_reg = {
+	.id = DA9121_IDX_BUCK1,
 	.name = "da9121",
 	.of_match = "buck1",
 	.owner = THIS_MODULE,
+	.regulators_node = of_match_ptr("regulators"),
 	.ops = &da9121_buck_ops,
 	.type = REGULATOR_VOLTAGE,
 	.n_voltages = DA9121_N_VOLTAGES,
@@ -58,6 +64,349 @@ struct da9121 {
 	.enable_time = 20,
 };
 
+static const struct regulator_desc da9220_reg[2] = {
+	{
+		.id = DA9121_IDX_BUCK1,
+		.name = "DA9220/DA9132 BUCK1",
+		.of_match = "buck1",
+		.owner = THIS_MODULE,
+		.regulators_node = of_match_ptr("regulators"),
+		.ops = &da9121_buck_ops,
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = DA9121_N_VOLTAGES,
+		.min_uV = DA9121_MIN_MV * 1000,
+		.uV_step = DA9121_STEP_MV * 1000,
+		.linear_min_sel = DA9121_MIN_SEL,
+		.enable_reg = DA9121_REG_BUCK_BUCK1_0,
+		.enable_mask = DA9121_MASK_BUCK_BUCKx_0_CHx_EN,
+		.vsel_reg = DA9121_REG_BUCK_BUCK1_5,
+		.vsel_mask = DA9121_MASK_BUCK_BUCKx_5_CHx_A_VOUT,
+	},
+	{
+		.id = DA9121_IDX_BUCK2,
+		.name = "DA9220/DA9132 BUCK2",
+		.of_match = "buck2",
+		.owner = THIS_MODULE,
+		.regulators_node = of_match_ptr("regulators"),
+		.ops = &da9121_buck_ops,
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = DA9121_N_VOLTAGES,
+		.min_uV = DA9121_MIN_MV * 1000,
+		.uV_step = DA9121_STEP_MV * 1000,
+		.linear_min_sel = DA9121_MIN_SEL,
+		.enable_reg = DA9xxx_REG_BUCK_BUCK2_0,
+		.enable_mask = DA9121_MASK_BUCK_BUCKx_0_CHx_EN,
+		.vsel_reg = DA9xxx_REG_BUCK_BUCK2_5,
+		.vsel_mask = DA9121_MASK_BUCK_BUCKx_5_CHx_A_VOUT,
+	}
+};
+
+static const struct regulator_desc da9122_reg[2] = {
+	{
+		.id = DA9121_IDX_BUCK1,
+		.name = "DA9122/DA9131 BUCK1",
+		.of_match = "buck1",
+		.owner = THIS_MODULE,
+		.regulators_node = of_match_ptr("regulators"),
+		.ops = &da9121_buck_ops,
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = DA9121_N_VOLTAGES,
+		.min_uV = DA9121_MIN_MV * 1000,
+		.uV_step = DA9121_STEP_MV * 1000,
+		.linear_min_sel = DA9121_MIN_SEL,
+		.enable_reg = DA9121_REG_BUCK_BUCK1_0,
+		.enable_mask = DA9121_MASK_BUCK_BUCKx_0_CHx_EN,
+		.vsel_reg = DA9121_REG_BUCK_BUCK1_5,
+		.vsel_mask = DA9121_MASK_BUCK_BUCKx_5_CHx_A_VOUT,
+	},
+	{
+		.id = DA9121_IDX_BUCK2,
+		.name = "DA9122/DA9131 BUCK2",
+		.of_match = "buck2",
+		.owner = THIS_MODULE,
+		.regulators_node = of_match_ptr("regulators"),
+		.ops = &da9121_buck_ops,
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = DA9121_N_VOLTAGES,
+		.min_uV = DA9121_MIN_MV * 1000,
+		.uV_step = DA9121_STEP_MV * 1000,
+		.linear_min_sel = DA9121_MIN_SEL,
+		.enable_reg = DA9xxx_REG_BUCK_BUCK2_0,
+		.enable_mask = DA9121_MASK_BUCK_BUCKx_0_CHx_EN,
+		.vsel_reg = DA9xxx_REG_BUCK_BUCK2_5,
+		.vsel_mask = DA9121_MASK_BUCK_BUCKx_5_CHx_A_VOUT,
+	}
+};
+
+static const struct regulator_desc da9217_reg = {
+	.id = DA9121_IDX_BUCK1,
+	.name = "DA9217 BUCK1",
+	.of_match = "buck1",
+	.owner = THIS_MODULE,
+	.regulators_node = of_match_ptr("regulators"),
+	.ops = &da9121_buck_ops,
+	.type = REGULATOR_VOLTAGE,
+	.n_voltages = DA9121_N_VOLTAGES,
+	.min_uV = DA9121_MIN_MV * 1000,
+	.uV_step = DA9121_STEP_MV * 1000,
+	.linear_min_sel = DA9121_MIN_SEL,
+	.enable_reg = DA9121_REG_BUCK_BUCK1_0,
+	.enable_mask = DA9121_MASK_BUCK_BUCKx_0_CHx_EN,
+	.vsel_reg = DA9121_REG_BUCK_BUCK1_5,
+	.vsel_mask = DA9121_MASK_BUCK_BUCKx_5_CHx_A_VOUT,
+};
+
+static const struct regulator_desc *local_da9121_regulators[][DA9121_IDX_MAX] = {
+	[DA9121_TYPE_DA9121_DA9130] = { &da9121_reg, NULL },
+	[DA9121_TYPE_DA9220_DA9132] = { &da9220_reg[0], &da9220_reg[1] },
+	[DA9121_TYPE_DA9122_DA9131] = { &da9122_reg[0], &da9122_reg[1] },
+	[DA9121_TYPE_DA9217] = { &da9217_reg, NULL },
+};
+
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
+static int da9121_i2c_reg_read(struct i2c_client *client, u8 addr,
+				    u8 *buf, int count)
+{
+	struct i2c_msg xfer[2];
+	int ret;
+
+	xfer[0].addr = client->addr;
+	xfer[0].flags = 0;
+	xfer[0].len = 1;
+	xfer[0].buf = &addr;
+
+	xfer[1].addr = client->addr;
+	xfer[1].flags = I2C_M_RD;
+	xfer[1].len = 1;
+	xfer[1].buf = buf;
+
+
+	ret = i2c_transfer(client->adapter, xfer, 2);
+	if (ret < 0) {
+		dev_err(&client->dev, "Device read failed: %d\n", ret);
+		return ret;
+	}
+
+	if (ret != 2) {
+		dev_err(&client->dev, "Device read failed to complete\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int da9121_get_device_type(struct i2c_client *i2c, struct da9121 *chip)
+{
+	u8 device_id;
+	u8 chip_id = chip->variant_id;
+	u8 variant_id;
+	u8 variant_mrc, variant_vrc;
+	char *type;
+	const char *name;
+	bool config_match = false;
+	int ret = 0;
+
+	ret = da9121_i2c_reg_read(i2c, DA9121_REG_OTP_DEVICE_ID,
+				    &device_id, 1);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to read device ID: %d\n", ret);
+		goto error;
+	}
+
+	ret = da9121_i2c_reg_read(i2c, DA9121_REG_OTP_VARIANT_ID,
+				    &variant_id, 1);
+	if (ret < 0) {
+		dev_err(chip->dev, "Cannot read chip variant ID: %d\n", ret);
+		goto error;
+	}
+
+	if (device_id != DA9121_DEVICE_ID) {
+		dev_err(chip->dev, "Invalid device ID: 0x%02x\n", device_id);
+		ret = -ENODEV;
+		goto error;
+	}
+
+	name = of_get_property(chip->dev->of_node, "compatible", NULL);
+	if (!name) {
+		dev_err(chip->dev, "Cannot get device not compatible string.\n");
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
+	ret = da9121_get_device_type(i2c, chip);
+	if (ret)
+		return ret;
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
+	/* Set these up for of_regulator_match call which may want .of_map_modes */
+	da9121_matches[0].desc = local_da9121_regulators[chip->variant_id][0];
+	da9121_matches[1].desc = local_da9121_regulators[chip->variant_id][1];
+
+	chip->regmap = devm_regmap_init_i2c(i2c, regmap);
+	if (IS_ERR(chip->regmap)) {
+		ret = PTR_ERR(chip->regmap);
+		dev_err(chip->dev, "Failed to configure a register map: %d\n",
+			ret);
+	}
+
+	return ret;
+}
+
 static const struct of_device_id da9121_dt_ids[] = {
 	{ .compatible = "dlg,da9121", .data = (void *) DA9121_TYPE_DA9121_DA9130 },
 	{ .compatible = "dlg,da9130", .data = (void *) DA9121_TYPE_DA9121_DA9130 },
@@ -89,7 +438,6 @@ static int da9121_i2c_probe(struct i2c_client *i2c,
 	struct device *dev = &i2c->dev;
 	struct regulator_config config = {};
 	struct regulator_dev *rdev;
-	struct regmap *regmap;
 
 	chip = devm_kzalloc(&i2c->dev, sizeof(struct da9121), GFP_KERNEL);
 	if (!chip) {
@@ -99,13 +447,13 @@ static int da9121_i2c_probe(struct i2c_client *i2c,
 
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

