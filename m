Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4401D2A60AE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 10:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgKDJkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 04:40:19 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:30935 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgKDJkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 04:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604482817; x=1636018817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=QpD53wBg29UptUvVNqRf5JTCpttxxocLcDTpaKiBG1k=;
  b=Kub9+vfIjcZLV0yp1M6O6Y3BxGwaxEHrPiZNw4xWJtbVQfly5+CfQkBu
   HUefYyNUM9E2Ux0PtGzEjCVvjgtd5FsrTi648pd6QjSev3au6GS8+6lcn
   wjhHi7tKpqwbcd2OI6zEN7ILg1E4o1P51n+EJ8VeaDOtS9XwcFbGscG0V
   MiGny1jb4NnLetXKtOqRtSfYV2ZG6W8sDiQapi82k4qNJiW9hLwuNVYck
   lj5jClJ7q8B7nkIv63EGrsAmvHMXO2eTO//COxGnBBDleI5ONzY66gNZv
   J9FMdPMuDoJ0yy7EchI1U2rZVXAhsWpZun1Kd5iFsj/7lr2S5Cdaoa62Q
   g==;
IronPort-SDR: zEc3iTYy5GwZyJs0ZA1yBBdboQeNT/qdAQuu0a08lohqoRXldUafOOjSHKfZGAEDrpkUO3DINI
 540IHUzO4Sj6EKHMQSTiHhUI+QRB5X6C/HFWy3K9e6uTuAVEHjy2niXNE4uaAmZzKTYLt1Rm1q
 KsiATmNZ3dAbwwO+gCfL14xVQW9h8NKOo3oeiVFtvxBmDB8BxRyNqaKjIb4TgrVtT2oCCll1wQ
 Y9aN3O7jFlitLF8Txsg541vBE1xSa5MslVI0nGjKdBnHCBzaz7MCorN48ao0TP8099FUSNlQjd
 h2g=
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="102141343"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Nov 2020 02:40:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 4 Nov 2020 02:40:16 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 4 Nov 2020 02:40:11 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/8] clk: at91: sama7g5: fix compilation error
Date:   Wed, 4 Nov 2020 11:39:55 +0200
Message-ID: <1604482802-1647-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604482802-1647-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604482802-1647-1-git-send-email-claudiu.beznea@microchip.com>
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

