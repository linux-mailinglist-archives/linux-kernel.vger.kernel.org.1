Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB752A933E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgKFJrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:47:43 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:41964 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgKFJrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604656061; x=1636192061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=gVkb/HduIodWBWgTTPTKx7ktzM9BdW4BzHHiUogCOBA=;
  b=Uz+8L77fbyWG1zF37NTN9r88bPQbwtg+dEbzpVsfrw0+/mLOQBJ1tLsW
   qruwgU2f7280TKzIaveGSF6aNnqnwzBfc3WdJBSTka2wnrOjEaJ5UULlA
   x4R7+OaNHxLZItwKD7JOMmKUrsOvKuOKd1R4wYn6dpH7iMhg9F1+IJtA1
   MWlTqygjbJdORJaGNfbOZywZrCFZJSqwIHsTIJarRjMd/vT/dHeIoWqLZ
   ZzAPmAqlmdG2C5vwQ5c/pUTjwmBsBinjZ+zf/uPVxyh0YntD6XOyIsMC1
   abLeR+efeL/8sesnzTMeDmue9rHhqxPy730/Me7UeDIMY/agsOM9+I/eh
   A==;
IronPort-SDR: OQcD0hW+21HJs/1YPlhfQ/Y9q39o4GUKUs0pJc/rTlJFVKhR11ljxT+STUs5htGDdX5vQ9PrLM
 b2zOcasvxxZ3hNdjuJzK1XppvS06r/MrHr/qf5MInMGyN1pF4SDqwPzoa2QSKSnFSxgFeJowWB
 Oqa69g30eUbHvyH8Gdih0HQXMZ2uVzo6mt9IvI+0r/0824Mbs+5gtMZ15zdYEnF7Ncno2pfXjw
 MexRpPsw26ygSTJqsW8ds5s2guz9KCvUFmier6OyYq51vWNIiTJ8ry3/i5Znj39dSBDAm934/Q
 +Vo=
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="97428461"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2020 02:47:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 02:47:38 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 6 Nov 2020 02:47:33 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <eugen.hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 11/11] clk: at91: sama7g5: register cpu clock
Date:   Fri, 6 Nov 2020 11:46:28 +0200
Message-ID: <1604655988-353-12-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604655988-353-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604655988-353-1-git-send-email-claudiu.beznea@microchip.com>
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

