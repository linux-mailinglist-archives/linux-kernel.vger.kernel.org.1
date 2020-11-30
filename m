Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B662C8883
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgK3PoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:44:01 -0500
Received: from mail-eopbgr140048.outbound.protection.outlook.com ([40.107.14.48]:36996
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbgK3Pnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:43:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1qnBZKiAX4CQGKUHiXjwbf8PjOJMG+Uv21tOuPoJF75uSk4pXaBNxqSwEt341HopfX00k+osw68gYGGHp32scolVENUI1yx8fq9+MmK/SHsIQjFmoBhQd/5bqRRad6ImvYo6Bz43GNI8b+6Mh+nI8zkegEZeGU3g3JMALnz/e0rzzqS+AEDrHRoQ+LUtaXthWQ7wxBpgKxUoLq7g9uEtpwc4MKrRk9SGRjRLPluqSWWes5YSELrZxbvZD48MQTA53x+Udh4mZI5YVwRXT5I6GO1JwP89iJf1DryaO2Ahq7e6Uzvp3/cj82AmggAGIC0Zt6OlroSfEuwb6n7autlIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKbeNViUbWVeeQXfOE5fVX3g7WLhTJ1b4DO1Y337/Lc=;
 b=cRB+ztL2DFZWHQlYIJIWgxbsUE944iUj3trNLD82lqYuNouI5u9jc9dCdiGc12OYP8r8l08PznQ4ZDZwc2CjZCuqsQc4zpWPYVaY43g1CkYfvlPkrOosmkMApsd9fwmUcnJbPgj837THoHAJCB15FH3T4JoIBMzXmZQcVbEUHGjlljm4JVQcDhVKneosmvCLJ+2eV9WhqDiYOJzJu6WLcXfhASF9C1KU8EKjQPDXwAFNF6PePN6sVoJEHTkvOvpOiZtfwCVfEDlitpOXPCqK8H76A/RkU0WPpDSJhckYdgAOwVfOfNU10nxCQ4TZmLYj1Rw6rYMLS6qIJU2KEWtmbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKbeNViUbWVeeQXfOE5fVX3g7WLhTJ1b4DO1Y337/Lc=;
 b=i4DLxWjKuyTSiMqEatBA3mySHjOxnlSo4OMNwVSBGJ8A0ecFPqGq0NGtgllOlDwEUBRq8i730gcs2LY5z5iiusF762xVKgmQol4CTECmWnmkm8ezJqeGSXj4oZeYFvU/PDcEJUP5Fc191WhGBA8xXPPAfK6YKyIvgvN00E/c9TQ=
Received: from AM4PR07CA0035.eurprd07.prod.outlook.com (2603:10a6:205:1::48)
 by AM6PR10MB2182.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 15:43:03 +0000
Received: from VE1EUR02FT016.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:205:1:cafe::2) by AM4PR07CA0035.outlook.office365.com
 (2603:10a6:205:1::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.9 via Frontend
 Transport; Mon, 30 Nov 2020 15:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT016.mail.protection.outlook.com (10.152.12.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3611.23 via Frontend Transport; Mon, 30 Nov 2020 15:43:02 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 30 Nov 2020 16:42:52 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 BC5033FC0E; Mon, 30 Nov 2020 15:42:52 +0000 (GMT)
Message-ID: <b8332bb9247ee2d33959dce62680d9bf65c81e2a.1606750000.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606750000.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606750000.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 30 Nov 2020 15:42:52 +0000
Subject: [PATCH V2 8/9] regulator: da9121: add mode support
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0af10734-bbce-45cd-342b-08d895469f8e
X-MS-TrafficTypeDiagnostic: AM6PR10MB2182:
X-Microsoft-Antispam-PRVS: <AM6PR10MB2182E498CCFED3F430C84725CBF50@AM6PR10MB2182.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V6M5r3Tz5V28djTHReqHmoh7+nEjYD5HPQ9IMsT0XVkyXKKaZHIHfOySpjxjvg4FpYEpGRzReRu7RaKctA8dDqbJHjD9gVFHRDiJOGmU2sUjJ1itVqq8PLx2hPXHd+BySBF/jKZV4tBk+xtmKp0l87C1EwPz3lQpYy9UQue6g3dzVMSrNVQGMmnPi0qFipjtJtTWs3ibr71tIkJTTRs1Iv9PWk27tE77B7lINkBzgvD6pa3rJFRQf60BjPjm73GNpTMDWxF39iOfgjUDRxg4RGHIgTYgvb5J472cCoFuctSVFxvqgBQ3vi8oYX3PtYFJdeblwuqdpSqR7SEyrhI38liUpCLZUGLXwLfTpvVXAA/jhn72kY9F8lkuegJhr3FK+0GbbV9Gy6ZIxg+XB0L6gA==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966005)(336012)(110136005)(42186006)(478600001)(54906003)(4326008)(2616005)(26005)(316002)(6266002)(8936002)(107886003)(2906002)(186003)(426003)(8676002)(82310400003)(36756003)(70206006)(5660300002)(70586007)(86362001)(83380400001)(81166007)(82740400003)(47076004)(356005)(19627235002);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 15:43:02.7342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af10734-bbce-45cd-342b-08d895469f8e
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT016.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2182
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
index a69acb2..8e50f55 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -101,6 +101,11 @@ struct da9121_field {
 	{ DA9xxx_REG_BUCK_BUCK2_2, DA9121_MASK_BUCK_BUCKx_2_CHx_ILIM },
 };
 
+static const struct da9121_field da9121_mode_field[2] = {
+	{ DA9121_REG_BUCK_BUCK1_4, DA9121_MASK_BUCK_BUCKx_4_CHx_A_MODE },
+	{ DA9xxx_REG_BUCK_BUCK2_4, DA9121_MASK_BUCK_BUCKx_4_CHx_A_MODE },
+};
+
 static int da9121_get_current_limit(struct regulator_dev *rdev)
 {
 	struct da9121 *chip = rdev_get_drvdata(rdev);
@@ -202,6 +207,67 @@ static int da9121_set_current_limit(struct regulator_dev *rdev,
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
+	int id = rdev_get_id(rdev);
+	unsigned int val;
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
+	return regmap_update_bits(chip->regmap,
+				  da9121_mode_field[id].reg,
+				  da9121_mode_field[id].msk,
+				  val);
+}
+
+static unsigned int da9121_buck_get_mode(struct regulator_dev *rdev)
+{
+	struct da9121 *chip = rdev_get_drvdata(rdev);
+	int id = rdev_get_id(rdev);
+	unsigned int val;
+	int ret = 0;
+
+	ret = regmap_read(chip->regmap, da9121_mode_field[id].reg, &val);
+	if (ret < 0) {
+		dev_err(chip->dev, "Cannot read BUCK register: %d\n", ret);
+		return -EINVAL;
+	}
+
+	return da9121_map_mode(val & da9121_mode_field[id].msk);
+}
+
 static const struct regulator_ops da9121_buck_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
@@ -211,6 +277,8 @@ static int da9121_set_current_limit(struct regulator_dev *rdev,
 	.list_voltage = regulator_list_voltage_linear,
 	.get_current_limit = da9121_get_current_limit,
 	.set_current_limit = da9121_set_current_limit,
+	.set_mode = da9121_buck_set_mode,
+	.get_mode = da9121_buck_get_mode,
 };
 
 static struct of_regulator_match da9121_matches[] = {
@@ -285,6 +353,7 @@ static int da9121_of_parse_cb(struct device_node *np,
 	.of_parse_cb = da9121_of_parse_cb,
 	.owner = THIS_MODULE,
 	.regulators_node = of_match_ptr("regulators"),
+	.of_map_mode = da9121_map_mode,
 	.ops = &da9121_buck_ops,
 	.type = REGULATOR_VOLTAGE,
 	.n_voltages = DA9121_N_VOLTAGES,
@@ -309,6 +378,7 @@ static int da9121_of_parse_cb(struct device_node *np,
 		.of_parse_cb = da9121_of_parse_cb,
 		.owner = THIS_MODULE,
 		.regulators_node = of_match_ptr("regulators"),
+		.of_map_mode = da9121_map_mode,
 		.ops = &da9121_buck_ops,
 		.type = REGULATOR_VOLTAGE,
 		.n_voltages = DA9121_N_VOLTAGES,
@@ -327,6 +397,7 @@ static int da9121_of_parse_cb(struct device_node *np,
 		.of_parse_cb = da9121_of_parse_cb,
 		.owner = THIS_MODULE,
 		.regulators_node = of_match_ptr("regulators"),
+		.of_map_mode = da9121_map_mode,
 		.ops = &da9121_buck_ops,
 		.type = REGULATOR_VOLTAGE,
 		.n_voltages = DA9121_N_VOLTAGES,
@@ -348,6 +419,7 @@ static int da9121_of_parse_cb(struct device_node *np,
 		.of_parse_cb = da9121_of_parse_cb,
 		.owner = THIS_MODULE,
 		.regulators_node = of_match_ptr("regulators"),
+		.of_map_mode = da9121_map_mode,
 		.ops = &da9121_buck_ops,
 		.type = REGULATOR_VOLTAGE,
 		.n_voltages = DA9121_N_VOLTAGES,
@@ -366,6 +438,7 @@ static int da9121_of_parse_cb(struct device_node *np,
 		.of_parse_cb = da9121_of_parse_cb,
 		.owner = THIS_MODULE,
 		.regulators_node = of_match_ptr("regulators"),
+		.of_map_mode = da9121_map_mode,
 		.ops = &da9121_buck_ops,
 		.type = REGULATOR_VOLTAGE,
 		.n_voltages = DA9121_N_VOLTAGES,
@@ -386,6 +459,7 @@ static int da9121_of_parse_cb(struct device_node *np,
 	.of_parse_cb = da9121_of_parse_cb,
 	.owner = THIS_MODULE,
 	.regulators_node = of_match_ptr("regulators"),
+	.of_map_mode = da9121_map_mode,
 	.ops = &da9121_buck_ops,
 	.type = REGULATOR_VOLTAGE,
 	.n_voltages = DA9121_N_VOLTAGES,
-- 
1.9.1

