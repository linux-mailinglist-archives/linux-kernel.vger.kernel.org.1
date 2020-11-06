Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CB52A931A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgKFJqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:46:50 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:41860 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgKFJqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604656009; x=1636192009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=B6iK+n7nM/nQQNkN9ji7/vC55A4k5oqZAjN/W6Ui+Vw=;
  b=q4Jc0q9mUJ2WXMCQ/2Om+R+uqjepp7LA6mw4fk8ktsHxch3Kc0vDiiH1
   f0XC24Abh94oeOd9S16t7kPVXiSgDo8Xrv0u3OUpgetiuftVJ+/TBjsC5
   XZliiTv6wI8qbOXM1J1s/+g74cr7oMd+NR4bTfznJKdbX8Uqz6yxh+6cd
   e8L7ycvzjD5TSzLRPnC1ZWhi6CUHxL4DekcO1FxNzJG1JzbtbeuFT5jy/
   7ad+mAFhLoMc7KkMj/RTwcyDdoxRV1sc48ZynNWRT4Uyd0PENAZgB/Ap9
   440ktN49RM6BvJZhEgHc6sSGSlEJiWKC7hf2gTuH1q3SDkQ2kllzIaLRh
   A==;
IronPort-SDR: qAW1mOVj/tsoziBhE2olnJp3nnmo8Ma78V5s6RkmtI5nwGlbVwXtUQL+zZG1MZ9MvTwwf2JDdf
 qGjQxVr3J6ARiHnmBvuPReVVYQtpgU/jDU2GNBTCq0v0981nWfGavAlhXy/aVKvBrEyKW0nvom
 BwaAH4Bms3fG98HYIUm33CM2KmC3zQKDbK290f6f/wsI4bJt+Pfy3o2MUYOEqbHSDDQ6+g8GJA
 4GlFnj/TSP17Ph7nhTkRZ4Saz7M00aP20CCZlNfa6BWim3bSb6s1WzMF1Rojh83pFuy3LNuSAw
 OiE=
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="97428282"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2020 02:46:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 02:46:47 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 6 Nov 2020 02:46:43 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <eugen.hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 02/11] dt-bindings: clock: at91: add sama7g5 pll defines
Date:   Fri, 6 Nov 2020 11:46:19 +0200
Message-ID: <1604655988-353-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604655988-353-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604655988-353-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Add SAMA7G5 specific PLL defines to be referenced in a phandle as a
PMC_TYPE_CORE clock.

Suggested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
[claudiu.beznea@microchip.com: adapt comit message, adapt sama7g5.c]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sama7g5.c       |  6 +++---
 include/dt-bindings/clock/at91.h | 10 ++++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index a092a940baa4..7ef7963126b6 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -182,13 +182,13 @@ static const struct {
 		  .p = "audiopll_fracck",
 		  .l = &pll_layout_divpmc,
 		  .t = PLL_TYPE_DIV,
-		  .eid = PMC_I2S0_MUX, },
+		  .eid = PMC_AUDIOPMCPLL, },
 
 		{ .n = "audiopll_diviock",
 		  .p = "audiopll_fracck",
 		  .l = &pll_layout_divio,
 		  .t = PLL_TYPE_DIV,
-		  .eid = PMC_I2S1_MUX, },
+		  .eid = PMC_AUDIOIOPLL, },
 	},
 
 	[PLL_ID_ETH] = {
@@ -835,7 +835,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	sama7g5_pmc = pmc_data_allocate(PMC_I2S1_MUX + 1,
+	sama7g5_pmc = pmc_data_allocate(PMC_ETHPLL + 1,
 					nck(sama7g5_systemck),
 					nck(sama7g5_periphck),
 					nck(sama7g5_gck), 8);
diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
index eba17106608b..fab313f62e8f 100644
--- a/include/dt-bindings/clock/at91.h
+++ b/include/dt-bindings/clock/at91.h
@@ -25,6 +25,16 @@
 #define PMC_PLLBCK		8
 #define PMC_AUDIOPLLCK		9
 
+/* SAMA7G5 */
+#define PMC_CPUPLL		(PMC_MAIN + 1)
+#define PMC_SYSPLL		(PMC_MAIN + 2)
+#define PMC_DDRPLL		(PMC_MAIN + 3)
+#define PMC_IMGPLL		(PMC_MAIN + 4)
+#define PMC_BAUDPLL		(PMC_MAIN + 5)
+#define PMC_AUDIOPMCPLL		(PMC_MAIN + 6)
+#define PMC_AUDIOIOPLL		(PMC_MAIN + 7)
+#define PMC_ETHPLL		(PMC_MAIN + 8)
+
 #ifndef AT91_PMC_MOSCS
 #define AT91_PMC_MOSCS		0		/* MOSCS Flag */
 #define AT91_PMC_LOCKA		1		/* PLLA Lock */
-- 
2.7.4

