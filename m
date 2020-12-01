Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10B42CA47D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391447AbgLANxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:53:41 -0500
Received: from mail-am6eur05on2074.outbound.protection.outlook.com ([40.107.22.74]:3935
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391385AbgLANx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:53:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJzWyB9MdMRkmJMlOv+tq9LT1t8L9XPpz3f4Rr3Wml/dbU50ouHBUKyvZPXP/idVdLjzRCGcCkxqXZIMVUq2EPu87cu9JuycZPFCaj0HHTE4c/ZVP3zAQ6A8l5e3bUyRrobTPQvGz2lg+gpWaNXbK7cfDCB5W66qE6AXCbdERQotuA4pdmNyzkPYq7SxgUFKRu8oYk6ufgCmttOhbNKQIqho0tTW5/YNUpyRLs0c0voqfRRPn5RHOUm1ySKebbH5MPjqu0cnGafo3ZKQ5Oy2tKwzloLVyAPWvu/BtfOH/UoRhPTq8Fd7/Vw+f6xMagNxJrStlkfyOYG2G6bAtqSqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Iu5vBZ2IKzXq4kU2cYnFP2z+9G3FMC2RJvR97rsxuc=;
 b=QGjtCOCe1CkJJEiXwuUE2HEKbVWU0+iia0+TylXnxlsU4wMecFCl1AceG1JTtI2igMGpcbqaWbGDAqM9Z9APzHlrQJqvmj+Q0RdJRIh0IDUdIVvPLHLKOzPqjlQ+1U7CQoKZWOHAcWVpT58wAauJFQPwCRj3cG6x/mAx2YCRtavj1aXYpcZR5IvzLWN6OkfEiSTi/HxciVSxjbCjPqYYCS3Uhn+E6qgGNgyxz6825GamIWZy7/mxZFAC5GgO6LfxwnKExraqK9HYd01fEOox+Fj78K4WhrISL4oNznj9C5JuO/nbOijOtABfhSBxU/EtfjjV2fmgPz/sQh1lplrGZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Iu5vBZ2IKzXq4kU2cYnFP2z+9G3FMC2RJvR97rsxuc=;
 b=dBSqcgr9WMpqdk7E9mq6mYkkt1gd6OnPfLGOprL4ObIWs5v6/AcDBFEFkV0XTwSUp5cLFZzH8qVeCTexLFhS+KHzUj42AgMPbaY0vI0b41WXMdOtPxzRGfwXrNUGdF6Enr86ia2Vw1l2UMFgQ4gh7QTuQ9jVSFMhW5/DQ9jjGeU=
Received: from AM9P195CA0023.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::28)
 by DB7PR10MB2188.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Tue, 1 Dec
 2020 13:52:40 +0000
Received: from AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:21f:cafe::77) by AM9P195CA0023.outlook.office365.com
 (2603:10a6:20b:21f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Tue, 1 Dec 2020 13:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT064.mail.protection.outlook.com (10.152.9.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3611.23 via Frontend Transport; Tue, 1 Dec 2020 13:52:40 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 1 Dec 2020 14:52:33 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 869CF3FC09; Tue,  1 Dec 2020 13:52:33 +0000 (GMT)
Message-ID: <1fd53c3ab032ef3c8a92f80a2247381db1c09ced.1606830377.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606830377.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606830377.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 1 Dec 2020 13:52:33 +0000
Subject: [PATCH V4 07/10] regulator: da9121: Update registration to support
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
X-MS-Office365-Filtering-Correlation-Id: 8ec46631-a7d5-4e95-7678-08d896005e88
X-MS-TrafficTypeDiagnostic: DB7PR10MB2188:
X-Microsoft-Antispam-PRVS: <DB7PR10MB2188CB55A411E53C1773F8B5CBF40@DB7PR10MB2188.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SGyyUbuf2JfKepSIKDMyshQsWS1S+BSSZcYKyjDyB6gbQilEOgg0XFD0IrXGS97LjX6cAJpeQGOijHnF2ZUXAUBpWzxRD8a+SshUtyfrbValclKwYetAeGynlIjh21AHJIIWaNASqoThKtEdFqPIaHQu7y6Ol7wgH9S3rVJrzfsGqMpUq3kprPFLZVm31cknRWkUOVVQLkDLiS57Dypkhmf29FZ6kp1uvrRJiZNworRv2yeG5/NI14je9ngjyjlHz2Fm0UimWO+xPAOAAdGUPCM5vZR6XJWdbAVNG1xl9Ko0pZYKhyR5j63jtbRf1cLWCWHEprwqyHLpy70aNsQ4pklH0nDIxct1vl6TXr8WdEDu4+9/gpTb9Sn6MB3tHt1ByItsl4xn4ThRyF9mrnjRuA==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966005)(2906002)(6266002)(107886003)(498600001)(70586007)(82310400003)(110136005)(42186006)(336012)(2616005)(26005)(186003)(36756003)(83380400001)(426003)(54906003)(81166007)(47076004)(86362001)(356005)(4326008)(5660300002)(70206006)(8936002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 13:52:40.0724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec46631-a7d5-4e95-7678-08d896005e88
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2188
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

