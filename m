Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0392165D2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 07:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgGGFN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 01:13:26 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53432 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgGGFNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 01:13:23 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AF4CC200844;
        Tue,  7 Jul 2020 07:13:21 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0CDBD20084B;
        Tue,  7 Jul 2020 07:13:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C35DE40305;
        Tue,  7 Jul 2020 13:12:52 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, abel.vesa@nxp.com, peng.fan@nxp.com,
        sfr@canb.auug.org.au, j.remmet@phytec.de,
        georg.waibel@wiedemann-group.de, Georg.Waibel@wiedemann-group.com,
        laurent.pinchart@ideasonboard.com, chen.fang@nxp.com,
        fugang.duan@nxp.com, daniel.baluta@nxp.com, yuehaibing@huawei.com,
        andrew.smirnov@gmail.com, horia.geanta@nxp.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V6 6/6] clk: imx6sl: Fix build warning reported by kernel test robot
Date:   Tue,  7 Jul 2020 13:09:39 +0800
Message-Id: <1594098579-25050-7-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594098579-25050-1-git-send-email-Anson.Huang@nxp.com>
References: <1594098579-25050-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use readl_relaxed() instead of __raw_readl(), and use BIT(x)
instead of (1 << X) to fix below build warning reported by kernel
test robot:

drivers/clk/imx/clk-imx6sl.c:149:49: warning: Shifting signed 32-bit
value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
     while (!(__raw_readl(anatop_base + PLL_ARM) & BM_PLL_ARM_LOCK))

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reported-by: kernel test robot <lkp@intel.com>
---
New patch.
---
 drivers/clk/imx/clk-imx6sl.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index 0f647d1..e69dba1 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -3,6 +3,7 @@
  * Copyright 2013-2014 Freescale Semiconductor, Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/err.h>
@@ -14,19 +15,19 @@
 #include "clk.h"
 
 #define CCSR			0xc
-#define BM_CCSR_PLL1_SW_CLK_SEL	(1 << 2)
+#define BM_CCSR_PLL1_SW_CLK_SEL	BIT(2)
 #define CACRR			0x10
 #define CDHIPR			0x48
-#define BM_CDHIPR_ARM_PODF_BUSY	(1 << 16)
+#define BM_CDHIPR_ARM_PODF_BUSY	BIT(16)
 #define ARM_WAIT_DIV_396M	2
 #define ARM_WAIT_DIV_792M	4
 #define ARM_WAIT_DIV_996M	6
 
 #define PLL_ARM			0x0
-#define BM_PLL_ARM_DIV_SELECT	(0x7f << 0)
-#define BM_PLL_ARM_POWERDOWN	(1 << 12)
-#define BM_PLL_ARM_ENABLE	(1 << 13)
-#define BM_PLL_ARM_LOCK		(1 << 31)
+#define BM_PLL_ARM_DIV_SELECT	0x7f
+#define BM_PLL_ARM_POWERDOWN	BIT(12)
+#define BM_PLL_ARM_ENABLE	BIT(13)
+#define BM_PLL_ARM_LOCK		BIT(31)
 #define PLL_ARM_DIV_792M	66
 
 static const char *step_sels[]		= { "osc", "pll2_pfd2", };
@@ -145,7 +146,7 @@ static void imx6sl_enable_pll_arm(bool enable)
 		val |= BM_PLL_ARM_ENABLE;
 		val &= ~BM_PLL_ARM_POWERDOWN;
 		writel_relaxed(val, anatop_base + PLL_ARM);
-		while (!(__raw_readl(anatop_base + PLL_ARM) & BM_PLL_ARM_LOCK))
+		while (!(readl_relaxed(anatop_base + PLL_ARM) & BM_PLL_ARM_LOCK))
 			;
 	} else {
 		 writel_relaxed(saved_pll_arm, anatop_base + PLL_ARM);
-- 
2.7.4

