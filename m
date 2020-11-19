Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C362B967C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgKSPni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:43:38 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:51561 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgKSPni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605800617; x=1637336617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=9R61017uswpbIyD1o2EqTBaPjafcG4KUA5RqehOav+g=;
  b=DPeaH8HO9QWr/yFjqFE6LrLevoXT0p6xe8tDmTlU6xx9WIEKtpVUnmQX
   4rC9L48Oc0f+/dA2MAFtUj+lxBA53tmmmDltg/t8GtQQAsj4VV9icAqCq
   CS3DcJBaSIIEGEacrhRtyHEA9eIcXebgTCdgDeIESTLFl13c4e/U2rP25
   72wTUMYT0495sqTnGSaNN9EDjd637IdkllivIXvljEiY9M0IrjBM0cPgf
   1KlR7R+5d1DItIkdc6pFkppVCE4P75/bhOWjMmB9mrN+47fh3HUugjMtq
   XAaxTWnqu8xQD/e/E44kJ6Wjf+NAG7JbKDn8kjJKNuhVVRMYMVOuqubn+
   g==;
IronPort-SDR: SdjqSuzBbedYirhvvrpl03pwAs7bSgkBPQBFlH0GODNZXybxTvNsgl1NCefzQlBa8/AEQh1Gjz
 9xP4yI6pdebC5mrSABncftHdSouM8L14tZZ9rw1J93QrmgmrfcAysOt5ogZFtO7lKjuD7WgF9A
 v5QlML9u/AAlj4BK+zyLeuwVBrPD6jvmlZFLCrxozA28JV25J5zxwxNE7wz31tM3s+LlCmEKXL
 3G62lQB9HroGbValdizJrwe5FUSJtIxPDkSRgKgg3uTdVr6P9S4R59BR4w3JE/OMUe56mVmqGr
 4Ck=
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="96941984"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2020 08:43:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 19 Nov 2020 08:43:37 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 19 Nov 2020 08:43:25 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v6 01/11] clk: at91: sama7g5: fix compilation error
Date:   Thu, 19 Nov 2020 17:43:07 +0200
Message-ID: <1605800597-16720-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com>
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

