Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98E12C8875
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgK3Pnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:43:45 -0500
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:9387
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727906AbgK3Pno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:43:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBey38ohBixz2cfUTv0RZLUDRPyov7y8lkKnVngMmUMQUVxyzz+TRzkGak63hozITzt4in/BxyAdZ/ZlifwIxyc22FIkNGr7Cu9cjOIW33hMpnNGN0Vl2mqXWQy3VDIcK06L1clASyyaMhWpBE+1QYRVOY7t625oXem+wj7jk15rxTZgBhsk7HABqTdimoFFcc1B69/4kDeJwnErBDt/4oQWA7Gf+VUvUzzXtz/zYmIn994M0fLU/tx9yrrVj5UYVT7DQFQtJfbDG47+N0XaMQPYqZmlPw4w27SWypDLHAKyuei6h0f2viCfhdq4rVMnd4pVsxCDsyEJ8mYbdDqN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BE0zjfEb5vI+VUaAlotwIDANzo6sMiBY9ddSxDTdD4=;
 b=Fx9VjTAjMtq1GoZoqt1Ry8VgAGzLqDA/f4gjX+g6fXBHgoB+JSPbLlU/yl+5BXAhcNouk2BB+czqmGFPjqLqONlGDYYK2stQphydMdGiuClDUM/SCkMdfLA1p0QcRAlGy49z6fMyhYNheVcTqEBuaJxcPi6Hcy2rTre/iH+S2DR8LrZDBRepl3hACgpxfZ1oBUFZmOL6Hb8MAmS+QRCiENAx+9GFG3Nx5fxL7cYZfwT+vew8dRVkY01HSkjpo5WYu+C6dlVCCTLZdzI9k+ma3JgQVfgT0KrW9eDjeWrdYl9eI+F4cYs8dIDnIXCbaFiSNeapWgBrzAqsJtr16WNT1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BE0zjfEb5vI+VUaAlotwIDANzo6sMiBY9ddSxDTdD4=;
 b=gxEJ6cXgqHafeYPxDxsi/C12Ks3gUIb8QRCNj0tBjBVNMHeMjwM883gOEZlPyKCs7zSe8STWM7N7PevMoudisJq1n2iqmc0mFgF+e2sX1XQTVjnIibn6v3+wXDtOzRKXfVnu/rMugib7Y4afzEdVc53DMMq0xZY7jBr4vvUrTfI=
Received: from MR2P264CA0180.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::19) by
 AM8PR10MB4305.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.21; Mon, 30 Nov
 2020 15:42:55 +0000
Received: from VE1EUR02FT045.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:501:0:cafe::47) by MR2P264CA0180.outlook.office365.com
 (2603:10a6:501::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 15:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT045.mail.protection.outlook.com (10.152.12.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3589.20 via Frontend Transport; Mon, 30 Nov 2020 15:42:54 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 30 Nov 2020 16:42:48 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 AD3B73FBD8; Mon, 30 Nov 2020 15:42:48 +0000 (GMT)
Message-ID: <4fc2888e202fef1cbbad1f4631be0e31a342a79a.1606750000.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606750000.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606750000.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 30 Nov 2020 15:42:48 +0000
Subject: [PATCH V2 4/9] regulator: da9121: Add device variant descriptors
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bc656c3-4d8a-4d7a-185e-08d895469aab
X-MS-TrafficTypeDiagnostic: AM8PR10MB4305:
X-Microsoft-Antispam-PRVS: <AM8PR10MB4305C4D9E798970873FA9FDCCBF50@AM8PR10MB4305.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:142;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NFly4hkcsGP1zd4zvjUlAl1wc1VlR+ed53dBdHccdGFBtSpf64rxxg6SWN4NOA0xLCt8Vl+NHHa0KTk4vVbh1fDIDOyFsB+dwYna2vWje7D/n2eYmoJACdatHwJzQXEI3GVQAoX5Cjif1uXuGS6r0bd5GRYB2gZBZxH6l/LyZjfoS1ets70Xdpcona81bWIS6KjoPiNnfiO/m8sS+amLdANyCVayhufslTl7/QPA7FChjs1sVe7AE15d/6fy2sDdaG+h8pD1ryPYbrdIxMbVtPbpFBJYuTpyQCEe9sULdC1HU9gU4WU5iRg6sHW/BlWFeZpUDtY55BhbWvEggCw8JhiJgLfI+tefIRxyMT+yfIpimOy0M/7XHpr+y36WcGA4E60ivYmxQckTRm74T93sng==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966005)(86362001)(82310400003)(4326008)(110136005)(42186006)(356005)(316002)(54906003)(70586007)(70206006)(6266002)(47076004)(478600001)(5660300002)(36756003)(8676002)(82740400003)(2616005)(81166007)(107886003)(8936002)(336012)(2906002)(426003)(186003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 15:42:54.5390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc656c3-4d8a-4d7a-185e-08d895469aab
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT045.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4305
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

