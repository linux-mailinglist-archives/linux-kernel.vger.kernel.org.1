Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6762A2CBECD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388847AbgLBNz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:55:29 -0500
Received: from foss.arm.com ([217.140.110.172]:40268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgLBNzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:55:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A6C31063;
        Wed,  2 Dec 2020 05:54:39 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47C133F718;
        Wed,  2 Dec 2020 05:54:37 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Icenowy Zheng <icenowy@aosc.xyz>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH 1/8] clk: sunxi-ng: h6: Fix clock divider range on some clocks
Date:   Wed,  2 Dec 2020 13:54:02 +0000
Message-Id: <20201202135409.13683-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20201202135409.13683-1-andre.przywara@arm.com>
References: <20201202135409.13683-1-andre.przywara@arm.com>
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

