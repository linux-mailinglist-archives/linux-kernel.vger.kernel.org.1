Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11BC2CA470
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391393AbgLANx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:53:28 -0500
Received: from mail-eopbgr130051.outbound.protection.outlook.com ([40.107.13.51]:17126
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388187AbgLANx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:53:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRhOtJ18lTCZtwe2yr4M/OxcpcvcTp3CDmFxaup76/DYY1Yu5MwjMj8+n0gr9R1o85eAEkB1wJDKbxKfG1BTmDSaal/koqVObEEjhXwLSWhAhVJcBc0rnXffQS7OUlywiD5MzsK4y90oxW2Djw8sAvJ2j00LvAAt0yeW3Z4f9LQ6VITR1xBC75/4Lf4Mqy5xpKBGHvnXR/KpISIiHJjmdyxiwdcBj6d6EVJ+Quwt7Uc5nM+1Mnu7pnR4tkVgRfpaNiD30+GBrUWtCNO56X2aVUmKvsdP0qzi+wZzQ4WX6wOh/ibNmzozmqnT0kNiuMQOVztBMJh9hYydI4dBHu1vTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BE0zjfEb5vI+VUaAlotwIDANzo6sMiBY9ddSxDTdD4=;
 b=iWerLMsOG3824LK/lO81nnV/bCpWaJxxkNYKKKUajPF0GPlymCeCCA2WP488cWlHq5jg1+t8KgOXsXNcaeLmWtobP/KLHJMs2bokxgpHU4fzt7/Meauorun321W3ty0najIrLaVs8XeatdGcydUuMPIyR+G/0i+gO80xETNh3Zdp7DrJ3sUbQfh13ifJjcjf/QxzhzWYaJGFbhJBTbUpLRfFA16CyFbsnNs/IIgz65+QbmI/NovikUjP6wU8wggiPGpEfSxuKvKQUbJIQQQWdLa6v5kGabyepV6m+I+lYzYnWH88C4DijabNNCHKMI+XbJhpYm+k+j7uv4WCTZr4wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BE0zjfEb5vI+VUaAlotwIDANzo6sMiBY9ddSxDTdD4=;
 b=xBH6y/WK8uRTBghreqM0J2cfIOMojQ00xAk4gYsWiCBLzO3PnDj6gz0/QZC1ipMMkhHTbHGuKBBkxxr7PGzgoHDa9hJ4a3YEveVbIfbvQF9La2LVVep+n5kW6RRc7PLvt5zAtHgnzxYZeLO9dyztfGxRkj1Vnh7puQy6Chpa9kI=
Received: from AM9P195CA0010.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::15)
 by AM9PR10MB4449.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:269::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Tue, 1 Dec
 2020 13:52:37 +0000
Received: from AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:21f:cafe::5) by AM9P195CA0010.outlook.office365.com
 (2603:10a6:20b:21f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23 via Frontend
 Transport; Tue, 1 Dec 2020 13:52:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT064.mail.protection.outlook.com (10.152.9.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3611.23 via Frontend Transport; Tue, 1 Dec 2020 13:52:36 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 1 Dec 2020 14:52:31 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 7E8723FBE4; Tue,  1 Dec 2020 13:52:31 +0000 (GMT)
Message-ID: <8f7a11d59e5ac3ba1bfd448bcfc905efc99b7874.1606830377.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606830377.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606830377.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 1 Dec 2020 13:52:31 +0000
Subject: [PATCH V4 05/10] regulator: da9121: Add device variant descriptors
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1db6f03-4190-4601-43c2-08d896005c73
X-MS-TrafficTypeDiagnostic: AM9PR10MB4449:
X-Microsoft-Antispam-PRVS: <AM9PR10MB44498813EE4DA33439625903CBF40@AM9PR10MB4449.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:142;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X1Xk3a0NURGMer7xGXtfs4b2QAcH0kSPfdVqIfNJuJcyO/aESXj01L+B7IT+uxD6eJu9tKcbhL51qKZ66iLflkXwy2SO/ZUqqPSUDcJBNZzemP7U5sHTolxMQW5EyVP/+c3A6JsZcnwzKlE2LhwZEQqhK0qoeo892deT1Dcj0f4SIYckN4dGWgZxaJuVQ2hLGcwfojGSaCzWajRrmkDUcSlQS0cv+fCS2bLhEeLXfWKDZrBJt2IbwQ126ao2Gwo5W/nlNv9zFd4ivFdF87/5D6EynvJepHimeQY3oVKkNCBjzLLqS9VOkRyjMgu6r1gCslh0ro8+UKBXONeT4NRBKPKqYrpFuYSJVbWWENN7airaecYduM9IwI8Ex+Fmik1L9I6uWWLibi7i3OrHHs1JJg==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966005)(81166007)(336012)(356005)(5660300002)(36756003)(426003)(86362001)(498600001)(42186006)(8936002)(6266002)(110136005)(2906002)(70206006)(70586007)(186003)(26005)(54906003)(107886003)(8676002)(2616005)(47076004)(4326008)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 13:52:36.5860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1db6f03-4190-4601-43c2-08d896005c73
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4449
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

