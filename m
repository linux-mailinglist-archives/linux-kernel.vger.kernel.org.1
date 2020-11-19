Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143942B94C7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgKSOim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:38:42 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:59075 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbgKSOim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:38:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605796721; x=1637332721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=9R61017uswpbIyD1o2EqTBaPjafcG4KUA5RqehOav+g=;
  b=TURsbiUBk+4++TUYikM0KiS02sSuX0hR6h77h8u0fyElCDnZePcwCTio
   20tfuvmxs9XBPZrMMlMDXV1ji2CFTg1Cft5/kViF00JKkERm9PUK8S91K
   W3RzZyZaryETXwEhmZNAmKFt5TiDeGbj07Ej3IxFXdrfm0dxD7idLHq+A
   r990Zwj7s9bEQKi/iGie1BH+ODxK5pWxTZ0ocFZt0bxyccBowCONZYc4Q
   Afp+p/hbMmJ9dZXyPqxQ9uuW8EBtJBpAeDB1ACm/vL6gC+WUBlL6MuBqw
   tQP0OGMzwJNtUWqLGwZdZI9cpb2N7qNrSw+qihHzhF/ScRaCchrj43lg7
   w==;
IronPort-SDR: I2B8Tzcke/8L1qCvBxv43CpIeqVaTtoj3pOEnNLfQiJCR1H8dgyOGjLhnw5ehM1CvnCHALxgYX
 8BzUCXVGiFm629K7i3tte7Jddx1II+06DDPs1fklBYlgMTYtgWxVx1ZuDBAljD0aefx8zWwyrm
 WVV0c7yX1+Mcsz6NH5mynDrOJ8cohH3ibk7yTT6EnZB1he9xvqBZ55EVQ3bIY/dDkf67fz9wjZ
 bdP9F8v+HxwE+oZRYnHFkZftk4XI/Jux7NM13hb9ucoqNNtcx1W3jZgjcWzpgGUB0/KCAFOB0D
 Vr4=
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="104251687"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2020 07:38:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 19 Nov 2020 07:38:41 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 19 Nov 2020 07:38:37 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 01/11] clk: at91: sama7g5: fix compilation error
Date:   Thu, 19 Nov 2020 16:38:17 +0200
Message-ID: <1605796707-8378-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605796707-8378-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605796707-8378-1-git-send-email-claudiu.beznea@microchip.com>
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

