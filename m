Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF702DBF31
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 12:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgLPLGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 06:06:41 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:35088 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgLPLGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 06:06:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id AC877FB03;
        Wed, 16 Dec 2020 12:05:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lVGFOItGAl-R; Wed, 16 Dec 2020 12:05:57 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 64DC543BC5; Wed, 16 Dec 2020 12:05:54 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] regulators: bd718x7: Add enable times
Date:   Wed, 16 Dec 2020 12:05:54 +0100
Message-Id: <d2b3d053d28ea0f35e7526b523287358c8fe20c2.1608116704.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608116704.git.agx@sigxcpu.org>
References: <cover.1608116704.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the typical startup times from the data sheet so boards get a
reasonable default. Not setting any enable time can lead to board hangs
when e.g. clocks are enabled too soon afterwards.

This fixes gpu power domain resume on the Librem 5.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/regulator/bd718x7-regulator.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index e6d5d98c3cea..d6d34aa4ee2e 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -613,6 +613,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.vsel_mask = DVS_BUCK_RUN_MASK,
 			.enable_reg = BD718XX_REG_BUCK1_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = 144,
 			.owner = THIS_MODULE,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
@@ -646,6 +647,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.vsel_mask = DVS_BUCK_RUN_MASK,
 			.enable_reg = BD718XX_REG_BUCK2_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = 162,
 			.owner = THIS_MODULE,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
@@ -680,6 +682,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.linear_range_selectors = bd71847_buck3_volt_range_sel,
 			.enable_reg = BD718XX_REG_1ST_NODVS_BUCK_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = 162,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -706,6 +709,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.vsel_range_mask = BD71847_BUCK4_RANGE_MASK,
 			.linear_range_selectors = bd71847_buck4_volt_range_sel,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = 240,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -727,6 +731,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.vsel_mask = BD718XX_3RD_NODVS_BUCK_MASK,
 			.enable_reg = BD718XX_REG_3RD_NODVS_BUCK_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = 220,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -750,6 +755,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.vsel_mask = BD718XX_4TH_NODVS_BUCK_MASK,
 			.enable_reg = BD718XX_REG_4TH_NODVS_BUCK_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = 200,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -775,6 +781,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.linear_range_selectors = bd718xx_ldo1_volt_range_sel,
 			.enable_reg = BD718XX_REG_LDO1_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = 440,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -796,6 +803,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.n_voltages = ARRAY_SIZE(ldo_2_volts),
 			.enable_reg = BD718XX_REG_LDO2_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = 370,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -818,6 +826,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.vsel_mask = BD718XX_LDO3_MASK,
 			.enable_reg = BD718XX_REG_LDO3_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = 310,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -840,6 +849,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.vsel_mask = BD718XX_LDO4_MASK,
 			.enable_reg = BD718XX_REG_LDO4_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = 400,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -865,6 +875,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.linear_range_selectors = bd71847_ldo5_volt_range_sel,
 			.enable_reg = BD718XX_REG_LDO5_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = 530,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -889,6 +900,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.vsel_mask = BD718XX_LDO6_MASK,
 			.enable_reg = BD718XX_REG_LDO6_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = 400,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -942,6 +954,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = DVS_BUCK_RUN_MASK,
 			.enable_reg = BD718XX_REG_BUCK1_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = 160,
 			.owner = THIS_MODULE,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
@@ -975,6 +988,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = DVS_BUCK_RUN_MASK,
 			.enable_reg = BD718XX_REG_BUCK2_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = 180,
 			.owner = THIS_MODULE,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
@@ -1005,6 +1019,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = DVS_BUCK_RUN_MASK,
 			.enable_reg = BD71837_REG_BUCK3_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = 180,
 			.owner = THIS_MODULE,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
@@ -1033,6 +1048,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = DVS_BUCK_RUN_MASK,
 			.enable_reg = BD71837_REG_BUCK4_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = 180,
 			.owner = THIS_MODULE,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
@@ -1065,6 +1081,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.linear_range_selectors = bd71837_buck5_volt_range_sel,
 			.enable_reg = BD718XX_REG_1ST_NODVS_BUCK_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = 160,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -1088,6 +1105,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = BD71837_BUCK6_MASK,
 			.enable_reg = BD718XX_REG_2ND_NODVS_BUCK_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = 240,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -1109,6 +1127,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = BD718XX_3RD_NODVS_BUCK_MASK,
 			.enable_reg = BD718XX_REG_3RD_NODVS_BUCK_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = 220,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -1132,6 +1151,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = BD718XX_4TH_NODVS_BUCK_MASK,
 			.enable_reg = BD718XX_REG_4TH_NODVS_BUCK_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = 200,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -1157,6 +1177,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.linear_range_selectors = bd718xx_ldo1_volt_range_sel,
 			.enable_reg = BD718XX_REG_LDO1_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = 440,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -1178,6 +1199,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.n_voltages = ARRAY_SIZE(ldo_2_volts),
 			.enable_reg = BD718XX_REG_LDO2_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = 370,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -1200,6 +1222,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = BD718XX_LDO3_MASK,
 			.enable_reg = BD718XX_REG_LDO3_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = 310,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -1222,6 +1245,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = BD718XX_LDO4_MASK,
 			.enable_reg = BD718XX_REG_LDO4_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = 400,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -1246,6 +1270,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = BD71837_LDO5_MASK,
 			.enable_reg = BD718XX_REG_LDO5_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = 310,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -1272,6 +1297,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = BD718XX_LDO6_MASK,
 			.enable_reg = BD718XX_REG_LDO6_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = 400,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -1296,6 +1322,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = BD71837_LDO7_MASK,
 			.enable_reg = BD71837_REG_LDO7_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = 530,
 			.owner = THIS_MODULE,
 		},
 		.init = {
-- 
2.29.2

