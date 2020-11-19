Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D812B94E3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgKSOjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:39:21 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:41650 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgKSOjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:39:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605796756; x=1637332756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=eqQ9vmVzKd47SLJ7QkzkwDhKpQw3LnBtfzn630VKALc=;
  b=CSCfoDTXu6dDWMoMujHYDba/B0QHPE6mk1C5bTtYrbZFXeP3TbuWsIKP
   /j8W03nf+xwf2mBa7kVpRQ1g5DTHdyWukhB/1y3zfqraAaq8LOGOVkEEh
   U0iUyec+8kxSWPYOOGYLiHREb+jW185N4wgRB2qFigQwA0OeHiG4WfRgV
   5ZWi9WlQTEiUO74ZyxfzMjpxDj5RNqE1+Lh2PAmZW5K25rkOsW21yDj6U
   l3lnjHFUJUtg1hJyxePjgjXr5RHVdD871bFTDSbna4tV5mF1zmr4WQvlR
   l3129EcK9NQaACPjyQhGV7I20nwgGmc98G5BemXjup4Ca9TTD9JqfhITI
   g==;
IronPort-SDR: LvLq8RPeKUXohZbgAU7OKDttudJCTtRit0bQ0VPE+H0HJdCfQQh6pt3BrkXBC9/XWGeD26o4bi
 3EUi8nBnjgpZSUHijGcBwFrk39fJGOywDkcN1u7DLic5LeYdpQ8pEorhLFgKPv0zlrkSg4TG6u
 8BH99MhpAD3GUqHlaRE2vizrdYjLDVXAM1VsIlAq9XupsdJFVW3jv522IJu8TEnhvEh5VRKUtu
 11KUZclVAXqO1jfjfbb5ateDaizjvo/SFeB0yfmpQxrRnTfFamtdzDej6CdRsmRKIo1Eayl9fm
 Myo=
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="94238025"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2020 07:39:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 19 Nov 2020 07:39:15 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 19 Nov 2020 07:39:11 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 09/11] clk: at91: sama7g5: do not allow cpu pll to go higher than 1GHz
Date:   Thu, 19 Nov 2020 16:38:25 +0200
Message-ID: <1605796707-8378-10-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605796707-8378-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605796707-8378-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since CPU PLL feeds both CPU clock and MCK0, MCK0 cannot go higher
than 200MHz and MCK0 maximum prescaller is 5 limit the CPU PLL at
1GHz to avoid MCK0 overclocking while CPU PLL is changed by DVFS.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sama7g5.c | 61 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 29d9781e6712..e0c4d2eb9f59 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -89,11 +89,40 @@ static const struct clk_pll_layout pll_layout_divio = {
 	.endiv_shift	= 30,
 };
 
+/*
+ * CPU PLL output range.
+ * Notice: The upper limit has been setup to 1000000002 due to hardware
+ * block which cannot output exactly 1GHz.
+ */
+static const struct clk_range cpu_pll_outputs[] = {
+	{ .min = 2343750, .max = 1000000002 },
+};
+
+/* PLL output range. */
+static const struct clk_range pll_outputs[] = {
+	{ .min = 2343750, .max = 1200000000 },
+};
+
+/* CPU PLL characteristics. */
+static const struct clk_pll_characteristics cpu_pll_characteristics = {
+	.input = { .min = 12000000, .max = 50000000 },
+	.num_output = ARRAY_SIZE(cpu_pll_outputs),
+	.output = cpu_pll_outputs,
+};
+
+/* PLL characteristics. */
+static const struct clk_pll_characteristics pll_characteristics = {
+	.input = { .min = 12000000, .max = 50000000 },
+	.num_output = ARRAY_SIZE(pll_outputs),
+	.output = pll_outputs,
+};
+
 /**
  * PLL clocks description
  * @n:		clock name
  * @p:		clock parent
  * @l:		clock layout
+ * @c:		clock characteristics
  * @t:		clock type
  * @f:		clock flags
  * @eid:	export index in sama7g5->chws[] array
@@ -102,6 +131,7 @@ static const struct {
 	const char *n;
 	const char *p;
 	const struct clk_pll_layout *l;
+	const struct clk_pll_characteristics *c;
 	unsigned long f;
 	u8 t;
 	u8 eid;
@@ -110,6 +140,7 @@ static const struct {
 		{ .n = "cpupll_fracck",
 		  .p = "mainck",
 		  .l = &pll_layout_frac,
+		  .c = &cpu_pll_characteristics,
 		  .t = PLL_TYPE_FRAC,
 		   /*
 		    * This feeds cpupll_divpmcck which feeds CPU. It should
@@ -120,6 +151,7 @@ static const struct {
 		{ .n = "cpupll_divpmcck",
 		  .p = "cpupll_fracck",
 		  .l = &pll_layout_divpmc,
+		  .c = &cpu_pll_characteristics,
 		  .t = PLL_TYPE_DIV,
 		   /* This feeds CPU. It should not be disabled. */
 		  .f = CLK_IS_CRITICAL | CLK_SET_RATE_PARENT,
