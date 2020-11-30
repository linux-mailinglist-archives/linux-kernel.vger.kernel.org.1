Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DF92C8A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgK3RAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:00:20 -0500
Received: from mail-eopbgr60082.outbound.protection.outlook.com ([40.107.6.82]:23522
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729163AbgK3RAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:00:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnQ7+jzJhoUI7cHQC+nmRFXgR5cDImGFUT0VjA7hWNWnvkzNV08iLqPKbpO+zhfLjLyis6qfTe3Pm9/aW7B1JVi/dSZeYU9kSpadGX6y+zNFsKve32BtdXTvamOP99LQ2s+0Si16T1FcUpDv6v89p81q+haI9vE7DUQ06Oz3AlVkaTKqBRpYKbxkmkJKypclH4bUSj9QaGn2uYSf7nu4pee+1ZmUdwz0FWPmsPbxKmWr6S4/41NBfQ2Tdp6WHD9i4WA1fx7xltzXP/XZqFCpS/yABb7R56GDpTJqEX5R1cYey36lqDJgOyV84es2joBAsll3hrbgRjIcQc1IVNtXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Iu5vBZ2IKzXq4kU2cYnFP2z+9G3FMC2RJvR97rsxuc=;
 b=Q9M1Bl/6J1Ye0yfOMT4aIO0S35DPp5U0yloJJlRn8OJQ0Fb95CF4V3DG1jsfmuoko0EV+1t7RXjCih3VHnVWE9KVINTJ37qoPrh17LNqEuGN0rOXEJb6BDgfWd5N9Vf/OLSwKKBSV4n6QFZWQndVsNZ+9Q5h5YRcWkQx7cHtVkUdqvzyDKKSttqCipqi5yvU5opOurRGteOfFEh35NgC8DtA1x0Dvn4MoHamioICryvbU5KoLTGc//Iwp/aK5HZabEe5uyvQpzervaStrEq5pjwV6vX+wP62tVMZ/Ex3J6r5Wtkc3v0+mWWAmXnxE/YYelocKJ+Onvk/3K2HHM3NDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Iu5vBZ2IKzXq4kU2cYnFP2z+9G3FMC2RJvR97rsxuc=;
 b=XQRY+RLXbIt0HZ8X3PzcRK9N6mcxd3GfmJ2IySq7+FC/mFeiuvV10BfhABMCsljxIqATGTfudDzhKKTJSFXyAugMOuvKqgunODEgGolmlItevQDyBEpnIyK9UoZT++txC8eC7sWXjdoldATh7U2kLB7+gatB42yT5iB9iz6qqgE=
Received: from AM6PR0502CA0042.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::19) by PR3PR10MB4046.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:a3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Mon, 30 Nov
 2020 16:59:29 +0000
Received: from VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::50) by AM6PR0502CA0042.outlook.office365.com
 (2603:10a6:20b:56::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 16:59:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT054.mail.protection.outlook.com (10.152.13.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3611.23 via Frontend Transport; Mon, 30 Nov 2020 16:59:29 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 30 Nov 2020 17:59:12 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 C65C13FBD8; Mon, 30 Nov 2020 16:59:11 +0000 (GMT)
Message-ID: <1fd53c3ab032ef3c8a92f80a2247381db1c09ced.1606755367.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606755367.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606755367.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 30 Nov 2020 16:59:11 +0000
Subject: [PATCH V3 07/10] regulator: da9121: Update registration to support
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
X-MS-Office365-Filtering-Correlation-Id: 157bab08-a95c-4090-d8b1-08d895514d56
X-MS-TrafficTypeDiagnostic: PR3PR10MB4046:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4046C626EBECDB52F1CDB5D9CBF50@PR3PR10MB4046.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SKuyikjl0mouczsi89jCmOVrsrH2jSyO9c5VcJs5EJffYE/udRVcUgOaaZAqe8Awh8p8Aou8EtsTweM4jeJdVZryhsl5T6SpHTNI5ESQGuMEIg6FKbeQ6V1z9tgV4QZMHx62ITeR2PBXDL3HMLgTmgrbmXh+nVwzG8BwUnNNtyRg7cCt7hpufl1Ndzim0FFqZLLFzZ9ZGbKSpgIaEfXm04DspD1DQWcSMW5Rhp+RnAg3Tw82f8WVH1UnuZ8noeNRmaMO2NP73cxmpaeKXhvE3PXux13yuO1Yd02+sJ2IUNLeVI5m4uLUF8mzYelyICbfbd2mnteZt3/EfE/hFSKJ+NUXuUjxzuf9jj/aOXEAP2m0+4+6UHw7k3R4h7qWHxyLJ505jewbSjvuhzxZ0U+Tdw==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966005)(107886003)(82740400003)(8676002)(8936002)(70206006)(6266002)(356005)(36756003)(2906002)(81166007)(5660300002)(82310400003)(86362001)(47076004)(478600001)(186003)(54906003)(70586007)(110136005)(83380400001)(336012)(42186006)(26005)(316002)(4326008)(426003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 16:59:29.2623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 157bab08-a95c-4090-d8b1-08d895514d56
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4046
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

