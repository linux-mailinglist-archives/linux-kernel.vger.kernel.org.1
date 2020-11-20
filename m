Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D388C2BA9EB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 13:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgKTMPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 07:15:06 -0500
Received: from mail-eopbgr10071.outbound.protection.outlook.com ([40.107.1.71]:30952
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727994AbgKTMPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:15:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krM0ebatdEHY1Tttt58BW/1DBNbxD8Kft+ALX+NOCNzjZV5BZW0tqqJGxHiNdjGuY8Kb1er37yskksEhHTZnsWgKMPyh2s21elTyy7wfHU9DEcxb+3bfZ0EMrCFcRCJ5zvXnp3MLDZBGBOXCk65Zh0jnjl7M6fM5LAUplHgMz02i4J90LVnQhZVTvzHkPnvgVPYlUh2TJk9fptqoT7dO1kNDBzoRkeCb7bZELnbFzTC7wIKncF10mFp5ab1E8lp1C6ok0lOgwLC93E9vdH98qpF1egE0K1wqtlQ8zqBTlQKsln3Gbin8RN/owTimkDhe5834uasDbWwASmN5eUIJYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+IYRNo9LOiPEsTUoppyvfOnWLCK+jup2loS/UruNzo=;
 b=X17WIoTaU5bN4jJiVJ2m5ZMEBnUSQpfbpNQIgt5FDIm9ZgGIoWj6aLfoD+kXcNshUkmpQUDme+9fxUlJe5ACrpHSIHg5ArQJafCavdzgqdq3S4h/vw0GfyRTFTGjiSbM2jalG2SguvrLObZGrbkSi4y66QwQKdheT6948KUQm2GG8HbSNvCaygsv7Xc9mbhytN2+QQa/qmyaxPWIxXheCRRsQfOaxheQWe+72mscMrWFGBTGg8iysv3ZhG87BHIYfNMf9h0PUvwbDBh4zFDTIrk08YuXXnEv8B0yrgO8R2Isak3tX0rezVqHNHBLuHGkdy41nQDRKP+ExSmhTRs7pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+IYRNo9LOiPEsTUoppyvfOnWLCK+jup2loS/UruNzo=;
 b=RJMmizZjjNcMqH1DzN2VloN4bQ2wIfl47Uw17vk8n7e7AQ4KjxvuCai+8qZouiaJsrIOPuujVXdgU7OZi7Bkc/tc4IAKA9F4us7C1y8A/yCuOMv8rnmtTSARH6lTIjY49NzP1EdGhuJYyiWXFgl24+ITtzMxrCcUBN+EzSj7rf0=
Received: from AM7PR04CA0011.eurprd04.prod.outlook.com (2603:10a6:20b:110::21)
 by DB7PR10MB2395.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Fri, 20 Nov
 2020 12:14:59 +0000
Received: from AM5EUR02FT003.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:110:cafe::6e) by AM7PR04CA0011.outlook.office365.com
 (2603:10a6:20b:110::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Fri, 20 Nov 2020 12:14:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT003.mail.protection.outlook.com (10.152.8.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 12:14:59 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Fri, 20 Nov 2020 13:14:58 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 176353FBE0; Fri, 20 Nov 2020 12:14:58 +0000 (GMT)
Message-ID: <9903ab966b77d8947405e5d4defd162d407cebcf.1605868780.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <adam.ward@diasemi.com>
Date:   Fri, 20 Nov 2020 12:14:58 +0000
Subject: [PATCH 8/9] regulator: da9121: add mode support
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 961b22c2-c9ee-4f14-eace-08d88d4de6cd
X-MS-TrafficTypeDiagnostic: DB7PR10MB2395:
X-Microsoft-Antispam-PRVS: <DB7PR10MB23958CF89666B0431DAC7279CBFF0@DB7PR10MB2395.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/xASwhSmrIF5jSlkQyRPUy30JzKVZu2k8tXRJck6L4NkMHjrXXcukWEDRbmMBqI9RIaSfLOnqG1BYmsaNUec8RfHA/iVuXuLVTu2djKb90d4j4ShOSWaY7CwsxuMlWAB8DXwZocSwRnwD6YXKBLBxqzFafvsfZii0qFgaUToALnB6ihVqH1QyYe+u6+e9SXCNxvLTSnGgr7Z+pVzDtTcMtr7RS6MHyJsGiwVkwPjtHXazeVy+HhDZIf9rZG0EfX5gmEtFPUU0rTBaatvwbHGF0updp29ZqNzAoQV1hPN/Vsv3AyjpU53w6Ziux5eCxXkpMRDAFTK9rLF13RYt9APOHcootv5QESXX6tqVJZ3mEz5oS+0Kp7waw42nilM840QYd7msXHpVWJ/ygILI4d6M4mpJ+c5STYmFU/hImHoNY=
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(46966005)(83380400001)(336012)(478600001)(42186006)(33310700002)(110136005)(54906003)(2906002)(4326008)(356005)(6266002)(8676002)(26005)(82310400003)(70206006)(186003)(426003)(8936002)(47076004)(44832011)(82740400003)(5660300002)(36906005)(316002)(36756003)(2616005)(81166007)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 12:14:59.4649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 961b22c2-c9ee-4f14-eace-08d88d4de6cd
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT003.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2395
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds get/set for mode, and mapping from REGULATOR_MODE_* to select
PFM/PWM/Auto operation.

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 74 ++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index 5d11c22..3addbd2 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -230,6 +230,72 @@ static int da9121_set_current_limit(struct regulator_dev *rdev,
 	return ret;
 }
 
+static unsigned int da9121_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case DA9121_BUCK_MODE_FORCE_PWM:
+		return REGULATOR_MODE_FAST;
+	case DA9121_BUCK_MODE_FORCE_PWM_SHEDDING:
+		return REGULATOR_MODE_NORMAL;
+	case DA9121_BUCK_MODE_AUTO:
+		return REGULATOR_MODE_IDLE;
+	case DA9121_BUCK_MODE_FORCE_PFM:
+		return REGULATOR_MODE_STANDBY;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int da9121_buck_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	struct da9121 *chip = rdev_get_drvdata(rdev);
+	unsigned int val;
+	unsigned int reg;
+	unsigned int msk;
+
+	switch (mode) {
+	case REGULATOR_MODE_FAST:
+		val = DA9121_BUCK_MODE_FORCE_PWM;
+		break;
+	case REGULATOR_MODE_NORMAL:
+		val = DA9121_BUCK_MODE_FORCE_PWM_SHEDDING;
+		break;
+	case REGULATOR_MODE_IDLE:
+		val = DA9121_BUCK_MODE_AUTO;
+		break;
+	case REGULATOR_MODE_STANDBY:
+		val = DA9121_BUCK_MODE_FORCE_PFM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!da9121_rdev_to_buck_reg_mask(rdev, true, &reg, &msk))
+		return -EINVAL;
+
+	return regmap_update_bits(chip->regmap, reg, msk, val);
+}
+
+static unsigned int da9121_buck_get_mode(struct regulator_dev *rdev)
+{
+	struct da9121 *chip = rdev_get_drvdata(rdev);
+	unsigned int reg;
+	unsigned int msk;
+	unsigned int val;
+	int ret = 0;
+
+	if (!da9121_rdev_to_buck_reg_mask(rdev, true, &reg, &msk))
+		return -EINVAL;
+
+	ret = regmap_read(chip->regmap, reg, &val);
+	if (ret < 0) {
+		dev_err(chip->dev, "Cannot read BUCK register: %d\n", ret);
+		return -EINVAL;
+	}
+
+	return da9121_map_mode(val & msk);
+}
+
 static const struct regulator_ops da9121_buck_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
@@ -239,6 +305,8 @@ static int da9121_set_current_limit(struct regulator_dev *rdev,
 	.list_voltage = regulator_list_voltage_linear,
 	.get_current_limit = da9121_get_current_limit,
 	.set_current_limit = da9121_set_current_limit,
+	.set_mode = da9121_buck_set_mode,
+	.get_mode = da9121_buck_get_mode,
 };
 
 static struct of_regulator_match da9121_matches[] = {
@@ -258,6 +326,7 @@ static int da9121_set_current_limit(struct regulator_dev *rdev,
 	.name = "da9121",
 	.of_match = "buck1",
 	.owner = THIS_MODULE,
+	.of_map_mode = da9121_map_mode,
 	.regulators_node = of_match_ptr("regulators"),
 	.ops = &da9121_buck_ops,
 	.type = REGULATOR_VOLTAGE,
@@ -281,6 +350,7 @@ static int da9121_set_current_limit(struct regulator_dev *rdev,
 		.name = "DA9220/DA9132 BUCK1",
 		.of_match = "buck1",
 		.owner = THIS_MODULE,
+		.of_map_mode = da9121_map_mode,
 		.regulators_node = of_match_ptr("regulators"),
 		.ops = &da9121_buck_ops,
 		.type = REGULATOR_VOLTAGE,
@@ -298,6 +368,7 @@ static int da9121_set_current_limit(struct regulator_dev *rdev,
 		.name = "DA9220/DA9132 BUCK2",
 		.of_match = "buck2",
 		.owner = THIS_MODULE,
+		.of_map_mode = da9121_map_mode,
 		.regulators_node = of_match_ptr("regulators"),
 		.ops = &da9121_buck_ops,
 		.type = REGULATOR_VOLTAGE,
@@ -318,6 +389,7 @@ static int da9121_set_current_limit(struct regulator_dev *rdev,
 		.name = "DA9122/DA9131 BUCK1",
 		.of_match = "buck1",
 		.owner = THIS_MODULE,
+		.of_map_mode = da9121_map_mode,
 		.regulators_node = of_match_ptr("regulators"),
 		.ops = &da9121_buck_ops,
 		.type = REGULATOR_VOLTAGE,
@@ -335,6 +407,7 @@ static int da9121_set_current_limit(struct regulator_dev *rdev,
 		.name = "DA9122/DA9131 BUCK2",
 		.of_match = "buck2",
 		.owner = THIS_MODULE,
+		.of_map_mode = da9121_map_mode,
 		.regulators_node = of_match_ptr("regulators"),
 		.ops = &da9121_buck_ops,
 		.type = REGULATOR_VOLTAGE,
@@ -354,6 +427,7 @@ static int da9121_set_current_limit(struct regulator_dev *rdev,
 	.name = "DA9217 BUCK1",
 	.of_match = "buck1",
 	.owner = THIS_MODULE,
+	.of_map_mode = da9121_map_mode,
 	.regulators_node = of_match_ptr("regulators"),
 	.ops = &da9121_buck_ops,
 	.type = REGULATOR_VOLTAGE,
-- 
1.9.1

