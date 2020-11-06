Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC6F2A9294
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgKFJ2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:28:22 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:42888 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgKFJ2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:28:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604654901; x=1636190901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=QpD53wBg29UptUvVNqRf5JTCpttxxocLcDTpaKiBG1k=;
  b=ZffDnelsJTyj50VwMLoLyi4FazklPyG6L1LGy/2g8/79uxjDpBpj+oXt
   +0x4nGpdCpNZ7XxuYDfs/ZFj1Gog+Pl+TZLtYuKw7gx+8Vdec386nmDj0
   41Hkw7lXzMGQohDfyfo6buwbDoIucNC79dyXGQ7ovXR9YOrbh7pyTr3kF
   fo0rF4eV8EfkLwtXei1QwXKfoSoMzIJEx+IwPpRvP8khfj7lnXCd4xZzx
   eJc9jDCF175n40Cezid/3dCkO1PB2a+8oyUVpWz0ABwFBH2gSxQW2FNBK
   tfw/A0Zm/9/RSaKWR1wV7rKSMaBW5ZXyGrtNzP3OlLHFTBmReNHBpzI1f
   g==;
IronPort-SDR: EjMR1QoQACNq8qJ+vGWcjbpfR6eyDPZMDPaO9xVEWTcaYvRGqEWZCJIDjSz1tL/ioLl1LhWUpm
 apl9uqDeN85uGlaSBfdAsxSah/yZkOFuSmC0QaYpQ9f7YEWQ9/uZrbGu5s0EKzU29nwWW3IhB2
 7awICnlRDF3/xI2XkNR7lvqQcQW+ifxHhW1iMj4haeI3+iw+NIuFytHLa+kaS8lMtYjWOMEZkF
 f5vCUJJIa5SEWqOQIn13iztIbjR3t07QoWkEEyGmeWmpSD0QGaqPSCFjCLJnEhH4ABi7TX+WqN
 3Ho=
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="97423916"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2020 02:28:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 02:28:20 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 6 Nov 2020 02:28:15 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <eugen.hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 01/11] clk: at91: sama7g5: fix compilation error
Date:   Fri, 6 Nov 2020 11:27:54 +0200
Message-ID: <1604654884-30339-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604654884-30339-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604654884-30339-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmc_data_allocate() has been changed. pmc_data_free() was removed.
Adapt the code taking this into consideration. With this the programmable
clocks were also saved in sama7g5_pmc so that they could be later
referenced.

Fixes: cb783bbbcf54 ("clk: at91: sama7g5: add clock support for sama7g5")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sama7g5.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 0db2ab3eca14..a092a940baa4 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -838,7 +838,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	sama7g5_pmc = pmc_data_allocate(PMC_I2S1_MUX + 1,
 					nck(sama7g5_systemck),
 					nck(sama7g5_periphck),
-					nck(sama7g5_gck));
+					nck(sama7g5_gck), 8);
 	if (!sama7g5_pmc)
 		return;
 
@@ -980,6 +980,8 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 						    sama7g5_prog_mux_table);
 		if (IS_ERR(hw))
 			goto err_free;
+
+		sama7g5_pmc->pchws[i] = hw;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(sama7g5_systemck); i++) {
@@ -1052,7 +1054,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 		kfree(alloc_mem);
 	}
 
-	pmc_data_free(sama7g5_pmc);
+	kfree(sama7g5_pmc);
 }
 
 /* Some clks are used for a clocksource */
-- 
2.7.4

