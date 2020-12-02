Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5B72CBD98
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbgLBM7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:59:24 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:35567 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729956AbgLBM7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:59:24 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id BFA07200004;
        Wed,  2 Dec 2020 12:58:41 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: at91: sam9x60: remove atmel,osc-bypass support
Date:   Wed,  2 Dec 2020 13:58:15 +0100
Message-Id: <20201202125816.168618-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sam9x60 doesn't have the MOSCXTBY bit to enable the crystal oscillator
bypass.

Fixes: 01e2113de9a5 ("clk: at91: add sam9x60 pmc driver")
Reported-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/sam9x60.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 3c4c95603595..c8cbec5308f0 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -174,7 +174,6 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	struct regmap *regmap;
 	struct clk_hw *hw;
 	int i;
-	bool bypass;
 
 	i = of_property_match_string(np, "clock-names", "td_slck");
 	if (i < 0)
@@ -209,10 +208,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
-	bypass = of_property_read_bool(np, "atmel,osc-bypass");
-
-	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name,
-					bypass);
+	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 	main_osc_hw = hw;
-- 
2.28.0

