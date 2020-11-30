Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE6A2C8A40
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgK3RAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:00:23 -0500
Received: from mail-eopbgr50066.outbound.protection.outlook.com ([40.107.5.66]:35392
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729141AbgK3RAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:00:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/l/kWqns8mbICw1ypGF8CxJwCfAHlBJOmPwuZm4tyIg18+g4rtmOLePeEoCVO/YgbfSU6KHri8ttj5hngPH4vz6ij4zOWGvNWusKU7O5mCH5v7B8BOKQSt/eiSiKW6H1cPnzTzDomKsOeb5mLsqckwd3NVNZB2P+iKWb3cS/7+w6sqWdSiSw8vV+yaT76qWuuc0JpZaeC1X00en6AWL+1AeD5xTi5MTiB8PB4ujKhe9W+IxNeieCqbYNCH1SQrPJj3B8am6t4kwakIfUjIdEYbRyTw5iCd2AXH+Ugbfe1Y0WeADrtcKOn7zMbYJRAdUKbrbFCjbPmAk5rcbIG3Y7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BE0zjfEb5vI+VUaAlotwIDANzo6sMiBY9ddSxDTdD4=;
 b=W+qGw34dxFB3lw2tKjZjAUUAhfyUvMFwIALRkxppB4iqFGuCPBVRnLA1BNjnMrd1tRcbCSipQBqK3Pg4KsT6YwCLkkg5hIbzvDdPaPddOJQ1KsIZPne/CXz83S5O0l1fS+1Qgp/DNjF0UKJUnaPk5IikdiE47DFH3imvuz+8/nU5jUdwh9F59U1DGThQEFbZwyFtu00keICzCa/eMBEVTbH1jKajJ1qxH/I2RQ5XEW8Wb7p//eQej+MP/JT2xAl8UvmMnOFLMwZSi1Qn1//x5mYgKU/ptE8tGEjrv+epsEGc26o6GGzCPClfgZms21WrCow4B3X33JcYvu86XR1i6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BE0zjfEb5vI+VUaAlotwIDANzo6sMiBY9ddSxDTdD4=;
 b=PcNr4pvnnRMcO6UMtmXKKBQ1JC/bev1E9xXSa/wUegO/JmMtci+pUKOlpXsy2VrUz7VgLpMAwuzlAVunIjEpH7PeGl/IQgo2sju8VbikD7WvHsdbVqhgnvONrt+WyL6w9EP1APALBiy/utWcmQg2d2SEM8pPOE4Gs3tQUl87jDg=
Received: from AM6PR0502CA0040.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::17) by VI1PR10MB2192.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:81::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Mon, 30 Nov
 2020 16:59:24 +0000
