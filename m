Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614F62B9699
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgKSPoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:44:19 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:9660 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgKSPoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605800657; x=1637336657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=h/XRQsr7glEa2g/r6SVO2kTjj0kdJnjJ6hTe5rBjWKs=;
  b=Snrb573r5ELwgrQ/i6jVX8Z2bkJ3S6rCf9vEIr5cmpcY/dM1ZPe3v9gw
   drXgyBI6OOK+pCHbacMj+/KuYFyO1upPVIcWHbSmR0N2bYKrijDKRU/JZ
   1fIY5GtA/3eR2c+OikrRl8kGjV0mKAo1xPFrCXch4qU8NAjOIy7AKeHFC
   ETPQnr1+JXLXsUXyg3gjoMT6WVkJF4C0eH5LckXx9J5855tYX2qvz2QNd
   I/YFQsLpz9D7Zav908eC35oAnIaZOMjEljMIrVtFQbQbhMGlXBzsy5K3m
   Py/A6iIMiyogxX+8dH4DbQvvdc5AkCcLXE1lKQbTnr+iyeeMSNY5/t4jL
   w==;
IronPort-SDR: 10EusQblgNvR/4HD8Tf3Yc/p38Upish+mP/sG5/LeDQOQ9h6MVSWv/Yr2x1vU7hg6qsSQ82WHm
 YV6gPui2AGeDGBR1Wq7qwg9UQY5+/tjrnBjzUfG5mAHcElKGU9EpZsXQ+bxgemh5sr60TA1Jd/
 iEss/F7wUeVfYlIijz9mjsyxtaeACFHmfLG0rMzd1N01jP+XzbWZzDGNqKkWbLKpiRT+fGqzIE
 bmKK0b/vN5X/WqfNH7JEVuptSmu7VGyjqO3LUtyK4xmIqHdz5wLY/cVAeDWHNauVh3HWZ0Ja9y
 YAc=
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="94245187"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2020 08:44:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 19 Nov 2020 08:44:16 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 19 Nov 2020 08:44:13 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v6 11/11] clk: at91: sama7g5: register cpu clock
Date:   Thu, 19 Nov 2020 17:43:17 +0200
Message-ID: <1605800597-16720-12-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register CPU clock as being the master clock prescaler. This would
be used by DVFS. The block schema of SAMA7G5's PMC contains also a divider
between master clock prescaler and CPU (PMC_CPU_RATIO.RATIO) but the
frequencies supported by SAMA7G5 could be directly received from
CPUPLL + master clock prescaler and the extra divider would do no work in
case it would be enabled.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sama7g5.c       | 13 ++++++-------
 include/dt-bindings/clock/at91.h |  1 +
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 927eb3b2b126..a6e20b35960e 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -904,7 +904,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	sama7g5_pmc = pmc_data_allocate(PMC_ETHPLL + 1,
+	sama7g5_pmc = pmc_data_allocate(PMC_CPU + 1,
 					nck(sama7g5_systemck),
 					nck(sama7g5_periphck),
 					nck(sama7g5_gck), 8);
@@ -981,18 +981,17 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 		}
 	}
 
-	parent_names[0] = md_slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "cpupll_divpmcck";
-	parent_names[3] = "syspll_divpmcck";
-	hw = at91_clk_register_master_pres(regmap, "mck0_pres", 4, parent_names,
+	parent_names[0] = "cpupll_divpmcck";
+	hw = at91_clk_register_master_pres(regmap, "cpuck", 1, parent_names,
 					   &mck0_layout, &mck0_characteristics,
 					   &pmc_mck0_lock,
 					   CLK_SET_RATE_PARENT, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_master_div(regmap, "mck0_div", "mck0_pres",
+	sama7g5_pmc->chws[PMC_CPU] = hw;
+
+	hw = at91_clk_register_master_div(regmap, "mck0", "cpuck",
 					  &mck0_layout, &mck0_characteristics,
 					  &pmc_mck0_lock, 0);
 	if (IS_ERR(hw))
diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
index fab313f62e8f..98e1b2ab6403 100644
--- a/include/dt-bindings/clock/at91.h
+++ b/include/dt-bindings/clock/at91.h
@@ -34,6 +34,7 @@
 #define PMC_AUDIOPMCPLL		(PMC_MAIN + 6)
 #define PMC_AUDIOIOPLL		(PMC_MAIN + 7)
 #define PMC_ETHPLL		(PMC_MAIN + 8)
+#define PMC_CPU			(PMC_MAIN + 9)
 
 #ifndef AT91_PMC_MOSCS
 #define AT91_PMC_MOSCS		0		/* MOSCS Flag */
-- 
2.7.4

