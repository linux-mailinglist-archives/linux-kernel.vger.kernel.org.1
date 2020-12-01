Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781C52CA476
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391422AbgLANxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:53:36 -0500
Received: from mail-db8eur05on2058.outbound.protection.outlook.com ([40.107.20.58]:12258
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391405AbgLANxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:53:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbQk8Zgi5YS45Lvks6BDkG6ojiJuH3A4lm9uKx4nrpLMohgrQIBgasHn/rEP6dBsIrkQNnYvI/5QPXEmxE92F0XXXQPh13IFj5gaeIuwkMrHexyRT8mT/QU83TfDgOib7Tawx/WMX0qFgfwsx35T07EahjDs3GaWqWwVOFx7OxgJ34bJRV8Tl1Yc4H/ZaPb1/51Q5hzqGOtDRvq2k94pMWPPdI+uOnBQVJYO9VU3fB7kgCshO4FuYG7m9qiKdhbAYHUEDwVQOJdEUSsogULl/FHOr6J4D0LJbi/T5EPL3qARl8ET+aNjiL7AAermIiEFXRgJ9xJiyryuM7RDk4gjaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKbeNViUbWVeeQXfOE5fVX3g7WLhTJ1b4DO1Y337/Lc=;
 b=a8xcSsYQwFQMDm4GT26tSzodlf9ktxyoAT9HxpCrHu4eISn1Qn513H7f6jvmhL5NgJUTkZIY9gMjNLQyPznmTRuAkz9gjrvqUBgf3XMuALDBBntU6GBfal80c7ScuZUV2tw32+LuLDt49qj93m4unbaw5Mnxi8TGD1Rh9iTTj8J42pYHHDdnRbQZXziFmiyXx+cw0hb5Wvk9gTYGKkI0ZuCzD8eI68nfMY6DEDbKVDiXL7lZ9N/l9uOH1CEfOqCkvhLxDmU6+Z/1oEgVvfZnBqcQqJ/gJ2ng0tc8Dl/WWOjWPuXFx18BCPwtolM9HxYNssFwV1AB6yv3uenLh8Xxmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKbeNViUbWVeeQXfOE5fVX3g7WLhTJ1b4DO1Y337/Lc=;
 b=1J3Rgl4+JpACS4Z20OeSjSAn/Bprx0i1un08shGTMvAj/9HqWUCXHoaMyWjwbSGaprWj7JMxHDGBC+9JF4ZNPGHpi66cvi02XFADw+84rRI6IJKM3VvWEN9jZ4uNz1ruUZln3MyYgb/Vl1Yybiv3T0GQMc+33x75cO0i63fz2P0=
Received: from AM9P195CA0009.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::14)
 by AM5PR10MB1780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:1d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Tue, 1 Dec
 2020 13:52:45 +0000
Received: from AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:21f:cafe::74) by AM9P195CA0009.outlook.office365.com
 (2603:10a6:20b:21f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Tue, 1 Dec 2020 13:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT064.mail.protection.outlook.com (10.152.9.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3611.23 via Frontend Transport; Tue, 1 Dec 2020 13:52:44 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 1 Dec 2020 14:52:35 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 8E9483FBBB; Tue,  1 Dec 2020 13:52:35 +0000 (GMT)
Message-ID: <7844c8f6facb6f7c0649381629cc75ccad14723d.1606830377.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606830377.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606830377.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 1 Dec 2020 13:52:35 +0000
Subject: [PATCH V4 09/10] regulator: da9121: add mode support
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c74bdc09-e0ad-43e6-3183-08d89600613d
X-MS-TrafficTypeDiagnostic: AM5PR10MB1780:
X-Microsoft-Antispam-PRVS: <AM5PR10MB1780E5625A3E62C02B6750D0CBF40@AM5PR10MB1780.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S4abpC/p0rbAV7enMbOepIamN4qdsLkTFnaE2G0f2Mw2Nk7oX77is6mGOiIW6L4TwE/QfEurrsTRw+WTQihifY0eLHfbum9HqjQnGkH0fuI/np/qfr6sQIeO8Q7OSZ+zz3/hgfspJXp7FG94dDaYEoNg3fSboWNYrepRZa1QIIZoTaNKb6tEBSS4o8kWND51AI6HBoDqRbvPcx6XvbYrO6VQQi8Cdadd4mLMlrM5W54mrB3uktmf/tINbAP1A+7c5P+HxhdZwg4TyrSHdUbEuCDGTDMg2ViRZvMDuBvSoOAxYhpBXU/Brrck4EHBCgC/V/Z11MT83ujV9zB8iKgpULiUWULsPM9uBOQ1X1bP1XkNu8Fcr2pVCKo92HT6uTalVSw5jV0vKpruGyfFHqXiMA==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966005)(19627235002)(86362001)(5660300002)(2906002)(2616005)(70206006)(70586007)(8676002)(498600001)(356005)(54906003)(6266002)(336012)(110136005)(186003)(426003)(42186006)(8936002)(26005)(107886003)(36756003)(82310400003)(81166007)(4326008)(47076004)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 13:52:44.6023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c74bdc09-e0ad-43e6-3183-08d89600613d
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR10MB1780
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

