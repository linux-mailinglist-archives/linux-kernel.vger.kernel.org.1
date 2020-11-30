Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12C22C887B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgK3Pnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:43:51 -0500
Received: from mail-db8eur05on2074.outbound.protection.outlook.com ([40.107.20.74]:25470
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727450AbgK3Pnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:43:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1FDs7mH6lD3Fy+w94XYXBZZbRZq67xKJkk/xCJE0z+vs5EKNvOYKPWTtcJy9XAm2tPE3pqhzHfOU/x5n75Y9CkoboD9y6dJybKi++JmVrsDuBcMrDVIioQIkv2WRElz9apxE/GEzZ5OhRXqgaoGtPIK0BYaDuQ25DO5ngtEqoNN5/9n1noRL/s5+R3rj7X09fHx+mOrNgQK16Q24ogTJBFaml0O4/JCUi5jFTHJFo4UKNz5s++5pIit9ManoQkUQhaNKno2KqQd55r4lj7Ptrg/cVY7WLqKKXa9q+0aZdi8GUIUb6zLw+CqPnd9QTpfeeW2vwkTEvRdwELW6JEk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Iu5vBZ2IKzXq4kU2cYnFP2z+9G3FMC2RJvR97rsxuc=;
 b=TloaM8I6mshmW0WTEKaAinbLPqk37kmdK+DUDcbiyIPqyhgtdWFWM/jD+G5vdeVWbiXPA9NIrDZbMYNeRe9r9Jtmfl+mdkOZvkneNVWMc8NITvVmQ0LcSHhB9UoH4ALY1WBkQ2vJ6icKTgbSwgs5lH6j0asH8Oy4p9UcMV//XbgequIvBhLsdkZRaInlM1llnRb7v95M9u9L3fll1pr61GC8eU2TqD2UZdLBF7MzGoon4Prv5uUowiA0EXJYi++PY0KloOEWd23KW+x/9gHHqWn1kooVo+2S5Ka8dx0+tx6tedmxm6ynFrDnHWD/uTtsL4lxePVw+3SaRDUAvYl0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Iu5vBZ2IKzXq4kU2cYnFP2z+9G3FMC2RJvR97rsxuc=;
 b=HJR3ZOXR8+p14Ayi7x6fHWVr3LVz9QgLdBqMnFvDjhRGnTLjHopZYehiPH0ApwrJuu34BL7MJvhcFB6FN1sbq9uz41lxtX5WS9IVc3suCDY3/7ptMOs5mWsXO9HxzMmwL5FXYlfqqjm3KIBVcVerAJX8CoITtzQDj9qC7pGE/c0=
Received: from MR2P264CA0176.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::15) by
 DB8PR10MB2811.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:af::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.25; Mon, 30 Nov 2020 15:42:58 +0000
Received: from VE1EUR02FT045.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:501:0:cafe::50) by MR2P264CA0176.outlook.office365.com
 (2603:10a6:501::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 15:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT045.mail.protection.outlook.com (10.152.12.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3589.20 via Frontend Transport; Mon, 30 Nov 2020 15:42:58 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 30 Nov 2020 16:42:50 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 B4B973FBE4; Mon, 30 Nov 2020 15:42:50 +0000 (GMT)
Message-ID: <276eb118cfac45c96b7229e97c0977ee8b36fd92.1606750000.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606750000.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606750000.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 30 Nov 2020 15:42:50 +0000
Subject: [PATCH V2 6/9] regulator: da9121: Update registration to support
 multiple buck variants
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2866425b-f062-4160-0bed-08d895469cfe
X-MS-TrafficTypeDiagnostic: DB8PR10MB2811:
X-Microsoft-Antispam-PRVS: <DB8PR10MB28118973A022466D9FD4F55FCBF50@DB8PR10MB2811.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4Q8kPTAwja0GyWfoecCHR9kiMZuz4TydSAeqxzuQ3AdD2eoyD/K0LBiLqjGbCcoYoMUAebeTGjyUAZldXJoZMc/ibO9My2GYu07OTcpzPj5CeQ3yiDdReVCmXST4z8tXWz4B/TYGScxm1tEGRPLnfSJX/K5ldrT3FoJGtZfeyLr66JBxBGJoxX96oGfHzZGNPmR4weHPPjzL3VJNBWB46bd4WYrKNRYhENBeRxmUa96hDgVem9pUv8nWo+LZM8gbMco5CNUr3ll8CTCNYnbO3emenEUyxvO2Guo5Junp9jhSq8xc+Ua2T7Znh1HseG09uBj88TV9/dNrde45DTp/spcp3vKApd6KOp1UM74H5SlGvKk4FuA/SQBEpWtK7j2BQEy6qkMUQiCgU+AgEVMBw==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966005)(47076004)(70206006)(8676002)(81166007)(356005)(6266002)(82740400003)(316002)(54906003)(110136005)(26005)(107886003)(42186006)(2906002)(82310400003)(36756003)(4326008)(8936002)(186003)(5660300002)(70586007)(86362001)(478600001)(2616005)(336012)(426003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 15:42:58.4340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2866425b-f062-4160-0bed-08d895469cfe
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT045.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2811
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add function which iterates the regulator descriptors for the confirmed
variant ID and registers each buck.

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 44 +++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index 1f74371..6c82441 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -31,6 +31,7 @@ struct da9121 {
 	struct device *dev;
 	struct da9121_pdata *pdata;
 	struct regmap *regmap;
+	struct regulator_dev *rdev[DA9121_IDX_MAX];
 	int variant_id;
 };
 
@@ -291,6 +292,35 @@ static int da9121_of_parse_cb(struct device_node *np,
 	[DA9121_TYPE_DA9217] = { &da9217_reg, NULL },
 };
 
+static int da9121_set_regulator_config(struct da9121 *chip)
+{
+	struct regulator_config config = { };
+	unsigned int max_matches = variant_parameters[chip->variant_id].num_bucks;
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < max_matches; i++) {
+		const struct regulator_desc *regl_desc =
+			local_da9121_regulators[chip->variant_id][i];
+
+		config.dev = chip->dev;
+		config.driver_data = chip;
+		config.regmap = chip->regmap;
+
+		chip->rdev[i] = devm_regulator_register(chip->dev,
+					regl_desc, &config);
+		if (IS_ERR(chip->rdev[i])) {
+			dev_err(chip->dev, "Failed to register regulator %s, %d/%d\n",
+				regl_desc->name, (i+1), max_matches);
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
@@ -522,9 +552,6 @@ static int da9121_i2c_probe(struct i2c_client *i2c,
 {
 	struct da9121 *chip;
 	int ret = 0;
-	struct device *dev = &i2c->dev;
-	struct regulator_config config = {};
-	struct regulator_dev *rdev;
 
 	chip = devm_kzalloc(&i2c->dev, sizeof(struct da9121), GFP_KERNEL);
 	if (!chip) {
@@ -539,16 +566,7 @@ static int da9121_i2c_probe(struct i2c_client *i2c,
 	if (ret < 0)
 		goto error;
 
-	config.dev = &i2c->dev;
-	config.driver_data = chip;
-	config.of_node = dev->of_node;
-	config.regmap = chip->regmap;
-
-	rdev = devm_regulator_register(&i2c->dev, &da9121_reg, &config);
-	if (IS_ERR(rdev)) {
-		dev_err(&i2c->dev, "Failed to register da9121 regulator\n");
-		return PTR_ERR(rdev);
-	}
+	ret = da9121_set_regulator_config(chip);
 
 error:
 	return ret;
-- 
1.9.1

