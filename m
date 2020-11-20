Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA272BA9E8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 13:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgKTMPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 07:15:03 -0500
Received: from mail-eopbgr30084.outbound.protection.outlook.com ([40.107.3.84]:6587
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727061AbgKTMO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:14:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHCBBOdSQwSqS2EKKavyg3BQfsdzmCxPlmBcKdpd4lJ5KBsoD3NbuJfj1vj127l1dNuJAnZ12VLiLjTigaslyHwGO8hUurD5OP7H9rpIXmwk9Lly0m1TlDq85ZYwv86xI33QY3Iqtc9c17Luq+n5QMQYb45nB/8QlfFZOtvi+veSkzeYggm2ud3e3+ricab7E5/Kh9VM0aH0xSVdH0A/cRFiLPkGUhVa3xAx+GfMq6YIfJlWf4KuegrqsWLgPkfql2HcCG1niCqL7Op5T8nilEFEXSAzib1NOqsxIOXNuB1Ya3dPY0BKSAYnaaTmCKc8wQFogMeHoSdg2Ipt7gM8Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwPiMcg+OXJOw2xuAVXeJHVzcTQClw/h4dbT3IO1p8g=;
 b=Fhl1J3QQ//8ezUCHARwtCfA/dmBXu3RfTCgrnr2f+ibBX9hpkEnY/1EUin07zT9HGCFc5wARIxOUIP51P1jAhsh+AcgZM0zVFStsNjgmykGY9YkB7ATKPbB9CZ/qit19QvuBqMWXPaImvsJB8I6DMKFNPvA8dXYlOtO/SE/f4+SJi3GMvlEdol69BLpPQlHGXft0JS4Bawt7TSKwnaolYtlTG+5m78z6jYPIelyPzEMcLJFyirVSEuXyPj5ZroljxbYVSufSM2m6BmsfjzF7OUCwF9hOpC3DBqN2Esokci7ToHRCjsK2nHq94AkQFX0nEiBKwW/GtfZYI+9unK3yrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwPiMcg+OXJOw2xuAVXeJHVzcTQClw/h4dbT3IO1p8g=;
 b=E2BStZudTM83w5OHIet04dHvtvrCXM0Dm/NpDmjpgHdlvQWBawgiYWWi6Iu78CPPmx2E5gCDk4dBQdLgJDLlYhtcBcVpJM3X3y4qnxRmwsL8c93IJ+XPcpzwybzxRIRfcIdvdvS7uHFm2ETCWrOb7khGEuQBaQbJKaehyzeLcTk=
Received: from AM6P192CA0046.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::23)
 by VI1PR10MB1678.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:802:34::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Fri, 20 Nov
 2020 12:14:54 +0000
