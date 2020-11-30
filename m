Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0F62C8A44
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgK3RA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:00:27 -0500
Received: from mail-am6eur05on2044.outbound.protection.outlook.com ([40.107.22.44]:58248
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729163AbgK3RAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:00:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4dOdL8koYqmPf7lSTlvGSwOGMa+HyU0iRA/6IFDi5UqIjHlIgJASw+K/G+fsMmLkHkkglA0RiEzvJk/lJTJ3qx5AN5SPTppNz2PvsUC2VBsSC47cGsUqi3X6mVbeeQKPNbvGBZrrcIJH38YlB166h4+T7o+JRfX2PjCsmJYDEvpOy7PW4911GMWDBSQYEVyZwmlviqhuP6o0ATWcbC3Y+MaFPJwEGlpwZsJ47StYUVPs76L9mEaztsGjR5Xsn8nXAJzwCdQnWHgH2J833dqYI+rOmO8JleL0JvIcHQjo2X7ayGVMve3TjWzAFJd92ZcOnSEKUeozvm4ZbnXNxw1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKbeNViUbWVeeQXfOE5fVX3g7WLhTJ1b4DO1Y337/Lc=;
 b=A4iV5w03Y33tuhTdUmP+rIiTbgBfDWstJb1uhL6lb0gTlM2y26QiseyMUCCpFqNc5ulPKLNrzw0CwmR2t2Kt4fpwMttuUxX8JDVeAekqR6RZmdLzdWMxmsewSYsR/Y889QzDZAkLcMJxKzsVhVpPMI3zqH4GSBYX2AmgpDNi+mItt+4RBUXkJKD1rKQpZ7BdHyZuKqlyE75qhMPFpDeQs5+cGzUeb30A/QZHh/ZB1W8cQnJraJOMUTnqI/BoXr9/baGyrbhfhkOyVk6g+pw7igWeNsm4dBqYeL+INyI/NstH8Oy5KoBIR+D4JcRv2e0vK5PgjT07SXbwqGyRRWUK3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKbeNViUbWVeeQXfOE5fVX3g7WLhTJ1b4DO1Y337/Lc=;
 b=VhXjhgkCMYybZYog0hHl4yGBn+ZU0qz6rGLEQNt3QsSudY9l08BSgEG/IHyIcu5Hetm9GnPtRxXoUFt5Jy4k4j9MzQwZQTcnMz+3Jy8JXr/aZVlQHzli0tAuaALC+bzfPiovzbxpN19YMkru5dH8HLrjD4xeQVJZjuOEYFDnxpE=
Received: from AM6PR0502CA0071.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::48) by AM7PR10MB3592.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:13d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Mon, 30 Nov
 2020 16:59:35 +0000
Received: from VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::4e) by AM6PR0502CA0071.outlook.office365.com
 (2603:10a6:20b:56::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 16:59:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT054.mail.protection.outlook.com (10.152.13.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3611.23 via Frontend Transport; Mon, 30 Nov 2020 16:59:34 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 30 Nov 2020 17:59:16 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 CDB933FC12; Mon, 30 Nov 2020 16:59:13 +0000 (GMT)
Message-ID: <7844c8f6facb6f7c0649381629cc75ccad14723d.1606755367.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606755367.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606755367.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 30 Nov 2020 16:59:13 +0000
Subject: [PATCH V3 09/10] regulator: da9121: add mode support
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9544a0e5-f612-4266-4d6b-08d895515093
X-MS-TrafficTypeDiagnostic: AM7PR10MB3592:
X-Microsoft-Antispam-PRVS: <AM7PR10MB3592093B2BA9F6B5893768B9CBF50@AM7PR10MB3592.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IqLsUp3jNfsCIJMlKDv7gHMtO9NKgyD+DLK5y3Et9YQlp8PmrPcqClmpfximQ5rXZWMQM4OCQQ1e75VXyp6S1YATGM5dzEXlIhtFFbD9dkC4/o0ev9spoX1jY/4y5gEvCbfVrVf+9ll3hLcG6zEvz51gYUXbnY9Ax4bf/lPXq9IBU4LALuD7BIE6kRI4nWvNM+a1g775VrLeCOsRxBkXpSWgCMhZV6IRqhWY7C8kHQbdSzV/9L5aILw47l2tJ8G3/91S+UK9IR6B8AvCFplV+F7lOQwI9PeCRsn71soW6oZ05crRWx5DLl3n3NT4U71GMJuqMpyPE5yAVyDdVKymKuuY7tttE9d5bxLPJ3P8nBal2mpo5BQMuMv/yWRFeFI4osy3f7B1Tc9Gq3iWJXQNvw==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966005)(8676002)(83380400001)(8936002)(81166007)(4326008)(356005)(70586007)(47076004)(70206006)(478600001)(82310400003)(336012)(186003)(316002)(26005)(82740400003)(2616005)(36756003)(107886003)(2906002)(110136005)(6266002)(19627235002)(42186006)(426003)(86362001)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 16:59:34.6907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9544a0e5-f612-4266-4d6b-08d895515093
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3592
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

