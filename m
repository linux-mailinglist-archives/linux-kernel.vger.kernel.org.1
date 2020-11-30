Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266F72C888B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgK3PoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:44:05 -0500
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:32231
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727678AbgK3Pnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:43:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdbWBYVUKzcJDEqsNdcBmpoVz2DAlfue/+9bH6YH1ChcgSq82vp1DbjjCylhvpBuEPPZpxHJ4S/MUdMFDwQajDBSalA2I1ycNNK7X3RKWRGjLMG20WKD3X+0jjFzpmorj5C/ahdBgF4K421RXAWnVE1hMFQyPuRBgr8xCjlH8y3N9a9zXGBRR6kRU5waxDgATac00hHU166C1gCFFmAjBvnILf4kJJfYgvwfXNeQTYJvvpzBj7e0LEKMzdEKE2r5te5tI+wF+HIVJ3CfPSjXUrEQU6RcOguXYetGIHSDMF4k/uoEAByj+YfVsIBc6P2d3wkVnYK/dJ7tG12EE53mew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVeMCdX6kCHd/6d2Ne/3TQtQlplNv/85xKXJs2P9Srk=;
 b=TXnqaOcIn3ClMQIuRjL8bV+AVdex7aF6xNH3u/kdj8yrFtJcqNxA3xBzYtmv8othX/nlhswWl2DoZ0nu6ojzZfyC+mZA29mD+11I8qXUr1Tb7AoOg5Yf2faih4xelodayXOcUG7V4JfADU8hjGrCUyeu5brZ79DXUKch2/GjnHUyonSjF0uuYCDjMMzBR1dbk5i69MK71UlkjvpUutW21a9hpK8p9FNdDY410gWqIHldthcWErnhQ37tvx9h/GeBeyo8wAc4NkFdzvI8hHbVwbPdnvDFbc7sG3w9m1bI3waDTcVGUAxo7f1glVGDjv9wCchoOEegbspjpTQZboEd4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVeMCdX6kCHd/6d2Ne/3TQtQlplNv/85xKXJs2P9Srk=;
 b=PrZ9mBwCfg8qE0pOCfixWe7tFkvz4AMPcjxJKta8GqUItCQZfyCLGlVcYbuaSZ1zSZBlgU6GA03pL1G/ppxTXDbJrtn37pyJvc9Sn/K4PnWt6GooxaEpV9T+Alu3QnbHaLEzIhwzXFvnuFRwNg4UxBaUcNqI7iVo9z3CQStSrwQ=
Received: from MR2P264CA0185.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::24) by
 AM6PR10MB2087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:39::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.25; Mon, 30 Nov 2020 15:43:01 +0000