Received: from AM5EUR02FT046.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:82:cafe::17) by AM6P192CA0046.outlook.office365.com
 (2603:10a6:209:82::23) with Microsoft SMTP Server (version=TLS1_2,
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
 14.3.468.0; Fri, 20 Nov 2020 13:14:53 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 02C653FBE1; Fri, 20 Nov 2020 12:14:53 +0000 (GMT)
Message-ID: <9e8c1fe6438ddabf464168e3a8b1c0aa4fea9c14.1605868780.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <adam.ward@diasemi.com>
Date:   Fri, 20 Nov 2020 12:14:52 +0000
Subject: [PATCH 3/9] regulator: da9121: Add device variants
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b29ebb2-273a-403a-a930-08d88d4de392
X-MS-TrafficTypeDiagnostic: VI1PR10MB1678:
X-Microsoft-Antispam-PRVS: <VI1PR10MB1678DD43F22034DF4557C3CECBFF0@VI1PR10MB1678.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/HY+ZZxfkElf93ZXR5JpzzXH4xxolMndqyGK/SWjPmM4rpUB7YuqtJJu0Ydbln+IvlT80MsWYGtTwHzRcwDx7+1MDCzSZoWoGr7GF95I+ajd+6CyAqzugtMX+bX5uQEbg3rSP57Rzqc0qBWMu0s7BqVhktpztxODinEaQQb/IoD/x/2gmJP6Owiq0vSlvSUqH8S7sH+LJoPoVzzgsWAYK44Jz0eRl+llRj4G8hyViQQr6FP7+Kbku3ySBBSJy060uPO31rjV4MnGQr7ptI2UOHU1qVl4Db42fYnwdtaaSUVaH92fGGRE8xdJPNSJ024ie0nYVbsX/UWUzZ2uA68kQkDxvyqKGGfZF8KPdCXj+v49pH6PUY/eoni8/tz6q5Uu8debZWpt5izPWR7qjzAOvF6u8wxcOHdDsielvdvHma8YjA3IrNFF8WedKp8Ai21
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(39850400004)(376002)(136003)(396003)(46966005)(8936002)(4326008)(81166007)(70206006)(70586007)(54906003)(478600001)(42186006)(110136005)(82310400003)(2616005)(186003)(336012)(26005)(83380400001)(36906005)(316002)(356005)(8676002)(44832011)(82740400003)(47076004)(33310700002)(426003)(2906002)(6266002)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 12:14:54.0552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b29ebb2-273a-403a-a930-08d88d4de392
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT046.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1678
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic support for configuration to reference variants of this device,
and track the selected variant within the driver.

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 46 +++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index c11fe04..5bebdb2 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -11,6 +11,12 @@
 #include <linux/i2c.h>
 #include "da9121-regulator.h"
 
+/* Chip data */
+struct da9121 {
+	struct device *dev;
+	int variant_id;
+};
+
 #define DA9121_MIN_MV		300
 #define DA9121_MAX_MV		1900
 #define DA9121_STEP_MV		10
@@ -53,19 +59,46 @@
 };
 
 static const struct of_device_id da9121_dt_ids[] = {
-	{ .compatible = "dlg,da9121", },
+	{ .compatible = "dlg,da9121", .data = (void *) DA9121_TYPE_DA9121_DA9130 },
+	{ .compatible = "dlg,da9130", .data = (void *) DA9121_TYPE_DA9121_DA9130 },
+	{ .compatible = "dlg,da9217", .data = (void *) DA9121_TYPE_DA9217 },
+	{ .compatible = "dlg,da9122", .data = (void *) DA9121_TYPE_DA9122_DA9131 },
+	{ .compatible = "dlg,da9131", .data = (void *) DA9121_TYPE_DA9122_DA9131 },
+	{ .compatible = "dlg,da9220", .data = (void *) DA9121_TYPE_DA9220_DA9132 },
+	{ .compatible = "dlg,da9132", .data = (void *) DA9121_TYPE_DA9220_DA9132 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, da9121_dt_ids);
 
+static inline int da9121_of_get_id(struct device *dev)
+{
+	const struct of_device_id *id = of_match_device(da9121_dt_ids, dev);
+
+	if (!id) {
+		dev_err(dev, "%s: Failed\n", __func__);
+		return -EINVAL;
+	}
+	return (uintptr_t)id->data;
+}
+
 static int da9121_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
+	struct da9121 *chip;
+	int ret = 0;
 	struct device *dev = &i2c->dev;
 	struct regulator_config config = {};
 	struct regulator_dev *rdev;
 	struct regmap *regmap;
 
+	chip = devm_kzalloc(&i2c->dev, sizeof(struct da9121), GFP_KERNEL);
+	if (!chip) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	chip->variant_id = da9121_of_get_id(&i2c->dev);
+
 	regmap = devm_regmap_init_i2c(i2c, &da9121_regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
@@ -80,11 +113,18 @@ static int da9121_i2c_probe(struct i2c_client *i2c,
 		return PTR_ERR(rdev);
 	}
 
-	return 0;
+error:
+	return ret;
 }
 
 static const struct i2c_device_id da9121_i2c_id[] = {
-	{ "da9121", 0 },
+	{"da9121", DA9121_TYPE_DA9121_DA9130},
+	{"da9130", DA9121_TYPE_DA9121_DA9130},
+	{"da9217", DA9121_TYPE_DA9217},
+	{"da9122", DA9121_TYPE_DA9122_DA9131},
+	{"da9131", DA9121_TYPE_DA9122_DA9131},
+	{"da9220", DA9121_TYPE_DA9220_DA9132},
+	{"da9132", DA9121_TYPE_DA9220_DA9132},
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, da9121_i2c_id);
-- 
1.9.1

