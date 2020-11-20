Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAD32BA9ED
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 13:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgKTMPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 07:15:07 -0500
Received: from mail-eopbgr60053.outbound.protection.outlook.com ([40.107.6.53]:2108
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727137AbgKTMPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:15:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQvUNAyd1a1XmUPji98Sp7NgFBklrO699jZ3FCUXAqG9hLHnsDzuFthV+oHtPpIEg+Fd+nbw5LkP2XKvWLkQ+c2c7XZf1GkwBvb1esdReflfWINUOH81NTKTu+oblGXEpXgYYquWxEL4QvxU54+noj6SbaQt5aqON1o/kt8266G0uXTQBXmWwYPEK7nhuSY8toKZGVwpbMu/mf47p1rkGJ7gWEZgaCCEBNyxxrmYQCMmPMjIkLjxDdn6+p79vGDrJw48WiwIgpKNb2m7Ti434kP1IBJJCVRIw36YDaV/40IcdXCOomlJXmyJ1C7NOEoyDwguwA9/QCGdQaR7rPqhhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uzi6ZEGdTH+zgr/AXSk/3b+mGJI4QK4/aB99Opz/8/c=;
 b=HmKYfsKeviiRIDerf9AFhdUvkE/yLKaZRaercjcg7PxeNssQFyyd5tKc0nn7bQ5oJrULJQ/0Oc6DTsmcvA+yd/gofg7rLRGlISA6+QA8Q1DgdEqCSWI/pUlwI0IlRB827UQB8ioArnZIjhWrnNXYqFmXEAGjZy0zDm1uy72+XpjYfTfF5ET28yXACD3Tp46/CVNFxYbVwo5uqYs6gXqPhOGaFvkNMCWxA46Mr4KllKfZF0y4uyTrIVF1oRrYp1I6LI0GFdL2ZciC4RPl2niKqICcWiAXPQ9mEOUEhCtM4c7JvwDyy1NqBf5BrsC0dev2RnRegn1HAFIpNGVoMmfyiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uzi6ZEGdTH+zgr/AXSk/3b+mGJI4QK4/aB99Opz/8/c=;
 b=pv6uKKpmgwSJwH9qGI8778zSVNAbHLGRPjQjYAhYOdxxMb/P9HCKphodKBnnUtNi0KqL+V5MksqLBiQN5RPlMxLmPm35xsg9FQf6ebvyFHTdqoUr2ILgBZOQKnVWkWLzImaMevYQ6EMOadefKfDZ3RglCpgxg+yoz/+lA/8NOec=
Received: from AM7PR04CA0028.eurprd04.prod.outlook.com (2603:10a6:20b:110::38)
 by AM6PR10MB2071.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:37::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.25; Fri, 20 Nov
 2020 12:14:58 +0000
Received: from AM5EUR02FT003.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:110:cafe::3c) by AM7PR04CA0028.outlook.office365.com
 (2603:10a6:20b:110::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Fri, 20 Nov 2020 12:14:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT003.mail.protection.outlook.com (10.152.8.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 12:14:57 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Fri, 20 Nov 2020 13:14:57 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 1357A3FBAB; Fri, 20 Nov 2020 12:14:57 +0000 (GMT)
Message-ID: <a9b30f4aa8813bf262fd0eb8e007253582f61602.1605868780.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <adam.ward@diasemi.com>
Date:   Fri, 20 Nov 2020 12:14:57 +0000
Subject: [PATCH 7/9] regulator: da9121: add current support
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80b1f5ce-2ed0-4d14-edb4-08d88d4de5cc
X-MS-TrafficTypeDiagnostic: AM6PR10MB2071:
X-Microsoft-Antispam-PRVS: <AM6PR10MB20716B27AB339CCAD0B2A95ECBFF0@AM6PR10MB2071.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:82;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WxFlmnVxEJw5sI9qOB2ABDCh9M2lbQW8lZky2UeL6vylPbj1AsgUqXJuv4M4AUCBYp+Vb5h0Gj0i5/KZQi+vrZ/XbwJCcTOdrgBJRdn1CHbSmfQ/IgCFhp+7wSlatwjfaYMd/If+ILppqo32a5GXfae7NPlxaxYlH1VKB+6pp1KoTAO7IvL9O9S4ehOUiCgKGC202O8n5xdDg42+82Q07Y3rrV3VL5W23esNjWfcY7JTdflskdst+NO0i4jeJ/0t6p+CWLJ0p71Jm7Fo8xDBXJjrlewDBUAc0VdgaKd/cqwo7d7N4tCKsbCbdx1jvdzo2DNPdsIG6syYYGtiZhoVmKfB2DQtFYaQs4/YdUW7T/ARZXaPlhhlWNhxWg9u2sCRq84GcaJQ+A9UAV5eWzfTwpSNL1ca5XvUEd23qeIIsPC58zaov6/Hofx71s682KIe
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(396003)(39850400004)(376002)(136003)(46966005)(36756003)(44832011)(336012)(4326008)(2906002)(8936002)(316002)(82310400003)(36906005)(186003)(8676002)(83380400001)(26005)(54906003)(42186006)(110136005)(70586007)(70206006)(82740400003)(33310700002)(47076004)(81166007)(356005)(2616005)(426003)(6266002)(478600001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 12:14:57.7877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b1f5ce-2ed0-4d14-edb4-08d88d4de5cc
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT003.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for getting/setting current for all supported
variants. Limits are adjusted per variant to match HW implementation.

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 140 +++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index 13b0aad..5d11c22 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -92,6 +92,144 @@ struct da9121_variant_info {
 	{ 1, 2, &da9121_6A_2phase_current  },	//DA9121_TYPE_DA9217
 };
 
+static bool da9121_rdev_to_buck_reg_mask(struct regulator_dev *rdev, bool mode,
+					 unsigned int *reg, unsigned int *msk)
+{
+	struct da9121 *chip = rdev_get_drvdata(rdev);
+	int id = rdev_get_id(rdev);
+
+	switch (id) {
+	case DA9121_IDX_BUCK1:
+		if (mode) {
+			*reg = DA9121_REG_BUCK_BUCK1_4;
+			*msk = DA9121_MASK_BUCK_BUCKx_4_CHx_A_MODE;
+		} else {
+			*reg = DA9121_REG_BUCK_BUCK1_2;
+			*msk = DA9121_MASK_BUCK_BUCKx_2_CHx_ILIM;
+		}
+		break;
+	case DA9121_IDX_BUCK2:
+		if (mode) {
+			*reg = DA9xxx_REG_BUCK_BUCK2_4;
+			*msk = DA9121_MASK_BUCK_BUCKx_4_CHx_A_MODE;
+		} else {
+			*reg = DA9xxx_REG_BUCK_BUCK2_2;
+			*msk = DA9121_MASK_BUCK_BUCKx_2_CHx_ILIM;
+		}
+		break;
+	default:
+		dev_err(chip->dev, "Invalid regulator ID\n");
+		return false;
+	}
+	return true;
+}
+
+static int da9121_get_current_limit(struct regulator_dev *rdev)
+{
+	struct da9121 *chip = rdev_get_drvdata(rdev);
+	struct da9121_range *range =
+		variant_parameters[chip->variant_id].current_range;
+	unsigned int reg = 0;
+	unsigned int msk = 0;
+	unsigned int val = 0;
+	int ret = 0;
+
+	if (!da9121_rdev_to_buck_reg_mask(rdev, false, &reg, &msk))
+		return -EINVAL;
+
+	ret = regmap_read(chip->regmap, reg, &val);
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
+	struct da9121_range *range =
+		variant_parameters[chip->variant_id].current_range;
+	unsigned int sel = 0;
+	unsigned int reg = 0;
+	unsigned int msk = 0;
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
+	if (!da9121_rdev_to_buck_reg_mask(rdev, false, &reg, &msk))
+		return -EINVAL;
+
+	ret = regmap_update_bits(chip->regmap, reg, msk, (unsigned int)sel);
+	if (ret < 0)
+		dev_err(chip->dev, "Cannot update BUCK register %02x, err: %d\n", reg, ret);
+
+error:
+	return ret;
+}
+
 static const struct regulator_ops da9121_buck_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
@@ -99,6 +237,8 @@ struct da9121_variant_info {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.list_voltage = regulator_list_voltage_linear,
+	.get_current_limit = da9121_get_current_limit,
+	.set_current_limit = da9121_set_current_limit,
 };
 
 static struct of_regulator_match da9121_matches[] = {
-- 
1.9.1

