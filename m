Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD2F2A9373
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgKFJxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:53:41 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:42651 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgKFJxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604656419; x=1636192419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=e6HYx/thzltD2ybOrZTjNdp9yld6Apw1e5MRkSSsbzo=;
  b=C0AFYoYNEd2PBoOc9d4FqA3I5x8tu5j1Mu5cKUzbiP2C8VTkulFRn5q+
   NuqhO9Zv7IvwHe0pjOUISnUy6I3CLVpuw68cj498HGdK89SS7DjZolmSj
   dSlI8HpLkolTxPE2hqW79rbGsZvS1r5OexAp0EvS2GTigEFPvCuVpjGCx
   HInTfIlibvXjnIr4nyy9k8ZpL2R+MmzBtagxNS0WPeP8VGzXH2dEtEnJC
   GRMIGo1KgWXXDejtg4Kwhp3aUvEN6vqjacS5x3hr1LBAsQkX9JN3WHTwa
   Fj7qADmlggWq56+jmXOdvvC4KCrZzzZIbsCWmsKu31kflC5niNzTYQea8
   w==;
IronPort-SDR: bR64RcPp8B+6UjzTWInqhejiPLRbITWX7SVD2CanR15m1TGNZ86W69pgVha4KFF58xy5Tp5+Ix
 cjGr5SiCO4Gd/BZwEQnNm0F3J6AMe/GvFdv+QmuIFhaiHUzZuQaqgubkWrLP0BDttleIIlR4ss
 mML2wa73uAKJx54lWX2bg+lIFLV2htvMW7HVFMgq04NxpORYD78VKQCK2voR6npJReDtVD4M+N
 /XwKawmEqKKsxLcXOf08wYI7YU3p6VC+v8fOpMPPfv6QmJrye6j/pZzd8/dc8830Hi8990gVwL
 WIM=
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="97430041"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2020 02:53:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 02:53:37 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 6 Nov 2020 02:53:33 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <s.hauer@pengutronix.de>, <ttynkkynen@nvidia.com>,
        <linus.walleij@linaro.org>, <axel.lin@ingics.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 5/6] regulator: mcp16502: add support for ramp delay
Date:   Fri, 6 Nov 2020 11:53:03 +0200
Message-ID: <1604656384-827-6-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604656384-827-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604656384-827-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCP16502 have configurable ramp delay support (via DVSR bits in
regulators' CFG register).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/mcp16502.c | 86 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 72c97cbc63af..0cd4f5936e94 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -22,8 +22,9 @@
 #define VDD_LOW_SEL 0x0D
 #define VDD_HIGH_SEL 0x3F
 
-#define MCP16502_FLT BIT(7)
-#define MCP16502_ENS BIT(0)
+#define MCP16502_FLT		BIT(7)
+#define MCP16502_DVSR		GENMASK(3, 2)
+#define MCP16502_ENS		BIT(0)
 
 /*
  * The PMIC has four sets of registers corresponding to four power modes:
@@ -88,6 +89,12 @@ enum mcp16502_reg {
 	MCP16502_REG_CFG,
 };
 
+/* Ramp delay (uV/us) for buck1, ldo1, ldo2. */
+static const int mcp16502_ramp_b1l12[] = { 6250, 3125, 2083, 1563 };
+
+/* Ramp delay (uV/us) for buck2, buck3, buck4. */
+static const int mcp16502_ramp_b234[] = { 3125, 1563, 1042, 781 };
+
 static unsigned int mcp16502_of_map_mode(unsigned int mode)
 {
 	if (mode == REGULATOR_MODE_NORMAL || mode == REGULATOR_MODE_IDLE)
@@ -271,6 +278,77 @@ static int mcp16502_get_status(struct regulator_dev *rdev)
 	return REGULATOR_STATUS_UNDEFINED;
 }
 
+static int mcp16502_set_voltage_time_sel(struct regulator_dev *rdev,
+					 unsigned int old_sel,
+					 unsigned int new_sel)
+{
+	int id = rdev_get_id(rdev);
+	unsigned int uV_delta, val;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, MCP16502_REG_BASE(id, CFG), &val);
+	if (ret)
+		return ret;
+
+	val = (val & MCP16502_DVSR) >> 2;
+	uV_delta = abs(new_sel * rdev->desc->uV_step -
+		       old_sel * rdev->desc->uV_step);
+	switch (id) {
+	case BUCK1:
+	case LDO1:
+	case LDO2:
+		ret = DIV_ROUND_CLOSEST(uV_delta, mcp16502_ramp_b1l12[val]);
+		break;
+
+	case BUCK2:
+	case BUCK3:
+	case BUCK4:
+		ret = DIV_ROUND_CLOSEST(uV_delta, mcp16502_ramp_b234[val]);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int mcp16502_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
+{
+	const int *ramp;
+	int id = rdev_get_id(rdev);
+	unsigned int i, size;
+
+	switch (id) {
+	case BUCK1:
+	case LDO1:
+	case LDO2:
+		ramp = mcp16502_ramp_b1l12;
+		size = ARRAY_SIZE(mcp16502_ramp_b1l12);
+		break;
+
+	case BUCK2:
+	case BUCK3:
+	case BUCK4:
+		ramp = mcp16502_ramp_b234;
+		size = ARRAY_SIZE(mcp16502_ramp_b234);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	for (i = 0; i < size; i++) {
+		if (ramp[i] == ramp_delay)
+			break;
+	}
+	if (i == size)
+		return -EINVAL;
+
+	return regmap_update_bits(rdev->regmap, MCP16502_REG_BASE(id, CFG),
+				  MCP16502_DVSR, (i << 2));
+}
+
 #ifdef CONFIG_SUSPEND
 /*
  * mcp16502_suspend_get_target_reg() - get the reg of the target suspend PMIC
@@ -365,6 +443,8 @@ static const struct regulator_ops mcp16502_buck_ops = {
 	.disable			= regulator_disable_regmap,
 	.is_enabled			= regulator_is_enabled_regmap,
 	.get_status			= mcp16502_get_status,
+	.set_voltage_time_sel		= mcp16502_set_voltage_time_sel,
+	.set_ramp_delay			= mcp16502_set_ramp_delay,
 
 	.set_mode			= mcp16502_set_mode,
 	.get_mode			= mcp16502_get_mode,
@@ -389,6 +469,8 @@ static const struct regulator_ops mcp16502_ldo_ops = {
 	.disable			= regulator_disable_regmap,
 	.is_enabled			= regulator_is_enabled_regmap,
 	.get_status			= mcp16502_get_status,
+	.set_voltage_time_sel		= mcp16502_set_voltage_time_sel,
+	.set_ramp_delay			= mcp16502_set_ramp_delay,
 
 #ifdef CONFIG_SUSPEND
 	.set_suspend_voltage		= mcp16502_set_suspend_voltage,
-- 
2.7.4

