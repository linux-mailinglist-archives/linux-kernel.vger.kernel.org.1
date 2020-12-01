Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81852CA479
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391431AbgLANxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:53:37 -0500
Received: from mail-eopbgr60076.outbound.protection.outlook.com ([40.107.6.76]:57102
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391395AbgLANxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:53:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxo4Tl/a3smjCmEYFpX5dzJTnFT77w6rx2pmWTfP0skQifNTklkteqa2zyTyP2Y1MRSll+3oNcVOgvpIDoHiUAFoErHIAWryt1RfEsX58Z78/bcrK0/fiocdIh1RNVyEzyjHKcrHWChJTg+lNAy3lgONS6jlOJddopiyyXzYT8tikRdw/rWteRUhBsm2RmiJBtDbElaJin0roDwQHnPZXShtOokZzDpL2fuKsCVJqPaLvg4v9ieov9WDWDSYbkRpsohI01cogNcx5ChjM5LlwvMyR7w/f0xEi3Afe2jLHiMKFlv5kubMEUWePMPDYpyqm3sco8isl77rBBLLE5kk9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVeMCdX6kCHd/6d2Ne/3TQtQlplNv/85xKXJs2P9Srk=;
 b=k2doVqI1s7X+a3EvOhoiAdpXVbvG+K9qa2FocBYPTV7GuoSmBiRjGOijxqzWA7sAnu0rpfexaMh6a6TVu16gev1jzbSW4Ek1Gv4QqQJL4BDdsaRgGrixr6qsD0PZDLBIqFDcjiO7i+aBvynxBnFeMWqeP8qC9ya9cN75JwgkYI8N2qrqoWjrpjN5aGWIk8hBtTvrmvSDQw/jjlILjyYetmYvvJr4YqF09PEAC7aDC0H0/F+kxETuIDO0EpOv+8kg9ii+2AdsplXu6rUWbCRS20+WY+DYQHYm58nhTCi8/KEuPBhzIKfPaL7yNWpFcOq26NyneZ65xAv1Cfd0GiSU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVeMCdX6kCHd/6d2Ne/3TQtQlplNv/85xKXJs2P9Srk=;
 b=sKIVv7VSngvbZ7bFtrtoTVml13QjJG5xBAygwXsq0VEKzH7YEuTKYbgjwNACrmet2ME3FTbd61J3CwJV9GF72K5yLHTj8R7U/R/1LpsT949EZfHNo/yp20J7vxP1Dub1Xu9QD8Dw8QNQDcubI9SVCPnk9XucbO0Y/OVHpPRliZU=
Received: from AM9P195CA0025.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::30)
 by VI1PR10MB3629.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.21; Tue, 1 Dec
 2020 13:52:43 +0000
Received: from AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:21f:cafe::20) by AM9P195CA0025.outlook.office365.com
 (2603:10a6:20b:21f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Tue, 1 Dec 2020 13:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT064.mail.protection.outlook.com (10.152.9.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3611.23 via Frontend Transport; Tue, 1 Dec 2020 13:52:42 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 1 Dec 2020 14:52:34 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 8AA4F3FC0D; Tue,  1 Dec 2020 13:52:34 +0000 (GMT)
Message-ID: <9aa80b909893dbe609730919ed595c6a8ac26606.1606830377.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606830377.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606830377.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 1 Dec 2020 13:52:34 +0000
Subject: [PATCH V4 08/10] regulator: da9121: add current support
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a772670e-42c9-47ee-d085-08d896006033
X-MS-TrafficTypeDiagnostic: VI1PR10MB3629:
X-Microsoft-Antispam-PRVS: <VI1PR10MB3629B87286AB1BC8CF49B290CBF40@VI1PR10MB3629.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z14JvQALDwc9TVWzGoHuWp+MqGzP4Xr7zavcJv3k6GcK0qoswzIYt+2IUnJt02hOJm9JMZHNWeuX9VAY1znanWVZJVJsrLdK+16UU8TmWilRh6an9mnXw+169DC97L6Zn6NPUp999/QU2ZyGQ14XV94gGlquEJlhOsB1YRGXKidUMLfxCgElLQ7o+ChbRVdw1P5lNLH1CctZG4EWkx7SGUBXimOPd1Crmis4f0pnHFpufIdrHnPB9zAKU6pG3FcGmci3Si9BObSyDZrwbrUZXuTZpfkmg1OwRDnQYKngwOzEOyxavF5i7fcXPKPVdWC1Fmd7KLw3uyKOoBRZri2vNbbYJ4MlILIuDhGDS3Yl0Yprn/1jjHIDPyDTyrJ/mFGqhRpKM+wDaDLKcuuxtLREzw==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966005)(336012)(70206006)(2906002)(8676002)(356005)(42186006)(83380400001)(498600001)(4326008)(26005)(86362001)(82310400003)(2616005)(47076004)(54906003)(36756003)(8936002)(81166007)(70586007)(426003)(107886003)(110136005)(186003)(5660300002)(6266002)(19627235002);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 13:52:42.8631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a772670e-42c9-47ee-d085-08d896006033
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3629
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

