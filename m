Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038A42C8A34
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgK3RAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:00:11 -0500
Received: from mail-eopbgr80088.outbound.protection.outlook.com ([40.107.8.88]:57775
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729125AbgK3RAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:00:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdatMfkMOcleOk7gwnsDtlBliBuLknuoIIlkbMO8DDkRbGRQZKHD6RKKZcoqId+dLmou/MeqLui5NgKIH5/r0cFKk/oiF9h/nEy9garIXjC2PVkRR4KkDpbAzOYftsT2+megXhF3WQB3VnrlbHykJusUzHOewwNgT71nkG/6OUfg2XKOvPICTYPzYHLA1N95vFLWi7gCWjnhvsV63EwNfp84EuDKrcwVSLkS8ks6EsjNDRIoQboR4BDkgaz9Tkzu3Xx7CEhtca5Ui3zbb0mfW9dnIGhOIcUkya/bxNzQHEasYktXlN1mX8gzYh/OVGawYowdPumyOijsx+6UOqhyZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwPiMcg+OXJOw2xuAVXeJHVzcTQClw/h4dbT3IO1p8g=;
 b=NLbPHlfDvSHgG7rRzgcGQuUmJyAoA8/GljK6xH7GF9prACwzYHYIWTfTypLFqQY+rYzm5xN1ZtTdVVH7etudHqHAKlfCI0yzYPYNIsHJFCmZ0QI0DBDYSG5S4RyOw405YhxA/ukeNyzbZrUyP/3QXdqWiZ1aNe2mOLgD0ht7SQpFb6zFDVj5zPM3hbAu4MXIkQ1Eg0qeXMWByI7PWUHh06i07cldkCwr+sgkJQM1/5Zy4+GiY1T2cSLH44PEIFsTQCf5YRnwF7fF+O1qQfbO5GbbXKx9likgTKaOSy0nQHmnV6QyHWsWVeCiOU/uiOAMI6hvGgThjXGYnl8j/+PILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwPiMcg+OXJOw2xuAVXeJHVzcTQClw/h4dbT3IO1p8g=;
 b=yZG72q3oxctrgGKP2zK/qo/r0ly/xXTkBzRCxKNkpY0DI6Lxk5bXansH9X9HyEmec2JZoqOLIXkWauT7+lfAmRh4ksDNWwtLnCi8ZJjs+so3DC7LPmNBKHtgIxxCKZiKi9AtXSjMUfP43va9kBe52uq0RtYAdEVl0Et10tBze4Q=
Received: from AM6PR0502CA0047.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::24) by VI1PR10MB2638.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:ed::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Mon, 30 Nov
 2020 16:59:18 +0000
Received: from VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::11) by AM6PR0502CA0047.outlook.office365.com
 (2603:10a6:20b:56::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 16:59:18 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT054.mail.protection.outlook.com (10.152.13.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3611.23 via Frontend Transport; Mon, 30 Nov 2020 16:59:18 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 30 Nov 2020 17:59:07 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 B75A33FBE8; Mon, 30 Nov 2020 16:59:07 +0000 (GMT)
Message-ID: <aaabd3063593e5172fa6b605884d475df64e6d65.1606755367.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606755367.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606755367.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 30 Nov 2020 16:59:07 +0000
Subject: [PATCH V3 03/10] regulator: da9121: Add device variants
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8d0c506-8664-4a31-2073-08d8955146bf
X-MS-TrafficTypeDiagnostic: VI1PR10MB2638:
X-Microsoft-Antispam-PRVS: <VI1PR10MB263838D121841D3FFA3681D1CBF50@VI1PR10MB2638.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2WUjMQRB5Auw+i9oLbLiBWHxmEEwqlNvUo+BE0Sl0GxMhaCJMeXeu4pY/1r+gxKl2orYc49l4Qlz+bbfKpLBYtfLlOX9F+I+xNOAI85jATE1bzAluGxTFYwNCzJPIGXVJ60Q/M/menbVnJuGCQbGipLsJ/cWePAP+gJR0WsBWckNP6Jhl7EhGaiRQDy+CQYT41kttZIKtYIrvWpf+ujuae/OmNrCCPtOAOQzqxfhHl3ouet7DJ3pAsj4wB2SLiQEJwA8ueQwP9lJZXfaku8V2TcDmXG0lMWfwmqbRrNFSyRTWUlbJoo1v/n3w0hc0k44g4Nsbrmag+KIct5eF7eRobJZiw8ZST/zcdmPZ4k1SSzhi/hghTUiKEhZzBcRHMYNs1qdOT6FWTk6KuvHiz8Mrw==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966005)(8676002)(107886003)(316002)(36756003)(86362001)(54906003)(110136005)(426003)(6266002)(2616005)(186003)(4326008)(336012)(478600001)(42186006)(47076004)(5660300002)(81166007)(82310400003)(356005)(8936002)(26005)(83380400001)(70206006)(70586007)(82740400003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 16:59:18.2146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d0c506-8664-4a31-2073-08d8955146bf
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2638
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

