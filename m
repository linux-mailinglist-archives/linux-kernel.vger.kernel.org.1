Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EDB2C8A43
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgK3RA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:00:26 -0500
Received: from mail-am6eur05on2042.outbound.protection.outlook.com ([40.107.22.42]:63329
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729125AbgK3RAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:00:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNaeMYrmJWWHpdFl5UjvZ9sdO2u+E2xqgQ4uHoaF9G2cUsTEM0CqqE6EiBGGDf6oXqDa1qpiCBV4A2xwvwF+5Z/H/PdevOYBiYFbItQtr9S1Ah0eKw7x5zPKEw3jVGVXop595yx/wFc8ZNlHpjCL8vUSFOm0x3XrQ+38b1wiDos9Lsj12LGKFe9fghoVURd6OMwlSq77gZ64sUFgAJoxcr1pXn60pfKD6UJhCgqe0GJDCKvFGAELub05NXrLW/aQKC1asq6NTnJvLqfTr7/mrKM1SCDaA6aibgJ1G48CYtS2C9iPPCIJHdOiwl+dUBBJgqDduu5zQY14DTHurNHXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVeMCdX6kCHd/6d2Ne/3TQtQlplNv/85xKXJs2P9Srk=;
 b=OEE3IoTMTChnNhDop5F/JuCLKfY50Z4SbKXlq9W0z85aCbSPCojXGf+EEesA1PUuo5oNgjJfQMhglhhYUq/iwy4fD+5OnmfLdXxwuDzUmgHMMZiATYF5wFZd4uYg5cI1sLgoWx76lH9PAPX//RgSJBwGNe1V67eC0LOWpdSoSz9xumKC1wKjfr7jL1HNnd1tPW3xSPRN4gY3ly0ItVmbdj4XAICHlF/6TNGHgtQfjvhYIcGml7Iz2xzpkncnBkQLFI2nvEBgpTXaLSvSIPXK87cXp+v+pJ7dsFl0F6+x2KHu+XYU5B7shOJkikatRHIJmnLbuitAetBWh5iJ3gKjmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVeMCdX6kCHd/6d2Ne/3TQtQlplNv/85xKXJs2P9Srk=;
 b=vuc6WZaTtgFfFf4Qd2mMh9Do3ppvbOEUHR25gPNEL3poImYCNyQEfSXeX4MllTTY5WnyJLAQvsTg8f+sfKyB/zj1vqcMhH4DLTKQrMOF8mPuhOs402nTdq2w5LdvFjds3B2nEAVzgeN9saYRjVWM7eq86U8FEMFNEcBK29ggZT4=
Received: from AM6PR0502CA0044.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::21) by PA4PR10MB4526.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:be::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.21; Mon, 30 Nov
 2020 16:59:31 +0000
Received: from VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::52) by AM6PR0502CA0044.outlook.office365.com
 (2603:10a6:20b:56::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 16:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT054.mail.protection.outlook.com (10.152.13.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3611.23 via Frontend Transport; Mon, 30 Nov 2020 16:59:31 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 30 Nov 2020 17:59:12 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 CA0F03FC0F; Mon, 30 Nov 2020 16:59:12 +0000 (GMT)
Message-ID: <9aa80b909893dbe609730919ed595c6a8ac26606.1606755367.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606755367.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606755367.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 30 Nov 2020 16:59:12 +0000
Subject: [PATCH V3 08/10] regulator: da9121: add current support
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 509edbc7-9c53-40c0-0678-08d895514e91
X-MS-TrafficTypeDiagnostic: PA4PR10MB4526:
X-Microsoft-Antispam-PRVS: <PA4PR10MB452601BAA791E2D85415F89CCBF50@PA4PR10MB4526.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OCDBYatWQpjCVM3VeOnlCG2XELpAOqsRwB6soS4ygHyUNJ3X81pCu3vWq5sficBIjr6v141Zl250UGtSKNOxPvz4StSr7iCoOxJilcLbowjq1xytoCdNY0kJyR8Js1yi42VkU/MKfPGxshLgHQFV/rRqjF8781uKSgQ6RCQXrYxfjnWTO07XlaGvc0eSeyMRjKBoQXe7g4bhmPScmOAixAq2MlXZq35Kr0Zr8UQv+SSeuld/VrEwIvePE/sYZXsdNfAxwQ4//q9nVUOyszRdslnYrpmBBiskj65TCe5i+hwfdxJjpGKDYn9Ipj5GzcHdcpaDuAiXr311UAyku5cUmndnoqy2b88gpvit6h0Q7L3PjmH43x3kyAsTFQv2DbdEXknBtD8fhF8tXbh2bZqR+Q==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966005)(82740400003)(336012)(2906002)(8676002)(356005)(42186006)(70206006)(478600001)(83380400001)(4326008)(86362001)(26005)(2616005)(82310400003)(8936002)(47076004)(81166007)(54906003)(36756003)(70586007)(426003)(110136005)(186003)(316002)(107886003)(19627235002)(6266002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 16:59:31.3243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 509edbc7-9c53-40c0-0678-08d895514e91
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4526
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

