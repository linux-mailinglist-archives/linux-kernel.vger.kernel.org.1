Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3642C8873
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgK3Pnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:43:42 -0500
Received: from mail-db8eur05on2043.outbound.protection.outlook.com ([40.107.20.43]:62561
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727309AbgK3Pnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:43:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvwE7JMkdxcti1btWGaKLaC/6yzzdGmX/NUzpjmRzn5f4rxqjOjxqyhX/wvpspFBPEFGC0hDqUKMCTdlzVUHCy/5iPn3YDOsYrzQAFkPrpVvB+Q9GBCMH26tacgLKwZQGzGqt1wKsBKok5MmqNHslXgQxLI1KeLT2iPfyXhZ8jUnhNEduc2N7luSKAlWuiCnSP3QA/MYjtLQsEiR8CzdcFIPC9s9G7/rCKqud92EKJlrWzZsJ6FR5IQkmnKzlRlGxrPG+QrSfRaVaMipFsCqkzmn0wsutLkUrc3HTxeTaQ9e9Rzk0C8jsO+vPG/Z4dINo0KhdUP8HuLPvisixyGB9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwPiMcg+OXJOw2xuAVXeJHVzcTQClw/h4dbT3IO1p8g=;
 b=KsXfm4UqFj9Ba/FO/M5LhnDo+RTXsJUWT3sYx8tfnjHlYzTIBuSHHN7KK1tDMeJGiKejoD1TddNzJ3UP/N/IDQdSlBQmQfUByNoxDi89aeaasxufocvHzCmzFjZDqIbEEnLjy5Gpa9nS1ToxqD2wO5AS1uwS1rpO8kCEbJDIIVt4QYT4fXnnvXVv8Wb4jeFwXRm/Ba1DhgKM/+X0aD6bSJ3VjcAPxjzk6w5qXSl3Jc54OSACBZ+bpVSv/NNHZlmiJofv/KSHQJXmjGOKRXgpgjrosiyLs007HDyon+QUvtwIk6MUznmfG6kowtid5SqcJc37nht+gKKXM5Jw/4MuUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwPiMcg+OXJOw2xuAVXeJHVzcTQClw/h4dbT3IO1p8g=;
 b=YfJyRjQ9Q/lxc8NRxBo//4ZKk9K5QXokzXNmh43LfAYCE8Q0qmapplIiMaJwxKXsicMYmDMEXxRAQEgyecvEUGlHtizuI2Mq5mZCYKCT7YFtvuw2zP5Ym56JUxceHX15vhsdUHcA/xPiFlaZJfSqRxQ13p4T5FLPKrsNw2MfTrg=
Received: from MR2P264CA0171.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::10) by
 VI1PR10MB2062.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:2d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.23; Mon, 30 Nov 2020 15:42:51 +0000
Received: from VE1EUR02FT045.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:501:0:cafe::56) by MR2P264CA0171.outlook.office365.com
 (2603:10a6:501::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 15:42:51 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT045.mail.protection.outlook.com (10.152.12.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3589.20 via Frontend Transport; Mon, 30 Nov 2020 15:42:51 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 30 Nov 2020 16:42:46 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 A596C3FBE7; Mon, 30 Nov 2020 15:42:46 +0000 (GMT)
Message-ID: <39ce32ad38210b7cbb5fc3a0d35083bc6641dcc5.1606750000.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606750000.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606750000.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 30 Nov 2020 15:42:46 +0000
Subject: [PATCH V2 2/9] regulator: da9121: Add device variants
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04324422-c92a-4020-ed3d-08d89546989c
X-MS-TrafficTypeDiagnostic: VI1PR10MB2062:
X-Microsoft-Antispam-PRVS: <VI1PR10MB20626AF1375306F5878EC6CACBF50@VI1PR10MB2062.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lSj26qQNLrvZiii97yBnFtC0Z3EafWUWVoTw72FVcEa6vm2iga1KBEihHfz6CNoc6z3iM8znfHGxrnzjag3qVVbetg/79cpK6xhj/TbToyVPwiEO5Of8b5mvyIB3l8RkbZqVN1o9SjM+jWLdOL0UW3DojuxsgUEAvmMH0IA8KWZW/LDVsgwI8IQ6ENhxzg4QdMNrYOuHMw80n0PYKI41+NFhmByX7q2v7f1XNGz1ctmuteyZPwl1Opt7Wc81ydrYIQAHdDhRa0hTSlEUd8n8szpLybWpumCIs+mGwGrgnukxGGjHdnnyH7bycCCXAjcmh/J/jujRI7/2sPhKzYPIJOHLtbf7lYuUbIeWibA610SrH6C+zaYE37TgckbX5VF740WdfGk2oUS6KF/Lr/1QBA==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966005)(336012)(2616005)(26005)(82310400003)(110136005)(426003)(36756003)(82740400003)(186003)(6266002)(8676002)(107886003)(47076004)(2906002)(70206006)(81166007)(478600001)(86362001)(5660300002)(356005)(8936002)(70586007)(83380400001)(4326008)(54906003)(42186006)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 15:42:51.1016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04324422-c92a-4020-ed3d-08d89546989c
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT045.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2062
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

