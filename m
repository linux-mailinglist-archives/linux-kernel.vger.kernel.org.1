Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856942B1E7B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgKMPVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:21:37 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:43041 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgKMPVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:21:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605280896; x=1636816896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=n+2kDWPFZI5Ji0zVR0elRY7r1xjxPZHctLTadiVY/zQ=;
  b=Qhn9AYASbEY7qAGgIwhrNZisGBu7uTpgnzGb35znbtJBn9jtWXfcME/9
   nX8cl4nFNCWND+glkgy5KwrkUpK7X73E0SORYx/u7N7DDKu3kCFBJ3QVV
   m6Hql1NSJU02ScajWC8wOtZtQgZj4XPbIaOCD+FbHXeC/N5Xv2Ni4DgMU
   ZxCh2+gg99ByqiHKxzLx1/HuZreVuq60FVWfaj7cswhPiKl7mS9tDt0Jk
   omq5j+do+XVQVec9I5FjO8zJCWm2gVuhmob2z05840VdwJ/mxrpEeCErp
   ccbIKjXRnrbcH3LcSMuZQIXlsaY4uBau6FbxuvH0Zz+uUa3qymQX2KNQ9
   Q==;
IronPort-SDR: uBwrt2a72qwOWA5p6DoPq1jBB/iwK7tXUKUnTsXPIgylWfwyQyzJJb71L1M3tcrpnErOeCp1v7
 kCQtDRSCEw+xuwiftvG5k6ehHauBDPN25ErCoo+ovzqTfRf2f6lKand0pDLTfGDMAzgF01WLKt
 aZLpQ8s5RWVAMyJoPTVzgZxF8Q0uBIXP+bVLNX6zpr8jI9CmFkEJaW63JQpfLsLc3PHtRBzapv
 3d6JJy5ia0h3cODlwdyWmS8AUugcWG8z6IVs474pBZQg9z7BF3ntkGrV6k/PUI9NOiQ9UkqTqg
 YtI=
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="scan'208";a="93552136"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Nov 2020 08:21:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 13 Nov 2020 08:21:35 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 13 Nov 2020 08:21:32 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <s.hauer@pengutronix.de>, <ttynkkynen@nvidia.com>,
        <linus.walleij@linaro.org>, <axel.lin@ingics.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 4/6] regulator: mcp16502: adapt for get/set on other registers
Date:   Fri, 13 Nov 2020 17:21:08 +0200
Message-ID: <1605280870-32432-5-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605280870-32432-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605280870-32432-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCP16502 have multiple registers for each regulator (as described
in enum mcp16502_reg). Adapt the code to be able to get/set all these
registers. This is necessary for the following commits.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/mcp16502.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index ab78f831f5bf..48eb64bc4018 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -54,13 +54,9 @@
  * This function is useful for iterating over all regulators and accessing their
  * registers in a generic way or accessing a regulator device by its id.
  */
-#define MCP16502_BASE(i) (((i) + 1) << 4)
+#define MCP16502_REG_BASE(i, r) ((((i) + 1) << 4) + MCP16502_REG_##r)
 #define MCP16502_STAT_BASE(i) ((i) + 5)
 
-#define MCP16502_OFFSET_MODE_A 0
-#define MCP16502_OFFSET_MODE_LPM 1
-#define MCP16502_OFFSET_MODE_HIB 2
-
 #define MCP16502_OPMODE_ACTIVE REGULATOR_MODE_NORMAL
 #define MCP16502_OPMODE_LPM REGULATOR_MODE_IDLE
 #define MCP16502_OPMODE_HIB REGULATOR_MODE_STANDBY
@@ -75,6 +71,23 @@
 #define MCP16502_MIN_REG 0x0
 #define MCP16502_MAX_REG 0x65
 
+/**
+ * enum mcp16502_reg - MCP16502 regulators's registers
+ * @MCP16502_REG_A: active state register
+ * @MCP16502_REG_LPM: low power mode state register
+ * @MCP16502_REG_HIB: hibernate state register
+ * @MCP16502_REG_SEQ: startup sequence register
+ * @MCP16502_REG_CFG: configuration register
+ */
+enum mcp16502_reg {
+	MCP16502_REG_A,
+	MCP16502_REG_LPM,
+	MCP16502_REG_HIB,
+	MCP16502_REG_HPM,
+	MCP16502_REG_SEQ,
+	MCP16502_REG_CFG,
+};
+
 static unsigned int mcp16502_of_map_mode(unsigned int mode)
 {
 	if (mode == REGULATOR_MODE_NORMAL || mode == REGULATOR_MODE_IDLE)
@@ -144,22 +157,20 @@ static void mcp16502_gpio_set_mode(struct mcp16502 *mcp, int mode)
 }
 
 /*
- * mcp16502_get_reg() - get the PMIC's configuration register for opmode
+ * mcp16502_get_reg() - get the PMIC's state configuration register for opmode
  *
  * @rdev: the regulator whose register we are searching
  * @opmode: the PMIC's operating mode ACTIVE, Low-power, Hibernate
  */
-static int mcp16502_get_reg(struct regulator_dev *rdev, int opmode)
+static int mcp16502_get_state_reg(struct regulator_dev *rdev, int opmode)
 {
-	int reg = MCP16502_BASE(rdev_get_id(rdev));
-
 	switch (opmode) {
 	case MCP16502_OPMODE_ACTIVE:
-		return reg + MCP16502_OFFSET_MODE_A;
+		return MCP16502_REG_BASE(rdev_get_id(rdev), A);
 	case MCP16502_OPMODE_LPM:
-		return reg + MCP16502_OFFSET_MODE_LPM;
+		return MCP16502_REG_BASE(rdev_get_id(rdev), LPM);
 	case MCP16502_OPMODE_HIB:
-		return reg + MCP16502_OFFSET_MODE_HIB;
+		return MCP16502_REG_BASE(rdev_get_id(rdev), HIB);
 	default:
 		return -EINVAL;
 	}
@@ -179,7 +190,7 @@ static unsigned int mcp16502_get_mode(struct regulator_dev *rdev)
 	unsigned int val;
 	int ret, reg;
 
-	reg = mcp16502_get_reg(rdev, MCP16502_OPMODE_ACTIVE);
+	reg = mcp16502_get_state_reg(rdev, MCP16502_OPMODE_ACTIVE);
 	if (reg < 0)
 		return reg;
 
@@ -210,7 +221,7 @@ static int _mcp16502_set_mode(struct regulator_dev *rdev, unsigned int mode,
 	int val;
 	int reg;
 
-	reg = mcp16502_get_reg(rdev, op_mode);
+	reg = mcp16502_get_state_reg(rdev, op_mode);
 	if (reg < 0)
 		return reg;
 
@@ -269,10 +280,10 @@ static int mcp16502_suspend_get_target_reg(struct regulator_dev *rdev)
 {
 	switch (pm_suspend_target_state) {
 	case PM_SUSPEND_STANDBY:
-		return mcp16502_get_reg(rdev, MCP16502_OPMODE_LPM);
+		return mcp16502_get_state_reg(rdev, MCP16502_OPMODE_LPM);
 	case PM_SUSPEND_ON:
 	case PM_SUSPEND_MEM:
-		return mcp16502_get_reg(rdev, MCP16502_OPMODE_HIB);
+		return mcp16502_get_state_reg(rdev, MCP16502_OPMODE_HIB);
 	default:
 		dev_err(&rdev->dev, "invalid suspend target: %d\n",
 			pm_suspend_target_state);
-- 
2.7.4