@@ -130,6 +162,7 @@ static const struct {
 		{ .n = "syspll_fracck",
 		  .p = "mainck",
 		  .l = &pll_layout_frac,
+		  .c = &pll_characteristics,
 		  .t = PLL_TYPE_FRAC,
 		   /*
 		    * This feeds syspll_divpmcck which may feed critial parts
@@ -141,6 +174,7 @@ static const struct {
 		{ .n = "syspll_divpmcck",
 		  .p = "syspll_fracck",
 		  .l = &pll_layout_divpmc,
+		  .c = &pll_characteristics,
 		  .t = PLL_TYPE_DIV,
 		   /*
 		    * This may feed critial parts of the systems like timers.
@@ -154,6 +188,7 @@ static const struct {
 		{ .n = "ddrpll_fracck",
 		  .p = "mainck",
 		  .l = &pll_layout_frac,
+		  .c = &pll_characteristics,
 		  .t = PLL_TYPE_FRAC,
 		   /*
 		    * This feeds ddrpll_divpmcck which feeds DDR. It should not
@@ -164,6 +199,7 @@ static const struct {
 		{ .n = "ddrpll_divpmcck",
 		  .p = "ddrpll_fracck",
 		  .l = &pll_layout_divpmc,
+		  .c = &pll_characteristics,
 		  .t = PLL_TYPE_DIV,
 		   /* This feeds DDR. It should not be disabled. */
 		  .f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE, },
@@ -173,12 +209,14 @@ static const struct {
 		{ .n = "imgpll_fracck",
 		  .p = "mainck",
 		  .l = &pll_layout_frac,
+		  .c = &pll_characteristics,
 		  .t = PLL_TYPE_FRAC,
 		  .f = CLK_SET_RATE_GATE, },
 
 		{ .n = "imgpll_divpmcck",
 		  .p = "imgpll_fracck",
 		  .l = &pll_layout_divpmc,
+		  .c = &pll_characteristics,
 		  .t = PLL_TYPE_DIV,
 		  .f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
 		       CLK_SET_RATE_PARENT, },
@@ -188,12 +226,14 @@ static const struct {
 		{ .n = "baudpll_fracck",
 		  .p = "mainck",
 		  .l = &pll_layout_frac,
+		  .c = &pll_characteristics,
 		  .t = PLL_TYPE_FRAC,
 		  .f = CLK_SET_RATE_GATE, },
 
 		{ .n = "baudpll_divpmcck",
 		  .p = "baudpll_fracck",
 		  .l = &pll_layout_divpmc,
+		  .c = &pll_characteristics,
 		  .t = PLL_TYPE_DIV,
 		  .f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
 		       CLK_SET_RATE_PARENT, },
@@ -203,12 +243,14 @@ static const struct {
 		{ .n = "audiopll_fracck",
 		  .p = "main_xtal",
 		  .l = &pll_layout_frac,
+		  .c = &pll_characteristics,
 		  .t = PLL_TYPE_FRAC,
 		  .f = CLK_SET_RATE_GATE, },
 
 		{ .n = "audiopll_divpmcck",
 		  .p = "audiopll_fracck",
 		  .l = &pll_layout_divpmc,
+		  .c = &pll_characteristics,
 		  .t = PLL_TYPE_DIV,
 		  .f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
 		       CLK_SET_RATE_PARENT,
@@ -217,6 +259,7 @@ static const struct {
 		{ .n = "audiopll_diviock",
 		  .p = "audiopll_fracck",
 		  .l = &pll_layout_divio,
+		  .c = &pll_characteristics,
 		  .t = PLL_TYPE_DIV,
 		  .f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
 		       CLK_SET_RATE_PARENT,
@@ -227,12 +270,14 @@ static const struct {
 		{ .n = "ethpll_fracck",
 		  .p = "main_xtal",
 		  .l = &pll_layout_frac,
+		  .c = &pll_characteristics,
 		  .t = PLL_TYPE_FRAC,
 		  .f = CLK_SET_RATE_GATE, },
 
 		{ .n = "ethpll_divpmcck",
 		  .p = "ethpll_fracck",
 		  .l = &pll_layout_divpmc,
+		  .c = &pll_characteristics,
 		  .t = PLL_TYPE_DIV,
 		  .f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
 		       CLK_SET_RATE_PARENT, },
@@ -793,18 +838,6 @@ static const struct {
 	  .pp_chg_id = INT_MIN, },
 };
 
-/* PLL output range. */
-static const struct clk_range pll_outputs[] = {
-	{ .min = 2343750, .max = 1200000000 },
-};
-
-/* PLL characteristics. */
-static const struct clk_pll_characteristics pll_characteristics = {
-	.input = { .min = 12000000, .max = 50000000 },
-	.num_output = ARRAY_SIZE(pll_outputs),
-	.output = pll_outputs,
-};
-
 /* MCK0 characteristics. */
 static const struct clk_master_characteristics mck0_characteristics = {
 	.output = { .min = 50000000, .max = 200000000 },
@@ -921,7 +954,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 				hw = sam9x60_clk_register_frac_pll(regmap,
 					&pmc_pll_lock, sama7g5_plls[i][j].n,
 					sama7g5_plls[i][j].p, parent_hw, i,
-					&pll_characteristics,
+					sama7g5_plls[i][j].c,
 					sama7g5_plls[i][j].l,
 					sama7g5_plls[i][j].f);
 				break;
@@ -930,7 +963,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 				hw = sam9x60_clk_register_div_pll(regmap,
 					&pmc_pll_lock, sama7g5_plls[i][j].n,
 					sama7g5_plls[i][j].p, i,
-					&pll_characteristics,
+					sama7g5_plls[i][j].c,
 					sama7g5_plls[i][j].l,
 					sama7g5_plls[i][j].f);
 				break;
-- 
2.7.4

