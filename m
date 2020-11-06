Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D72C2A9315
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgKFJqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:46:45 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:50415 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgKFJqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604656003; x=1636192003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=9R61017uswpbIyD1o2EqTBaPjafcG4KUA5RqehOav+g=;
  b=fpmrG1xWcI5PP0dGVAh+ApQ7KSaLlMK2enaOBx9So1SJXHAngPN2q3yZ
   PnzrIG8emaR8fht1smp3VL3KPzPBV6gPw//sUisc/UsYQLAhcATmV0qYM
   OM49t3rP8cJyLsS40HRoBcLsgEkbcqqR/haFZiaiRBa0coxdRmpO861pG
   iAT3Qbfsg7RzdMbZpIpCdnlfhDVW+KexKCDmRJdOXN/YxhOL8Snnyl+yB
   sqijmFYxt95QZUhCMXKBIRcNP7b0jqPvy2ZDI6a6fFn0sYvwrfQ+zwkWe
   sc/gmYBIos6MCK5qvAHxC5qxRZzPHqrVL0wQdFlwVlBNVGJwSdJhr9goH
   Q==;
IronPort-SDR: LAlcZvmh2tZKlSWwiXUrqC0nrSpyWeDhc48OEzQe3iLcwMRTGRdaRW4evocKio0r2oYynQ0Y7O
 NJfM8cpapIdzighNcE09+IVOH4GF2tvigmN4p5md96pEHsN4hqi0mr3syyq4btYR218lmqm3cQ
 W8FQEXQll4WlzeC1YdpJalVCjEZX1UY0LeqIpAWd2JyIfqQY0yI+UCogS2aUa5x+7/xAzBF+i/
 E8ZWH5kgGw2Is2ZDlMTiQPYHzxdKmf1VWEyWuQyR6qkHHZ7RIdhQxOJRVMAODJYvl4KuXHk7c0
 zYc=
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="95342450"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2020 02:46:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 02:46:42 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 6 Nov 2020 02:46:37 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <eugen.hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 01/11] clk: at91: sama7g5: fix compilation error
Date:   Fri, 6 Nov 2020 11:46:18 +0200
Message-ID: <1604655988-353-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604655988-353-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604655988-353-1-git-send-email-claudiu.beznea@microchip.com>
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
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Tested-by: Tudor Ambarus <tudor.ambarus@microchip.com>
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

