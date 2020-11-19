Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2AF2B96A3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgKSPno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:43:44 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:51561 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbgKSPnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605800622; x=1637336622;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=B6iK+n7nM/nQQNkN9ji7/vC55A4k5oqZAjN/W6Ui+Vw=;
  b=tPmoY54dLaPHRG+STW6j5o2zbbreP5RVJUJF2EvajqZe4opMHhesXk+P
   OVjZcRenLvDhlL1z63B5c8kPCiWN3lHi5//HNvinRarW2vLc1gcto920I
   Bkf0BybVV+RS+pqVdz1oQTP2PuJsJIG0Xyu52jcS0IcZizAVys3F8Q1oi
   xyAyFliuqxgHSgSAYyc6aSAXbtqJ9m2g/Npf/J/bJrHJZlu2hqV1xYH9H
   Qcvx19/xnjznDOjLEiJhDWmMetU+26sI5nxTE7NU6SWeH9K5wcsJwGb8u
   4r70BIBZM3PF3gHx6YtpP1g9rRaL0q98HANq0n7rNYgc8kYBjuzHKbniA
   Q==;
IronPort-SDR: 8q1T90tUMXqXsaikV08ADp8oOh6FUCRg90naRZYNGLd5ItkTH6x+tUTV0liDno1LkF66W+X+0i
 +UsF7iVgc7rMAsIP7fFd4tVn3usu8HE1IANTENSTzhy1Y271jaAOBpWHZQQzQ1VR0HobS5NhT0
 UpTjZ5qvL3OuN57RYAZM7j58XPXY0wHgBMXI8HL/GyFpDsH2ofKIK3zjwSmSUotngqzEQEdbTO
 152PUt0yw8kBWoLTUnJ7rO1HBoOT//LV/URcSpZbGIF7sNJw7PSbE+QRFnSjUWTbs7XONLww/H
 yCQ=
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="96941988"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2020 08:43:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 19 Nov 2020 08:43:42 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 19 Nov 2020 08:43:37 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v6 02/11] dt-bindings: clock: at91: add sama7g5 pll defines
Date:   Thu, 19 Nov 2020 17:43:08 +0200
Message-ID: <1605800597-16720-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com>
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

