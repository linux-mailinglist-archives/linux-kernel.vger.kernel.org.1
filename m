Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAB42FACA2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394665AbhARV1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:27:50 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:58751 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388513AbhARKKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:10:23 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 10IA30lm051718;
        Mon, 18 Jan 2021 18:03:00 +0800 (GMT-8)
        (envelope-from ryan_chen@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 18 Jan
 2021 18:08:18 +0800
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <andrewrj@au1.ibm.com>,
        <joel@linux.ibm.com>, <BMC-SW@aspeedtech.com>
CC:     Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH 1/1] clk: aspeed: Fix APLL calculate formula for ast2600-A2
Date:   Mon, 18 Jan 2021 18:08:13 +0800
Message-ID: <20210118100813.30821-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210118100813.30821-1-ryan_chen@aspeedtech.com>
References: <20210118100813.30821-1-ryan_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 10IA30lm051718
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AST2600A1/A2 have different pll calculate formula.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/clk/clk-ast2600.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
index bbacaccad554..8933bd1506b3 100644
--- a/drivers/clk/clk-ast2600.c
+++ b/drivers/clk/clk-ast2600.c
@@ -17,7 +17,8 @@
 
 #define ASPEED_G6_NUM_CLKS		71
 
-#define ASPEED_G6_SILICON_REV		0x004
+#define ASPEED_G6_SILICON_REV		0x014
+#define CHIP_REVISION_ID			GENMASK(23, 16)
 
 #define ASPEED_G6_RESET_CTRL		0x040
 #define ASPEED_G6_RESET_CTRL2		0x050
@@ -190,18 +191,34 @@ static struct clk_hw *ast2600_calc_pll(const char *name, u32 val)
 static struct clk_hw *ast2600_calc_apll(const char *name, u32 val)
 {
 	unsigned int mult, div;
+	u32 chip_id = readl(scu_g6_base + ASPEED_G6_SILICON_REV);
 
-	if (val & BIT(20)) {
-		/* Pass through mode */
-		mult = div = 1;
+	if (((chip_id & CHIP_REVISION_ID) >> 16) >= 2) {
+		if (val & BIT(24)) {
+			/* Pass through mode */
+			mult = div = 1;
+		} else {
+			/* F = 25Mhz * [(m + 1) / (n + 1)] / (p + 1) */
+			u32 m = val & 0x1fff;
+			u32 n = (val >> 13) & 0x3f;
+			u32 p = (val >> 19) & 0xf;
+
+			mult = (m + 1);
+			div = (n + 1) * (p + 1);
+		}
 	} else {
-		/* F = 25Mhz * (2-od) * [(m + 2) / (n + 1)] */
-		u32 m = (val >> 5) & 0x3f;
-		u32 od = (val >> 4) & 0x1;
-		u32 n = val & 0xf;
+		if (val & BIT(20)) {
+			/* Pass through mode */
+			mult = div = 1;
+		} else {
+			/* F = 25Mhz * (2-od) * [(m + 2) / (n + 1)] */
+			u32 m = (val >> 5) & 0x3f;
+			u32 od = (val >> 4) & 0x1;
+			u32 n = val & 0xf;
 
-		mult = (2 - od) * (m + 2);
-		div = n + 1;
+			mult = (2 - od) * (m + 2);
+			div = n + 1;
+		}
 	}
 	return clk_hw_register_fixed_factor(NULL, name, "clkin", 0,
 			mult, div);
-- 
2.17.1

