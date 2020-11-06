Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C962A92B3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgKFJ3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:29:17 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:35823 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgKFJ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604654954; x=1636190954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=gVkb/HduIodWBWgTTPTKx7ktzM9BdW4BzHHiUogCOBA=;
  b=EMsYpC5W6prvu32KayMOM+I0Cip4suigBeLbESbwkhhqmb92Waz8iXth
   3rucJ1Z2jCcbVaCGBMo7Bxmh5pJ3XTz8Dcm38kINcHvx1TT68jStIoGdr
   e5L7HTC8f5xOyiAT9oOa0hTc6XwJ2acMOvipmdpfCibTq5YGyfafSwddx
   X1t3CbQpvZPFSuiBYmt/NByPRxN+US5tG//dDsvRKBUulMzIGPyOglU7m
   bDdjdLjjW2AotFdE6fUuMzBDknAWkSa1q+/fXnUYgsk6zfVk6eZr5f9sX
   tu2yb/vGwMj9vGSgcDWHV9EnLZrU09wb4WRI9haC9mCEeVxbNKELu086R
   w==;
IronPort-SDR: brLV06t69z/RE5qkkjWcLaugPFrSLPf8vJKxAkexZDRP3U/bxqRbNv1ga8FZRPWgSQNsD14qrP
 B5Bym63fGrYRfNlbtDneQ2oOQq2rLNCy7g5ZSd8inOWibWlSr1LqyXprl1yaTjHVUgP+f7z5Ez
 E/CkyeGBe5mLZTQws0x03maNY/LHj6tTutkg1YeqrzNTRo+/+6FCvca8rshGZjDybrrpEQfbjk
 sHGJr4Dnn6PyilOQhJ/V7YigCcGynvW1II8OWEq0HWgMUVE3mpFI1K2oqEWg8Tlc24BNfVVsNg
 szg=
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="32677829"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2020 02:29:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 02:29:11 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 6 Nov 2020 02:29:06 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <eugen.hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 11/11] clk: at91: sama7g5: register cpu clock
Date:   Fri, 6 Nov 2020 11:28:04 +0200
Message-ID: <1604654884-30339-12-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604654884-30339-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604654884-30339-1-git-send-email-claudiu.beznea@microchip.com>
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
index be32d9b88d89..40fceb7595d4 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -885,7 +885,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	sama7g5_pmc = pmc_data_allocate(PMC_ETHPLL + 1,
+	sama7g5_pmc = pmc_data_allocate(PMC_CPU + 1,
 					nck(sama7g5_systemck),
 					nck(sama7g5_periphck),
 					nck(sama7g5_gck), 8);
@@ -962,18 +962,17 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
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

