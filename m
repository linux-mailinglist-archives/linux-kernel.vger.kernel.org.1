Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06772B94DC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgKSOjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:39:10 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:3226 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgKSOjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605796749; x=1637332749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=W0EYnzeT05UvJEJwvjAm0JWvbbfh7lxRpbdoXF8ZdEc=;
  b=lfmvVSIyLVVzLDsepHccAUk9ODjqjMC4/mYO1HxJ9E4daDUBh+RRoIB3
   sbclm5M72yJgmld7K6QMzlX5kfLTcJryt3GgHo6SFS223rWOaJMCdS7Rh
   C0nuKWZy/AiJkBTtcLTjw41uhWoXS0ib6ZZzsTTCoTa1JI6uwa5Md/o1J
   yZsT82N70FXQ0Mbea3rsoIfjBYXYE7YL50cC4Ln/puOwWxq7Ca91FVpD6
   asxPnNmujbGyE44D5PCiiKqN2T55B3ftr3LNGtncvZv2TXzDsEedzC+dH
   s7p2tvpaA/0o0UGEo8g1t9qwzghWYTRkH7nyIGij4A/bcWcxhhBRk0W+L
   A==;
IronPort-SDR: 2Mk7GmzQAE7+dIq/A5dbcJ6sEm3baM7F/euJ5Lfc04A5z4qMsRs78JG2RCy+Cp8JgeTrApTPxE
 +4m3Hfophh/7j50c6V4pKDSQYrVoKWonCsidT3BaXwTdGwgI+hbe8zuyABICwi/KUrzDGxHx/J
 hd96E7ji1pMdIMQno+a9aPr4VO8kcGOve2L7wVjNMnfmNdInip60gqU77cwAi/6vH6I2gvKzcS
 Kf6wprNQc+e8zP52FGFLcWu/5emsAE1UwA9ICKlsFgh/q1SnTenSJCCiRygljUXoEEUzZcFRiA
 sx8=
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="96925428"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2020 07:39:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 19 Nov 2020 07:39:08 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 19 Nov 2020 07:39:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 07/11] clk: at91: sama7g5: remove mck0 from parent list of other clocks
Date:   Thu, 19 Nov 2020 16:38:23 +0200
Message-ID: <1605796707-8378-8-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605796707-8378-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605796707-8378-1-git-send-email-claudiu.beznea@microchip.com>
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
index d7c2b731ad20..335e9c943c65 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -280,7 +280,7 @@ static const struct {
 	  .ep = { "syspll_divpmcck", "ddrpll_divpmcck", "imgpll_divpmcck", },
 	  .ep_mux_table = { 5, 6, 7, },
 	  .ep_count = 3,
-	  .ep_chg_id = 6, },
+	  .ep_chg_id = 5, },
 
 	{ .n = "mck4",
 	  .id = 4,
@@ -313,7 +313,7 @@ static const struct {
 };
 
 /* Mux table for programmable clocks. */
-static u32 sama7g5_prog_mux_table[] = { 0, 1, 2, 3, 5, 6, 7, 8, 9, 10, };
+static u32 sama7g5_prog_mux_table[] = { 0, 1, 2, 5, 6, 7, 8, 9, 10, };
 
 /**
  * Peripheral clock description
@@ -436,7 +436,7 @@ static const struct {
 	  .pp = { "audiopll_divpmcck", },
 	  .pp_mux_table = { 9, },
 	  .pp_count = 1,
-	  .pp_chg_id = 4, },
+	  .pp_chg_id = 3, },
 
 	{ .n  = "csi_gclk",
 	  .id = 33,
@@ -548,7 +548,7 @@ static const struct {
 	  .pp = { "ethpll_divpmcck", },
 	  .pp_mux_table = { 10, },
 	  .pp_count = 1,
-	  .pp_chg_id = 4, },
+	  .pp_chg_id = 3, },
 
 	{ .n  = "gmac1_gclk",
 	  .id = 52,
@@ -580,7 +580,7 @@ static const struct {
 	  .pp = { "syspll_divpmcck", "audiopll_divpmcck", },
 	  .pp_mux_table = { 5, 9, },
 	  .pp_count = 2,
-	  .pp_chg_id = 5, },
+	  .pp_chg_id = 4, },
 
 	{ .n  = "i2smcc1_gclk",
 	  .id = 58,
@@ -588,7 +588,7 @@ static const struct {
 	  .pp = { "syspll_divpmcck", "audiopll_divpmcck", },
 	  .pp_mux_table = { 5, 9, },
 	  .pp_count = 2,
-	  .pp_chg_id = 5, },
+	  .pp_chg_id = 4, },
 
 	{ .n  = "mcan0_gclk",
 	  .id = 61,
@@ -730,7 +730,7 @@ static const struct {
 	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
-	  .pp_chg_id = 5, },
+	  .pp_chg_id = 4, },
 
 	{ .n  = "sdmmc1_gclk",
 	  .id = 81,
@@ -738,7 +738,7 @@ static const struct {
 	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
-	  .pp_chg_id = 5, },
+	  .pp_chg_id = 4, },
 
 	{ .n  = "sdmmc2_gclk",
 	  .id = 82,
@@ -746,7 +746,7 @@ static const struct {
 	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
 	  .pp_mux_table = { 5, 8, },
 	  .pp_count = 2,
-	  .pp_chg_id = 5, },
+	  .pp_chg_id = 4, },
 
 	{ .n  = "spdifrx_gclk",
 	  .id = 84,
@@ -754,7 +754,7 @@ static const struct {
 	  .pp = { "syspll_divpmcck", "audiopll_divpmcck", },
 	  .pp_mux_table = { 5, 9, },
 	  .pp_count = 2,
-	  .pp_chg_id = 5, },
+	  .pp_chg_id = 4, },
 
 	{ .n = "spdiftx_gclk",
 	  .id = 85,
@@ -762,7 +762,7 @@ static const struct {
 	  .pp = { "syspll_divpmcck", "audiopll_divpmcck", },
 	  .pp_mux_table = { 5, 9, },
 	  .pp_count = 2,
-	  .pp_chg_id = 5, },
+	  .pp_chg_id = 4, },
 
 	{ .n  = "tcb0_ch0_gclk",
 	  .id = 88,
@@ -961,9 +961,8 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	parent_names[0] = md_slck_name;
 	parent_names[1] = td_slck_name;
 	parent_names[2] = "mainck";
-	parent_names[3] = "mck0";
 	for (i = 0; i < ARRAY_SIZE(sama7g5_mckx); i++) {
-		u8 num_parents = 4 + sama7g5_mckx[i].ep_count;
+		u8 num_parents = 3 + sama7g5_mckx[i].ep_count;
 		u32 *mux_table;
 
 		mux_table = kmalloc_array(num_parents, sizeof(*mux_table),
@@ -971,10 +970,10 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
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
@@ -997,20 +996,19 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
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
@@ -1047,9 +1045,8 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	parent_names[0] = md_slck_name;
 	parent_names[1] = td_slck_name;
 	parent_names[2] = "mainck";
-	parent_names[3] = "mck0";
 	for (i = 0; i < ARRAY_SIZE(sama7g5_gck); i++) {
-		u8 num_parents = 4 + sama7g5_gck[i].pp_count;
+		u8 num_parents = 3 + sama7g5_gck[i].pp_count;
 		u32 *mux_table;
 
 		mux_table = kmalloc_array(num_parents, sizeof(*mux_table),
@@ -1057,10 +1054,10 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
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

