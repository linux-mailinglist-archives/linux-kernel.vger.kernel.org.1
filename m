Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E19B2A9372
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgKFJxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:53:36 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:33241 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgKFJxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604656414; x=1636192414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=G0beAtl5fHAWYYTDc6eZ75wDBO7NLqkARrCWOD7fpRo=;
  b=HpvFiGY702G67vM8dOudHJrkgx1hwXProf1MrBVxBnNsEhxkCS9qUQez
   wIyEy4Hy1lJ9/wsVKrxQT8oUMFPygB0sAkQeOZxXFNyUqS1doZXDwi1lb
   n1+3BoSZLEV8wMa+T0kNBqMTDRk0QSRI+zJVkexg/UdFXMD6dohueTTaP
   kdEidSDzGL3tFWkn+FxBMbMI7CLHe8Q9m4kpfovAnh5aZk8UELjohte6W
   bQbe/8EhEyHikO1AUSZTcpzG3Id6miTwxlb1ExCVUMOwG1myN/j70G7wT
   vy7I4au7D4GunrAkAW/JEShuVIPcOawSbr/tYNh0G7grTFCi4Zn9GrM7F
   g==;
IronPort-SDR: qbKlm91IDgBt1Ujl5B/He9o4fe0qa5hBQSgYV3xsvYiu1EJlSo10e1sk25upKKxHRTDaB95UEZ
 UD8+H7lYKL+RDfOPZfg4YrjtBqlFhxzMTZ3Pdt40mapshoMrrN1taem7gyHKV4i47I+miHLvjH
 a+O6s1mcpy0aMEdHEVSRKD4DEaTrK0eTpOrHU5VLypLjwJU9zzgFGzSB1vsjgljnNCKbnbEH4W
 aENN4dmsREM/0ymxvPP61EKPs+AcovuW4rQyotItvg8Y65r+CKHSH9AaX32JjH941f/KqXWP6T
 Vz0=
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="32681452"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2020 02:53:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 02:53:33 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 6 Nov 2020 02:53:29 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <s.hauer@pengutronix.de>, <ttynkkynen@nvidia.com>,
        <linus.walleij@linaro.org>, <axel.lin@ingics.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 4/6] regulator: mcp16502: adapt for get/set on other registers
Date:   Fri, 6 Nov 2020 11:53:02 +0200
Message-ID: <1604656384-827-5-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604656384-827-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604656384-827-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCP16502 have multiple configuration registers for each regulator (as
described in enum mcp16502_reg). Adapt the code to be able to get/set
all these registers. This is necessary for the following commits.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/mcp16502.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 92a48a195d59..72c97cbc63af 100644
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

