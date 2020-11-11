Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B2C2AECAA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgKKJHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:07:53 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:43668 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgKKJHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605085656; x=1636621656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=W9PR6krF29oMp6eQyd6TqdoQp291Aij+lhywEtVU4gA=;
  b=Wa4kqY0OEfLoy4Rh0GTNU19Ue+jzSFH6r90E5BpCL1Ud8+/NhpsHCCNk
   NgYWWJm6NzCtakdVYF+D4RHuNcBIDdL20ugUS+1c92T29DyY6Jj3Ynnlj
   nc0Hy70IFoYyEWhL0tJoDvstW33HrSTnywbxZwB1bylZtFxgV07C3Jvgf
   2DE+1o5gajMZPztAxj0e8WdXyAq115Z0ssaNDv6vbeIbicVaFilE5aFAu
   +0MlxoT39fEscqypKIMh1LmqGR6+UxlkmubYMH1L2ElyztnWFVufG6yXD
   2SV1D72XGySNzXmv9WGcBNkkfEsVxeOLaL0u3STJdjoN3csYEfySSnLEj
   w==;
IronPort-SDR: YpbTnxcABhZD+77TfCyCcGQ5f/xo9QIGWW6zGf56axsrYmVXHdRoNPdxMIz9nDRNMLlq92G8kz
 wmO/tyhSetCuXP5iY4Je0ySqh0BuXnUvgf+OfeEJyxs9mpUguBlMV1+Qq0SJkWqvucywuVHdIx
 YcLjaZUsx4sLsgY8Q269J8mwgFfYUPFtc45N7FGu36TA9Xa44NuIKsDsz4uyCpe4Kk8cGz2TZK
 cEpfk0TxU8vq+CDX8XXGby3rsEdzmHnHg2NSrnziAnvtG2c8uwz/+8EO9yZIyrisTw1eLSZNZC
 sdk=
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="93264679"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Nov 2020 02:07:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 11 Nov 2020 02:07:35 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 11 Nov 2020 02:07:32 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <s.hauer@pengutronix.de>, <ttynkkynen@nvidia.com>,
        <linus.walleij@linaro.org>, <axel.lin@ingics.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 5/6] regulator: mcp16502: add support for ramp delay
Date:   Wed, 11 Nov 2020 11:06:17 +0200
Message-ID: <1605085578-6783-6-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605085578-6783-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605085578-6783-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCP16502 have configurable ramp delay support (via DVSR bits in
regulators' CFG register).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/mcp16502.c | 89 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 48eb64bc4018..777d1a6cd1c5 100644
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
@@ -271,6 +278,80 @@ static int mcp16502_get_status(struct regulator_dev *rdev)
 	return REGULATOR_STATUS_UNDEFINED;
 }
 
+static int mcp16502_set_voltage_time_sel(struct regulator_dev *rdev,
+					 unsigned int old_sel,
+					 unsigned int new_sel)
+{
+	static const u8 us_ramp[] = { 8, 16, 24, 32 };
+	int id = rdev_get_id(rdev);
+	unsigned int uV_delta, val;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, MCP16502_REG_BASE(id, CFG), &val);
+	if (ret)
+		return ret;
+
+	val = (val & MCP16502_DVSR) >> 2;
+	uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
+		       old_sel * rdev->desc->linear_ranges->uV_step);
+	switch (id) {
+	case BUCK1:
+	case LDO1:
+	case LDO2:
+		ret = DIV_ROUND_CLOSEST(uV_delta * us_ramp[val],
+					mcp16502_ramp_b1l12[val]);
+		break;
+
+	case BUCK2:
+	case BUCK3:
+	case BUCK4:
+		ret = DIV_ROUND_CLOSEST(uV_delta * us_ramp[val],
+					mcp16502_ramp_b234[val]);
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
@@ -365,6 +446,8 @@ static const struct regulator_ops mcp16502_buck_ops = {
 	.disable			= regulator_disable_regmap,
 	.is_enabled			= regulator_is_enabled_regmap,
 	.get_status			= mcp16502_get_status,
+	.set_voltage_time_sel		= mcp16502_set_voltage_time_sel,
+	.set_ramp_delay			= mcp16502_set_ramp_delay,
 
 	.set_mode			= mcp16502_set_mode,
 	.get_mode			= mcp16502_get_mode,
@@ -389,6 +472,8 @@ static const struct regulator_ops mcp16502_ldo_ops = {
 	.disable			= regulator_disable_regmap,
 	.is_enabled			= regulator_is_enabled_regmap,
 	.get_status			= mcp16502_get_status,
+	.set_voltage_time_sel		= mcp16502_set_voltage_time_sel,
+	.set_ramp_delay			= mcp16502_set_ramp_delay,
 
 #ifdef CONFIG_SUSPEND
 	.set_suspend_voltage		= mcp16502_set_suspend_voltage,
-- 
2.7.4

