Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314722B1E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgKMPVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:21:41 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:1222 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgKMPVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605280900; x=1636816900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=gHTGJxT/Hd2GGsGVFZ5ukn7Hbstro+OxdfGBisfdTfE=;
  b=Fhx0679BTt/qrT5RjsHCGaboDg3ngslkjR3eXM7ELcBjICFW2CDhLpd2
   CjSQI5Re+V/y5+YATB0wpe3+5oJ/wPCcFXywVMCiINipZq3qqhY6dSjrw
   4HB4z4ts2dk5K52g49wvQcDOTlulsdSVFj4D3/CM8MZsdufTNQ9+uergy
   IL3Al/Zr/2HLa7LXYCH/sE95NKQ+HstnsNMB0RXDyVScRHn9+yJAceykF
   +7kqgw1g7e8LFf/r1Xz7S8AtvbrNDYdRLXCmkaQpixB7rhVEN68zTNiLl
   6Xx8nXCMyjWy3rz7WR4GD+WaTSrUqRtTXIez6AEY4jU+z9j5r0EcCe7NO
   w==;
IronPort-SDR: EYR8ww1Ov49NKPhNdDAJL9wVCiATrWf7A0W5ylrD1lzSGq+CrZDlQ8q54awtK9gU27/ZV49tV2
 +GyCl4wSA4tEdamuMWDYTzLs25qRNM6TBf9FE/3CmYShYL5rvSIURfMVd9LaxQWWdtBKC0mArf
 GWROxY/H4ADBkjTfDKbR/6yTIAbBUHowGerqX+2DbEKAUmN9Y8jxgmekcGdYjmTXCTRVuvbmm7
 0iYGlujn2pqStRcagaxzrKqiowPvgCXDEh1IuVpetAt8z4DCPysMBJ8zb/YX2OOngUI1cMyT3B
 KhQ=
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="scan'208";a="96238169"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Nov 2020 08:21:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 13 Nov 2020 08:21:39 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 13 Nov 2020 08:21:35 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <s.hauer@pengutronix.de>, <ttynkkynen@nvidia.com>,
        <linus.walleij@linaro.org>, <axel.lin@ingics.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 5/6] regulator: mcp16502: add support for ramp delay
Date:   Fri, 13 Nov 2020 17:21:09 +0200
Message-ID: <1605280870-32432-6-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605280870-32432-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605280870-32432-1-git-send-email-claudiu.beznea@microchip.com>
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
index 48eb64bc4018..f81afeeddb19 100644
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
+	uV_delta = abs(new_sel * rdev->desc->linear_ranges->step -
+		       old_sel * rdev->desc->linear_ranges->step);
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

