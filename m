Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5FE2D6D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 02:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404925AbgLKBVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:21:12 -0500
Received: from foss.arm.com ([217.140.110.172]:49294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404734AbgLKBUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:20:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 003A131B;
        Thu, 10 Dec 2020 17:19:56 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7C953F66B;
        Thu, 10 Dec 2020 17:19:53 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Icenowy Zheng <icenowy@aosc.xyz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH v2 01/21] clk: sunxi-ng: h6: Fix clock divider range on some clocks
Date:   Fri, 11 Dec 2020 01:19:14 +0000
Message-Id: <20201211011934.6171-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20201211011934.6171-1-andre.przywara@arm.com>
References: <20201211011934.6171-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While comparing clocks between the H6 and H616, some of the M factor
ranges were found to be wrong: the manual says they are only covering
two bits [1:0], but our code had "5" in the number-of-bits field.

By writing 0xff into that register in U-Boot and via FEL, it could be
confirmed that bits [4:2] are indeed masked off, so the manual is right.

Change to number of bits in the affected clock's description.

Fixes: 524353ea480b ("clk: sunxi-ng: add support for the Allwinner H6 CCU")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index f2497d0a4683..d0565d378ea2 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -237,7 +237,7 @@ static const char * const psi_ahb1_ahb2_parents[] = { "osc24M", "osc32k",
 static SUNXI_CCU_MP_WITH_MUX(psi_ahb1_ahb2_clk, "psi-ahb1-ahb2",
 			     psi_ahb1_ahb2_parents,
 			     0x510,
-			     0, 5,	/* M */
+			     0, 2,	/* M */
 			     8, 2,	/* P */
 			     24, 2,	/* mux */
 			     0);
@@ -246,19 +246,19 @@ static const char * const ahb3_apb1_apb2_parents[] = { "osc24M", "osc32k",
 						       "psi-ahb1-ahb2",
 						       "pll-periph0" };
 static SUNXI_CCU_MP_WITH_MUX(ahb3_clk, "ahb3", ahb3_apb1_apb2_parents, 0x51c,
-			     0, 5,	/* M */
+			     0, 2,	/* M */
 			     8, 2,	/* P */
 			     24, 2,	/* mux */
 			     0);
 
 static SUNXI_CCU_MP_WITH_MUX(apb1_clk, "apb1", ahb3_apb1_apb2_parents, 0x520,
-			     0, 5,	/* M */
+			     0, 2,	/* M */
 			     8, 2,	/* P */
 			     24, 2,	/* mux */
 			     0);
 
 static SUNXI_CCU_MP_WITH_MUX(apb2_clk, "apb2", ahb3_apb1_apb2_parents, 0x524,
-			     0, 5,	/* M */
+			     0, 2,	/* M */
 			     8, 2,	/* P */
 			     24, 2,	/* mux */
 			     0);
-- 
2.17.5

