Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E462BA9EF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 13:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgKTMPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 07:15:07 -0500
Received: from mail-eopbgr10058.outbound.protection.outlook.com ([40.107.1.58]:45443
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727248AbgKTMPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:15:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcjfTGDHKDYSfLSIlSAAPZ9ljT98VlmOO5hdEFtfjweL6DhgsOHFPOp01NpOAEYtNjXQweyk8acTlrn3wtOMeFgVvqxr4EhYHSnLMPQ2lGrMOYQnOlV4e8xDb+ZCqLcSZeLn+wdrA3pRIYTMOTBmy8nV7Cd5bYZSoHb9aKMsT/q17e/UzxQbkLFyQXSruG2eqqSAQPAkXjxMAp0PcK7f7yUPFbC3imQ4OVADXh/MSsKZiSWFyxmOGSSwqu5TvFv1QFIlqC0xVNyd11aBBZGtIX61vVi2eeFUIvb0dPpTLsxKAiQ6yllRlGA5WAlr4WzqZ5GAvPckY+ZkkIue3DBOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM+S0G8gMn9H8QYTRiMplbNxuoNLQ9hXFKPcKDRfrmw=;
 b=LyR6TMHCGaGn7eBxjsCgAtOPKh5fJ0ZZZbbPcEKUXaMv3fDIqI54t2rmJ4aXDwSUvRX4ESoisfUApA9M9eBQKGPYtbRHmhSXAzEMf4B63X9tHXdilt5IWg69dQQhYKilpXcx9mPBsmaP0NlJQ6DvEkpD23L8avxT3wQEATKrTPXNLKCZI0tRy/NSOCgidK4MeJCvr/XbvxkHcxUd9uzYn2HbxrPzzdSWNiAd8ErlfEbHsSmjV1Wf1LxU3IPMy8YxIl1bmj+drBXHaZ+bih60cY+te5FxqeSyWrZxTDPOWEmRPzgOOCSHoTiwnd0VRa/J2hZyIWFtOpzr7nIYryjFBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM+S0G8gMn9H8QYTRiMplbNxuoNLQ9hXFKPcKDRfrmw=;
 b=X6hgcVWJeej0QDrx79rcbq40tJV1UOinUSjJej/LpF+/O9RFLcowCzJnZjj4TWn5GPTldXM6szst+xws3qEXdzTmCLBVG5tXWOk5BvwKNjr5m/UJqhiddBSIcxBMRs7U8QpyCjtV8a3jz7Sm2jzVCpsV4jm3QZSqpfoZ8vs4oIo=
Received: from AM7PR04CA0009.eurprd04.prod.outlook.com (2603:10a6:20b:110::19)
 by DB8PR10MB2730.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 20 Nov
 2020 12:14:56 +0000
Received: from AM5EUR02FT003.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:110:cafe::13) by AM7PR04CA0009.outlook.office365.com
 (2603:10a6:20b:110::19) with Microsoft SMTP Server (version=TLS1_2,
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
 14.3.468.0; Fri, 20 Nov 2020 13:14:56 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 0F3843FBE0; Fri, 20 Nov 2020 12:14:56 +0000 (GMT)
Message-ID: <a2b4186b47e4786bd856ec11d2353b7183c22af2.1605868780.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <adam.ward@diasemi.com>
Date:   Fri, 20 Nov 2020 12:14:56 +0000
Subject: [PATCH 6/9] regulator: da9121: Update registration to support
 multiple buck variants
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3e935b2-830c-4b72-0f8e-08d88d4de51f
X-MS-TrafficTypeDiagnostic: DB8PR10MB2730:
X-Microsoft-Antispam-PRVS: <DB8PR10MB27302CBDFC5CCAE60C65E2DDCBFF0@DB8PR10MB2730.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4Sy4YvU9U73nbvoXb91pc9LCTn/PATSkpihctz1Z+gyT4IC87vOQaAsiU9nXJVuF36grXBNjtE9LrhHRMc3codeUmg9r1yw2aQLfWbnEt5clk0LPzrpuiS+4GzVNZpPWuovpwo5o1cf19+d/qQW6YDlMSBYG+Zztcvjs4A0HCIELX2ZnanTzK4BsANouxrptGVFR5cvLT3dPYCIngRm+LJKJshfm8EJQYMCI74JwTfSK5kEXpJcxATnz672xz2qp24rb2FiHDp+KvbBDLIpSbcHseRs32+drbtOhaL1GqmnmtcbpHWUExuwVqVB/SemQTnW3ntiiJT37u87BE8jnp3hvtHwOA6jyaDEz8yB3mvTlsdBRpuA5kb64idXQWtZYa/PcREOMOMxUOTvzde8ogHnUnculPEQljOks4WU+lkVQJtJimiBmiPjJee1zUvg
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(39850400004)(376002)(346002)(136003)(46966005)(82310400003)(356005)(81166007)(186003)(316002)(42186006)(33310700002)(26005)(54906003)(110136005)(4326008)(6266002)(2616005)(47076004)(478600001)(82740400003)(83380400001)(8676002)(70206006)(2906002)(8936002)(36756003)(336012)(44832011)(426003)(70586007)(36906005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 12:14:56.6522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e935b2-830c-4b72-0f8e-08d88d4de51f
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT003.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2730
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checks DT matches tally with variant maximum and register accordingly.

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 81 +++++++++++++++++++++++++++++++-----
 1 file changed, 70 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index 5020774..13b0aad 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -314,6 +314,69 @@ static struct da9121_pdata *da9121_parse_regulators_dt(struct da9121 *chip)
 }
 #endif
 
+static int da9121_set_regulator_config(struct da9121 *chip)
+{
+	struct regulator_config config = { };
+	unsigned int max_matches = chip->pdata->num_buck;
+	int ret = 0;
+	int i;
+
+	if (max_matches > variant_parameters[chip->variant_id].num_bucks) {
+		dev_err(chip->dev, "Too many regulators in the DT\n");
+		ret = -EINVAL;
+		goto error;
+	}
+
+	for (i = 0; i < max_matches; i++) {
+		const struct regulator_desc *regl_desc =
+			local_da9121_regulators[chip->variant_id][i];
+		int id = regl_desc->id;
+		struct gpio_desc *gpio_ren;
+
+		if (chip->pdata->gpiod_ren[i])
+			gpio_ren = chip->pdata->gpiod_ren[i];
+		else
+			gpio_ren = NULL;
+
+		config.init_data = chip->pdata->init_data[i];
+		config.dev = chip->dev;
+		config.driver_data = chip;
+		config.regmap = chip->regmap;
+		config.of_node = chip->pdata->reg_node[i];
+
+		switch (id) {
+		case DA9121_IDX_BUCK1:
+		case DA9121_IDX_BUCK2:
+			config.ena_gpiod = gpio_ren;
+			break;
+		default:
+			dev_err(chip->dev, "Invalid regulator ID\n");
+			ret = -EINVAL;
+			goto error;
+		}
+
+		/*
+		 * Hand the GPIO descriptor management over to the regulator
+		 * core, remove it from GPIO devres management.
+		 */
+		if (config.ena_gpiod)
+			devm_gpiod_unhinge(chip->dev, config.ena_gpiod);
+
+		chip->rdev[i] = devm_regulator_register(chip->dev,
+					regl_desc,
+					&config);
+		if (IS_ERR(chip->rdev[i])) {
+			dev_err(chip->dev, "Failed to register regulator %s, %d/%d of_map_mode:%p\n",
+				regl_desc->name, (i+1), max_matches, regl_desc->of_map_mode);
+			ret = PTR_ERR(chip->rdev[i]);
+			goto error;
+		}
+	}
+
+error:
+	return ret;
+}
+
 /* DA9121 chip register model */
 static const struct regmap_range da9121_1ch_readable_ranges[] = {
 	regmap_reg_range(DA9121_REG_SYS_STATUS_0, DA9121_REG_SYS_MASK_3),
@@ -586,9 +649,6 @@ static int da9121_i2c_probe(struct i2c_client *i2c,
 {
 	struct da9121 *chip;
 	int ret = 0;
-	struct device *dev = &i2c->dev;
-	struct regulator_config config = {};
-	struct regulator_dev *rdev;
 
 	chip = devm_kzalloc(&i2c->dev, sizeof(struct da9121), GFP_KERNEL);
 	if (!chip) {
@@ -606,16 +666,15 @@ static int da9121_i2c_probe(struct i2c_client *i2c,
 	if (!chip->pdata)
 		chip->pdata = da9121_parse_regulators_dt(chip);
 
-	config.dev = &i2c->dev;
-	config.of_node = dev->of_node;
-	config.regmap = chip->regmap;
-
-	rdev = devm_regulator_register(&i2c->dev, &da9121_reg, &config);
-	if (IS_ERR(rdev)) {
-		dev_err(&i2c->dev, "Failed to register da9121 regulator\n");
-		return PTR_ERR(rdev);
+	if (IS_ERR(chip->pdata)) {
+		dev_err(chip->dev, "No regulators defined for the platform\n");
+		return PTR_ERR(chip->pdata);
 	}
 
+	ret = da9121_set_regulator_config(chip);
+	if (ret < 0)
+		goto error;
+
 error:
 	return ret;
 }
-- 
1.9.1