Received: from VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::69) by AM6PR0502CA0040.outlook.office365.com
 (2603:10a6:20b:56::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 16:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT054.mail.protection.outlook.com (10.152.13.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3611.23 via Frontend Transport; Mon, 30 Nov 2020 16:59:23 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 30 Nov 2020 17:59:09 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 BEDE83FC0D; Mon, 30 Nov 2020 16:59:09 +0000 (GMT)
Message-ID: <8f7a11d59e5ac3ba1bfd448bcfc905efc99b7874.1606755367.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606755367.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606755367.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 30 Nov 2020 16:59:09 +0000
Subject: [PATCH V3 05/10] regulator: da9121: Add device variant descriptors
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97e85d52-5505-4d1a-b60f-08d895514a21
X-MS-TrafficTypeDiagnostic: VI1PR10MB2192:
X-Microsoft-Antispam-PRVS: <VI1PR10MB2192127B48F2E717BA96BCD2CBF50@VI1PR10MB2192.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:142;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L4Ojrk2Ve1G9mfbAjPduQ3ZVEP3dtmS0qhIF32YPQ8e1RqJQoLnIHkm80hcyFZXwrAv4w1FD9ktk6jb56zK794ZXWiQEZA94zROhDxpb3VMMQFbnAf/7EtEhsN5qcHe8EHzfGZ2bnMdatT+xnsmF80sqxyTSquIqu0TVrehBZQOpyhEeh872kzGEwmrdLD3Ez8z8qBEzry+l9+UHSZZd6CGpfD6Ou+wksY1CU9OmjvmZj7TjNxwtGDucWVOEPxbPfzaRb5Tj9c+ECKcRoLwk7LKV6rj80hB7Dy2dFsUT7YMEqm05V4aXpcat36SwylacV57Mo86BCLW2+jTspvT8Tl0d0ZJO/evoB7Bt/DaPi1nSdNiyV39toiFkH/oVgn8cdck1dFFUvHZ/TbmrUoPJXw==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966005)(356005)(2616005)(36756003)(186003)(26005)(81166007)(42186006)(54906003)(316002)(82310400003)(110136005)(82740400003)(47076004)(70206006)(86362001)(5660300002)(426003)(336012)(8936002)(2906002)(70586007)(107886003)(8676002)(6266002)(4326008)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 16:59:23.8759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e85d52-5505-4d1a-b60f-08d895514a21
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2192
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Descriptors for bucks in all variants, ready for of_regulator_match

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 110 +++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index 137b1df..a717e2b 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -41,6 +41,11 @@ struct da9121 {
 	.list_voltage = regulator_list_voltage_linear,
 };
 
+static struct of_regulator_match da9121_matches[] = {
+	[DA9121_IDX_BUCK1] = { .name = "buck1" },
+	[DA9121_IDX_BUCK2] = { .name = "buck2" },
+};
+
 #define DA9121_MIN_MV		300
 #define DA9121_MAX_MV		1900
 #define DA9121_STEP_MV		10
@@ -49,9 +54,11 @@ struct da9121 {
 				 + 1 + DA9121_MIN_SEL)
 
 static const struct regulator_desc da9121_reg = {
+	.id = DA9121_IDX_BUCK1,
 	.name = "da9121",
 	.of_match = "buck1",
 	.owner = THIS_MODULE,
+	.regulators_node = of_match_ptr("regulators"),
 	.ops = &da9121_buck_ops,
 	.type = REGULATOR_VOLTAGE,
 	.n_voltages = DA9121_N_VOLTAGES,
@@ -68,6 +75,105 @@ struct da9121 {
 	.enable_time = 20,
 };
 
+static const struct regulator_desc da9220_reg[2] = {
+	{
+		.id = DA9121_IDX_BUCK1,
+		.name = "DA9220/DA9132 BUCK1",
+		.of_match = "buck1",
+		.owner = THIS_MODULE,
+		.regulators_node = of_match_ptr("regulators"),
+		.ops = &da9121_buck_ops,
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = DA9121_N_VOLTAGES,
+		.min_uV = DA9121_MIN_MV * 1000,
+		.uV_step = DA9121_STEP_MV * 1000,
+		.linear_min_sel = DA9121_MIN_SEL,
+		.enable_reg = DA9121_REG_BUCK_BUCK1_0,
+		.enable_mask = DA9121_MASK_BUCK_BUCKx_0_CHx_EN,
+		.vsel_reg = DA9121_REG_BUCK_BUCK1_5,
+		.vsel_mask = DA9121_MASK_BUCK_BUCKx_5_CHx_A_VOUT,
+	},
+	{
+		.id = DA9121_IDX_BUCK2,
+		.name = "DA9220/DA9132 BUCK2",
+		.of_match = "buck2",
+		.owner = THIS_MODULE,
+		.regulators_node = of_match_ptr("regulators"),
+		.ops = &da9121_buck_ops,
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = DA9121_N_VOLTAGES,
+		.min_uV = DA9121_MIN_MV * 1000,
+		.uV_step = DA9121_STEP_MV * 1000,
+		.linear_min_sel = DA9121_MIN_SEL,
+		.enable_reg = DA9xxx_REG_BUCK_BUCK2_0,
+		.enable_mask = DA9121_MASK_BUCK_BUCKx_0_CHx_EN,
+		.vsel_reg = DA9xxx_REG_BUCK_BUCK2_5,
+		.vsel_mask = DA9121_MASK_BUCK_BUCKx_5_CHx_A_VOUT,
+	}
+};
+
+static const struct regulator_desc da9122_reg[2] = {
+	{
+		.id = DA9121_IDX_BUCK1,
+		.name = "DA9122/DA9131 BUCK1",
+		.of_match = "buck1",
+		.owner = THIS_MODULE,
+		.regulators_node = of_match_ptr("regulators"),
+		.ops = &da9121_buck_ops,
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = DA9121_N_VOLTAGES,
+		.min_uV = DA9121_MIN_MV * 1000,
+		.uV_step = DA9121_STEP_MV * 1000,
+		.linear_min_sel = DA9121_MIN_SEL,
+		.enable_reg = DA9121_REG_BUCK_BUCK1_0,
+		.enable_mask = DA9121_MASK_BUCK_BUCKx_0_CHx_EN,
+		.vsel_reg = DA9121_REG_BUCK_BUCK1_5,
+		.vsel_mask = DA9121_MASK_BUCK_BUCKx_5_CHx_A_VOUT,
+	},
+	{
+		.id = DA9121_IDX_BUCK2,
+		.name = "DA9122/DA9131 BUCK2",
+		.of_match = "buck2",
+		.owner = THIS_MODULE,
+		.regulators_node = of_match_ptr("regulators"),
+		.ops = &da9121_buck_ops,
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = DA9121_N_VOLTAGES,
+		.min_uV = DA9121_MIN_MV * 1000,
+		.uV_step = DA9121_STEP_MV * 1000,
+		.linear_min_sel = DA9121_MIN_SEL,
+		.enable_reg = DA9xxx_REG_BUCK_BUCK2_0,
+		.enable_mask = DA9121_MASK_BUCK_BUCKx_0_CHx_EN,
+		.vsel_reg = DA9xxx_REG_BUCK_BUCK2_5,
+		.vsel_mask = DA9121_MASK_BUCK_BUCKx_5_CHx_A_VOUT,
+	}
+};
+
+static const struct regulator_desc da9217_reg = {
+	.id = DA9121_IDX_BUCK1,
+	.name = "DA9217 BUCK1",
+	.of_match = "buck1",
+	.owner = THIS_MODULE,
+	.regulators_node = of_match_ptr("regulators"),
+	.ops = &da9121_buck_ops,
+	.type = REGULATOR_VOLTAGE,
+	.n_voltages = DA9121_N_VOLTAGES,
+	.min_uV = DA9121_MIN_MV * 1000,
+	.uV_step = DA9121_STEP_MV * 1000,
+	.linear_min_sel = DA9121_MIN_SEL,
+	.enable_reg = DA9121_REG_BUCK_BUCK1_0,
+	.enable_mask = DA9121_MASK_BUCK_BUCKx_0_CHx_EN,
+	.vsel_reg = DA9121_REG_BUCK_BUCK1_5,
+	.vsel_mask = DA9121_MASK_BUCK_BUCKx_5_CHx_A_VOUT,
+};
+
+static const struct regulator_desc *local_da9121_regulators[][DA9121_IDX_MAX] = {
+	[DA9121_TYPE_DA9121_DA9130] = { &da9121_reg, NULL },
+	[DA9121_TYPE_DA9220_DA9132] = { &da9220_reg[0], &da9220_reg[1] },
+	[DA9121_TYPE_DA9122_DA9131] = { &da9122_reg[0], &da9122_reg[1] },
+	[DA9121_TYPE_DA9217] = { &da9217_reg, NULL },
+};
+
 /* DA9121 chip register model */
 static const struct regmap_range da9121_1ch_readable_ranges[] = {
 	regmap_reg_range(DA9121_REG_SYS_STATUS_0, DA9121_REG_SYS_MASK_3),
@@ -255,6 +361,10 @@ static int da9121_assign_chip_model(struct i2c_client *i2c,
 		break;
 	}
 
+	/* Set these up for of_regulator_match call which may want .of_map_modes */
+	da9121_matches[0].desc = local_da9121_regulators[chip->variant_id][0];
+	da9121_matches[1].desc = local_da9121_regulators[chip->variant_id][1];
+
 	chip->regmap = devm_regmap_init_i2c(i2c, regmap);
 	if (IS_ERR(chip->regmap)) {
 		ret = PTR_ERR(chip->regmap);
-- 
1.9.1

