Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008CF2A9329
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgKFJrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:47:18 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:12018 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKFJrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604656036; x=1636192036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=98KyUzL1G42E2CqSBWVfWz4SgFeNLS+jPn7ldi5xgeA=;
  b=dfD8n+E/7Wflrh2NfAI8ZENZRH8CCwSbgkKyZCLrlZpA35ka9DrC6szH
   YThT9DPBoVF21z0LmUlL3DhiNnVKblFa3wIUcCGc3r6h+LO3DUdcpXv5U
   TkgdluirdTGWnJrl17RCKRnbVt34IFi/+PlTGCg1szuDgLddlJLyAbTb3
   Fc4QKMjOfUNVHZQ6f7E6ncZsdXgmR7xenielwS5z1TsakRz+uC64mVS4A
   oHkjSVUoyYKpAFcr9hxyVUvvNoUgewqCv+VbYIIkj+z62sa/6/inKnObx
   OGnS6Q0gbQCPith8fCoADcjLgdv4dX1M0A9bYyEiA92OhBQckKuiDSv/q
   Q==;
IronPort-SDR: SzrN3oT6ne9Ft6g65lRCO7DSneC/NsamOwhbdsS3vKzIIiMOJ/qO3P7zxsfC+rHPKi+Bbgju5H
 rwhFjh49b7ishHP5bM1GAWvImXFGjJ56VAKBCgPcJlQVdU7KJig3owVTKUe0sS6mObj0P/n3vu
 ihnL+RYW1T9/apZ9ZWhK8ShzilqQUHOOU2f6zJg7vftDujS++UitDjne2mkx2UBLpNiM0zm9I1
 7kH7lce317JmWujSrdMCcpVGcCVEzl7igHlk+m+QNDlMrA5RMRQ6zKpZmYgn0jg6HF9iMJg8XD
 Lxg=
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="102449873"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2020 02:47:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 02:47:15 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 6 Nov 2020 02:47:10 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <eugen.hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 07/11] clk: at91: sama7g5: remove mck0 from parent list of other clocks
Date:   Fri, 6 Nov 2020 11:46:24 +0200
Message-ID: <1604655988-353-8-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604655988-353-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604655988-353-1-git-send-email-claudiu.beznea@microchip.com>
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