Received: from VE1EUR02FT045.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:501:0:cafe::93) by MR2P264CA0185.outlook.office365.com
 (2603:10a6:501::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 15:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT045.mail.protection.outlook.com (10.152.12.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3589.20 via Frontend Transport; Mon, 30 Nov 2020 15:43:00 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 30 Nov 2020 16:42:51 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 B87743FC0D; Mon, 30 Nov 2020 15:42:51 +0000 (GMT)
Message-ID: <693db6a9a31843798658aba779d9ff34f27461be.1606750000.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606750000.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606750000.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 30 Nov 2020 15:42:51 +0000
Subject: [PATCH V2 7/9] regulator: da9121: add current support
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c56a360f-cde7-4efa-e51d-08d895469e54
X-MS-TrafficTypeDiagnostic: AM6PR10MB2087:
X-Microsoft-Antispam-PRVS: <AM6PR10MB208784BC470D69544213399DCBF50@AM6PR10MB2087.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w35oKkAdnDW8UX/wxd6rV7Od3HCsVZAS6YKaGDXW0smQ6KtFmGGT2OeaXIk7yWb1KSkipbFEYj8Oae2+6O0HIlvISMYR1Dlrm07ZRzBt4eSvU/yPCcr3Ri/qQ8FbbAqE3VSZfncFRoo+3JELmuu+hkEpfVSRZ13ZBKeaGoULwjlSoImwOuzR+l9WqqS4jaF436sNlsf5Udy54g2aPWongYofYlD0Kibh+UMCsCuXhWFsrBBn4z2632d5jAQVL/a3YRocB0OPg9ULQgey7i4OKY33OlVCTIvRzANoBk/cwYq4346bFwRniiOeLJn8My/C0UXXb1x+QYg6Yn7tbPp0fHHXKoHWXpfqFA8b5bEqQsoV2nbnOCb77TcD8IwnvYdQ8GQJnNXI5B9TzSDa7kXSEg==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966005)(42186006)(86362001)(336012)(426003)(478600001)(316002)(8936002)(26005)(2616005)(110136005)(54906003)(4326008)(186003)(8676002)(19627235002)(6266002)(107886003)(82310400003)(2906002)(82740400003)(47076004)(70206006)(5660300002)(36756003)(81166007)(356005)(70586007)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 15:43:00.6919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c56a360f-cde7-4efa-e51d-08d895469e54
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT045.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2087
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for getting/setting current for all supported
variants. Limits are adjusted per variant to match HW implementation.

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 113 +++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index 6c82441..a69acb2 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -91,6 +91,117 @@ struct da9121_variant_info {
 	{ 1, 2, &da9121_6A_2phase_current  },	//DA9121_TYPE_DA9217
 };
 
+struct da9121_field {
+	unsigned int reg;
+	unsigned int msk;
+};
+
+static const struct da9121_field da9121_current_field[2] = {
+	{ DA9121_REG_BUCK_BUCK1_2, DA9121_MASK_BUCK_BUCKx_2_CHx_ILIM },
+	{ DA9xxx_REG_BUCK_BUCK2_2, DA9121_MASK_BUCK_BUCKx_2_CHx_ILIM },
+};
+
+static int da9121_get_current_limit(struct regulator_dev *rdev)
+{
+	struct da9121 *chip = rdev_get_drvdata(rdev);
+	int id = rdev_get_id(rdev);
+	struct da9121_range *range =
+		variant_parameters[chip->variant_id].current_range;
+	unsigned int val = 0;
+	int ret = 0;
+
+	ret = regmap_read(chip->regmap, da9121_current_field[id].reg, &val);
+	if (ret < 0) {
+		dev_err(chip->dev, "Cannot read BUCK register: %d\n", ret);
+		goto error;
+	}
+
+	if (val < range->reg_min) {
+		ret = -EACCES;
+		goto error;
+	}
+
+	if (val > range->reg_max) {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	return range->val_min + (range->val_stp * (val - range->reg_min));
+error:
+	return ret;
+}
+
+static int da9121_ceiling_selector(struct regulator_dev *rdev,
+		int min, int max,
+		unsigned int *selector)
+{
+	struct da9121 *chip = rdev_get_drvdata(rdev);
+	struct da9121_range *range =
+		variant_parameters[chip->variant_id].current_range;
+	unsigned int level;
+	unsigned int i = 0;
+	unsigned int sel = 0;
+	int ret = 0;
+
+	if (range->val_min > max || range->val_max < min) {
+		dev_err(chip->dev,
+			"Requested current out of regulator capability\n");
+		ret = -EINVAL;
+		goto error;
+	}
+
+	level = range->val_max;
+	for (i = range->reg_max; i >= range->reg_min; i--) {
+		if (level <= max) {
+			sel = i;
+			break;
+		}
+		level -= range->val_stp;
+	}
+
+	if (level < min) {
+		dev_err(chip->dev,
+			"Best match falls below minimum requested current\n");
+		ret = -EINVAL;
+		goto error;
+	}
+
+	*selector = sel;
+error:
+	return ret;
+}
+
+static int da9121_set_current_limit(struct regulator_dev *rdev,
+				int min_ua, int max_ua)
+{
+	struct da9121 *chip = rdev_get_drvdata(rdev);
+	int id = rdev_get_id(rdev);
+	struct da9121_range *range =
+		variant_parameters[chip->variant_id].current_range;
+	unsigned int sel = 0;
+	int ret = 0;
+
+	if (min_ua < range->val_min ||
+	    max_ua > range->val_max) {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	ret = da9121_ceiling_selector(rdev, min_ua, max_ua, &sel);
+	if (ret < 0)
+		goto error;
+
+	ret = regmap_update_bits(chip->regmap,
+				da9121_current_field[id].reg,
+				da9121_current_field[id].msk,
+				(unsigned int)sel);
+	if (ret < 0)
+		dev_err(chip->dev, "Cannot update BUCK current limit, err: %d\n", ret);
+
+error:
+	return ret;
+}
+
 static const struct regulator_ops da9121_buck_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
@@ -98,6 +209,8 @@ struct da9121_variant_info {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.list_voltage = regulator_list_voltage_linear,
+	.get_current_limit = da9121_get_current_limit,
+	.set_current_limit = da9121_set_current_limit,
 };
 
 static struct of_regulator_match da9121_matches[] = {
-- 
1.9.1

