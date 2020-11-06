Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0402A9298
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgKFJ21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:28:27 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:42888 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgKFJ2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604654905; x=1636190905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=B6iK+n7nM/nQQNkN9ji7/vC55A4k5oqZAjN/W6Ui+Vw=;
  b=Agrmwwrm74pUUc3UFFOW+mx2j7ehlR5kGLYujxNWL5AntIsoUfz56ZqP
   AvG+xtEO0PzIa6Z/sldmJlX52h/lCZH/qFPc38BBxjnuM9wJiZqAaGo6H
   VMz/8bJR7zNROsZWGGcherFGepoz0YHUvoeEKtHrKLhwxC6H4y4MLmUZD
   MJTrAZfxp52I820HB9JGo22TWxtGaBSM9hCoI6gMHeZrzQcB9nEoXWYYS
   SQZd0vdBPi29ZKmcUsuuEuZDHhVneSqj8aGQRvfp69YXX6A4b5smtPj2i
   sSaYdzVEIiwVbXZzw6OHfBzE1LsTwZgIaxNtzYOn7t6k9RjWqHQf6kwdU
   w==;
IronPort-SDR: le04PSe6TD0jb7YDhgqoMvNMuB+xCV+VB/N2BQM6pId8Uy0BK04ZGNpE6/q3ceP+R+vjSWCGkI
 PVSWuUnIFtXGWoxrAguGG26zv/HpFqzLfmuvfyX9FsQtzvK3KlS6tlvlLY2xZa564/1fQ6mCX7
 y00fN8WHAUmbgoRCsCzrTGT9lyAOhVHYX6OE4qbo0Hb7vGnUuyFeSjuLUVgcwl61h+9GIvDSsx
 QRfKuAV/LoionQCXCtCZQEbVQn9oVy0ee3IIlTzGI1qL7y4POCSgWJmyCSIBkWmJoRjuBABdaX
 KM0=
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="97423939"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2020 02:28:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 02:28:25 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 6 Nov 2020 02:28:20 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <eugen.hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 02/11] dt-bindings: clock: at91: add sama7g5 pll defines
Date:   Fri, 6 Nov 2020 11:27:55 +0200
Message-ID: <1604654884-30339-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604654884-30339-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604654884-30339-1-git-send-email-claudiu.beznea@microchip.com>
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

