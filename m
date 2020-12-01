Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909592CA474
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391412AbgLANxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:53:34 -0500
Received: from mail-db8eur05on2067.outbound.protection.outlook.com ([40.107.20.67]:28513
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391384AbgLANx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:53:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUZc9yG7M7Un9tzjDSaI2NeTmAp9o3rws8+iliXgFN/LjGfMt5MM/wkGFvYj4sRn50LB5BICzJiNdvv39zAE2+3/FpqUoTDU4TOvpdyr/G3HntBQ3lkyYHNF072dS9Uizye/ll1fYMVeXxu+7RuJ8d0LcpYO45cK3B4xzahmJRzA2E02nKw4B1ykAVGyWru2UEvj+XLYdSyaGa+LWN0Q1PbXFHzmi4NrBFa6WApKp0iepxcndf7mbo0sbB3zjnvNXc+MtqHKyJ/SEV1c4+pa4PNOq2mCiG0LuV+K4/5dpPvVMdprHQT1RHYWz994racqvQ5cJTTa1DyYu8OJXta9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwPiMcg+OXJOw2xuAVXeJHVzcTQClw/h4dbT3IO1p8g=;
 b=NbXTLQDOc2+0+HFoRI2JW1MDun6eROk5UI6htqWJCLiwICzNZMDGVlOP0QYQymT87qWLRYFSvnrT/WRrJCfR5UsEj2aq/Ubm1abERHQov/MytcraWTNWQE94VTqg+JZxLy5O8jAFRgRpdPdUdruo6kCBYjvVoeVkFw2fkQ28fc6jZTEj0PbkkfpcTiUL0u1SvgU81N/p8Cf+i7p8hGdXC6A+iFKOPUfeq/f+6f4pGm7m8H8hIp7Dgzvz8zlQF7P+9pG0zbWp5J7x5h6nJEUz1C+tmIzqo/TLzQJPHXHm8McsFpby+Be/uV6bBftE5KvIxwpDSiJfvUNfi9PM2WSV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwPiMcg+OXJOw2xuAVXeJHVzcTQClw/h4dbT3IO1p8g=;
 b=cS+xM3MDUbtML4uoa9gjHAMcJKU000pO4IYGZPbts/qFgPmXddK01oVIKUExfb8+GIUkuk6nbUv2eAVZ5TIiX1Fg1ELCpLPNQU/3S9UKlylY4vcPof2KJSm33JHK4nu0nCvjZyNe0dFNiDjfP0VgNN15/UYKW3bDN1qMz/urU40=
Received: from AM9P195CA0010.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::15)
 by VI1PR1001MB1215.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 1 Dec
 2020 13:52:32 +0000
Received: from AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:21f:cafe::ac) by AM9P195CA0010.outlook.office365.com
 (2603:10a6:20b:21f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23 via Frontend
 Transport; Tue, 1 Dec 2020 13:52:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT064.mail.protection.outlook.com (10.152.9.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3611.23 via Frontend Transport; Tue, 1 Dec 2020 13:52:32 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 1 Dec 2020 14:52:29 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 765B63FBBB; Tue,  1 Dec 2020 13:52:29 +0000 (GMT)
Message-ID: <aaabd3063593e5172fa6b605884d475df64e6d65.1606830377.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606830377.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606830377.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 1 Dec 2020 13:52:29 +0000
Subject: [PATCH V4 03/10] regulator: da9121: Add device variants
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ed44e28-e6e4-4489-7231-08d8960059d1
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1215:
X-Microsoft-Antispam-PRVS: <VI1PR1001MB12153932AC5EAE6192F83DE7CBF40@VI1PR1001MB1215.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmZDGPMmIUnnx6z7N96ZmopbPt/DGVpcOoZA9a/TtS3IJ2yp/rCJYdECOPWRixsRmkhdPMIR4MQAH7yVeJ755EdeLV/zXww42Hhvgi/TjK3ZR8oda9oFRITRovRg3TAgwSUu3998W1ov/GmoX6ArQtQzXnULfEX1P0q9IzJNjC9FtqcaokKaPAtXIiQKNbeQ60Q2UdTDhtPdup4an7nYNM8IQ9e1YadYLkiFPYjzuVIix177RozfgqxDLITmgK0azZWF6XVzLLZ66+0ihqobqUQRIJH6EtkInLLwdcvxk/Yn5Z6IXJpX4pk8cntE9idUBXyjVDkMeBOfZbB1phEKlObaHGY+WUogYAsyKbIzZ8u1b+cGaPLy/PRd1ZTiGyJAGN+6uUpHlcS+FaeD8+uvgg==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966005)(2616005)(4326008)(8676002)(2906002)(42186006)(86362001)(110136005)(54906003)(36756003)(8936002)(498600001)(70206006)(70586007)(426003)(5660300002)(107886003)(26005)(186003)(356005)(81166007)(83380400001)(6266002)(47076004)(336012)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 13:52:32.1621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed44e28-e6e4-4489-7231-08d8960059d1
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1215
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

