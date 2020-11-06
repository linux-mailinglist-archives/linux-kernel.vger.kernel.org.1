Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76112A92A7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgKFJ2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:28:54 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:42751 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgKFJ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604654930; x=1636190930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=98KyUzL1G42E2CqSBWVfWz4SgFeNLS+jPn7ldi5xgeA=;
  b=Kw8ms06omGtxVEAkU4vPhEVXSOv38InTIzqXzzpxodEbE474tPAtUN3a
   odG3fMtAY+vAibSRZhprHOw8twsez8NxibhXyXqbyEVjLDihYwbOQN6+L
   ZmRzEju9514cnxJREPWRoC1IFAm2eHtorELgSjHJtdTnaq6kPnLrnlny0
   w8CqRbmGlRRfA5rkqCZQbylQxLZNHH+Ns/VdxIhMIKiLhCUweHIu/KNkE
   JlZD6R81ao5BiFBO22uiqKFBjMESVngnxDzqTDaq/0mtEN1l8xG9BsqoH
   LMl1wU+EWTKJeJL2YEC0CVZ3euF6Opy+D20igw22VpoJCatvcp7yMYhL5
   g==;
IronPort-SDR: Qa6bBIhOXyAqYbQx8y42zLJHd7l2KphHnyk2UKMmYai3v5HUYFQTYBTsKFTkShwYGzdnN/U+6P
 DDNeprDKWznosYc9XBHCAycflZkzr5+ddWiGb76I0bqKr2yJ6V2hYUSsLqj7k10xVqlxBxalB4
 zE4tZtFcX9nRd6GBzdJ8JSbpruTHZ3ukB37bxVaPFYIG7nLC1N19RPUBcCEo4YHsexwylAF3kp
 t6PJ/Q/MWntAD9peGebvU9BUxdupZTSdjTXrA+RqIqwwmSGJ/mkYX0iFNXMjZIhD05uAs/xphK
 iyY=
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="102448295"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2020 02:28:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 02:28:49 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 6 Nov 2020 02:28:45 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <eugen.hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 07/11] clk: at91: sama7g5: remove mck0 from parent list of other clocks
Date:   Fri, 6 Nov 2020 11:28:00 +0200
Message-ID: <1604654884-30339-8-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604654884-30339-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604654884-30339-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCK0 is changed at runtime by DVFS. Due to this, since not all IPs
are glitch free aware at MCK0 changes, remove MCK0 from parent list
of other clocks (e.g. generic clock, programmable/system clock, MCKX).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sama7g5.c | 55 ++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 33faf7c6d9fb..88ad0c70ca98 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -261,7 +261,7 @@ static const struct {
 	  .ep = { "syspll_divpmcck", "ddrpll_divpmcck", "imgpll_divpmcck", },
 	  .ep_mux_table = { 5, 6, 7, },
 	  .ep_count = 3,
-	  .ep_chg_id = 6, },
+	  .ep_chg_id = 5, },
 
 	{ .n = "mck4",
 	  .id = 4,
@@ -294,7 +294,7 @@ static const struct {
 };
 
 /* Mux table for programmable clocks. */
-static u32 sama7g5_prog_mux_table[] = { 0, 1, 2, 3, 5, 6, 7, 8, 9, 10, };
+static u32 sama7g5_prog_mux_table[] = { 0, 1, 2, 5, 6, 7, 8, 9, 10, };
 
 /**
  * Peripheral clock description
@@ -417,7 +417,7 @@ static const struct {
 	  .pp = { "audiopll_divpmcck", },
 	  .pp_mux_table = { 9, },
 	  .pp_count = 1,
-	  .pp_chg_id = 4, },
+	  .pp_chg_id = 3, },
 
 	{ .n  = "csi_gclk",
 	  .id = 33,
@@ -529,7 +529,7 @@ static const struct {
 	  .pp = { "ethpll_divpmcck", },
 	  .pp_mux_table = { 10, },
 	  .pp_count = 1,
-	  .pp_chg_id = 4, },
+	  .pp_chg_id = 3, },
 
 	{ .n  = "gmac1_gclk",
 	  .id = 52,
@@ -561,7 +561,7 @@ static const struct {
 	  .pp = { "syspll_divpmcck", "audiopll_divpmcck", },
 	  .pp_mux_table = { 5, 9, },
 	  .pp_count = 2,
-	  .pp_chg_id = 5, },
+	  .pp_chg_id = 4, },
 
 	{ .n  = "i2smcc1_gclk",
 	  .id = 58,
@@ -569,7 +569,7 @@ static const struct {
 	  .pp = { "syspll_divpmcck", "audiopll_divpmcck", },
 	  .pp_mux_table = { 5, 9, },
 	  .pp_count = 2,
-	  .pp_chg_id = 5, },
+	  .pp_chg_id = 4, },
 
 	{ .n  = "mcan0_gclk",
 	  .id = 61,
@@ -711,7 +711,7 @@ static const struct {
 	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
-	  .pp_chg_id = 5, },
+	  .pp_chg_id = 4, },
 
 	{ .n  = "sdmmc1_gclk",
 	  .id = 81,
@@ -719,7 +719,7 @@ static const struct {
 	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
-	  .pp_chg_id = 5, },
+	  .pp_chg_id = 4, },
 
 	{ .n  = "sdmmc2_gclk",
 	  .id = 82,
@@ -727,7 +727,7 @@ static const struct {
 	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
-	  .pp_chg_id = 5, },
+	  .pp_chg_id = 4, },
 
 	{ .n  = "spdifrx_gclk",
 	  .id = 84,
@@ -735,7 +735,7 @@ static const struct {
 	  .pp = { "syspll_divpmcck", "audiopll_divpmcck", },
 	  .pp_mux_table = { 5, 9, },
 	  .pp_count = 2,
-	  .pp_chg_id = 5, },
+	  .pp_chg_id = 4, },
 
 	{ .n = "spdiftx_gclk",
 	  .id = 85,
@@ -743,7 +743,7 @@ static const struct {
 	  .pp = { "syspll_divpmcck", "audiopll_divpmcck", },
 	  .pp_mux_table = { 5, 9, },
 	  .pp_count = 2,
-	  .pp_chg_id = 5, },
+	  .pp_chg_id = 4, },
 
 	{ .n  = "tcb0_ch0_gclk",
 	  .id = 88,
@@ -942,9 +942,8 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	parent_names[0] = md_slck_name;
 	parent_names[1] = td_slck_name;
 	parent_names[2] = "mainck";
-	parent_names[3] = "mck0";
 	for (i = 0; i < ARRAY_SIZE(sama7g5_mckx); i++) {
-		u8 num_parents = 4 + sama7g5_mckx[i].ep_count;
+		u8 num_parents = 3 + sama7g5_mckx[i].ep_count;
 		u32 *mux_table;
 
 		mux_table = kmalloc_array(num_parents, sizeof(*mux_table),
@@ -952,10 +951,10 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 		if (!mux_table)
 			goto err_free;
 
-		SAMA7G5_INIT_TABLE(mux_table, 4);
-		SAMA7G5_FILL_TABLE(&mux_table[4], sama7g5_mckx[i].ep_mux_table,
+		SAMA7G5_INIT_TABLE(mux_table, 3);
+		SAMA7G5_FILL_TABLE(&mux_table[3], sama7g5_mckx[i].ep_mux_table,
 				   sama7g5_mckx[i].ep_count);
-		SAMA7G5_FILL_TABLE(&parent_names[4], sama7g5_mckx[i].ep,
+		SAMA7G5_FILL_TABLE(&parent_names[3], sama7g5_mckx[i].ep,
 				   sama7g5_mckx[i].ep_count);
 
 		hw = at91_clk_sama7g5_register_master(regmap, sama7g5_mckx[i].n,
@@ -978,20 +977,19 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	parent_names[0] = md_slck_name;
 	parent_names[1] = td_slck_name;
 	parent_names[2] = "mainck";
-	parent_names[3] = "mck0";
-	parent_names[4] = "syspll_divpmcck";
-	parent_names[5] = "ddrpll_divpmcck";
-	parent_names[6] = "imgpll_divpmcck";
-	parent_names[7] = "baudpll_divpmcck";
-	parent_names[8] = "audiopll_divpmcck";
-	parent_names[9] = "ethpll_divpmcck";
+	parent_names[3] = "syspll_divpmcck";
+	parent_names[4] = "ddrpll_divpmcck";
+	parent_names[5] = "imgpll_divpmcck";
+	parent_names[6] = "baudpll_divpmcck";
+	parent_names[7] = "audiopll_divpmcck";
+	parent_names[8] = "ethpll_divpmcck";
 	for (i = 0; i < 8; i++) {
 		char name[6];
 
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name, parent_names,
-						    10, i,
+						    9, i,
 						    &programmable_layout,
 						    sama7g5_prog_mux_table);
 		if (IS_ERR(hw))
@@ -1028,9 +1026,8 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	parent_names[0] = md_slck_name;
 	parent_names[1] = td_slck_name;
 	parent_names[2] = "mainck";
-	parent_names[3] = "mck0";
 	for (i = 0; i < ARRAY_SIZE(sama7g5_gck); i++) {
-		u8 num_parents = 4 + sama7g5_gck[i].pp_count;
+		u8 num_parents = 3 + sama7g5_gck[i].pp_count;
 		u32 *mux_table;
 
 		mux_table = kmalloc_array(num_parents, sizeof(*mux_table),
@@ -1038,10 +1035,10 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 		if (!mux_table)
 			goto err_free;
 
-		SAMA7G5_INIT_TABLE(mux_table, 4);
-		SAMA7G5_FILL_TABLE(&mux_table[4], sama7g5_gck[i].pp_mux_table,
+		SAMA7G5_INIT_TABLE(mux_table, 3);
+		SAMA7G5_FILL_TABLE(&mux_table[3], sama7g5_gck[i].pp_mux_table,
 				   sama7g5_gck[i].pp_count);
-		SAMA7G5_FILL_TABLE(&parent_names[4], sama7g5_gck[i].pp,
+		SAMA7G5_FILL_TABLE(&parent_names[3], sama7g5_gck[i].pp,
 				   sama7g5_gck[i].pp_count);
 
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
-- 
2.7.4

