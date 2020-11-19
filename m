Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF642B9687
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgKSPnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:43:49 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:27317 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgKSPnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605800628; x=1637336628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=5kPPY8aoeoIt3eWzwt2rrqZVySb3GOzC6e0UsowoKcY=;
  b=AnrZleMT+KtBwnhKcLM0SSUB7DKE2nCwoln/U+p8wlFNGTtCWYBLkLvx
   kd0npG+0CNpCqMvO9Vwd08vmZZ0oLvEwOh2zwyd6JAbvrCjnkqKLr7eld
   p+CDLx3FQ0rEc8psQjFEBm5HnkCGUV2Q3evGHJuQWqozW2pyiXFGdNP3P
   xe1/jiJzjw2lLXg4A3KQHjCyaJCRnX2vXxFm9DtkvjW4pWwhag3ufzVnr
   k6WPWdT5YG3ppe+mI6nMjPSeMSk7uLrex8TMtY2KBxdsA6gX21vXwv6lK
   HjwtTpWQQi9vQxnbOwIhhThwXGJua7UW0m3VTNlyZ5TWR99/g+wBX5t2r
   w==;
IronPort-SDR: Kf/1j9a6JHwaHwwmLy6ofYVV6ulkD4Bh/np3EEcZUK/k4Znz8moWBFFDAevJuy0TkHYBsNoWY4
 +JWHhk20NJdngP3Z/DJctJxmuNHTjNpCh3foah1Qm+xSOgoWvCPnRZmBLm2bNF7wZrwH4pvH3T
 0IfXN80U3TowaxDcW+o36I4AMgRmrz+4gDlfv2s+GgnAmjg6J77kgD6xgfIARmEnpx+GgAuPva
 6zo70XytQATXohHCal1ztkURaHd3baUiTcWR7EH5Rfg5J+mjYzHP+Bm7qGtASl0OU7oeZHFb9N
 E4k=
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="99108990"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2020 08:43:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 19 Nov 2020 08:43:45 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 19 Nov 2020 08:43:42 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v6 03/11] clk: at91: sama7g5: allow SYS and CPU PLLs to be exported and referenced in DT
Date:   Thu, 19 Nov 2020 17:43:09 +0200
Message-ID: <1605800597-16720-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Allow SYSPLL and CPUPLL to be referenced as a PMC_TYPE_CORE clock
from phandle in DT.

Suggested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
[claudiu.beznea@microchip.com: adapt commit message, add CPU PLL]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sama7g5.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 7ef7963126b6..d3c3469d47d9 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -117,7 +117,8 @@ static const struct {
 		  .p = "cpupll_fracck",
 		  .l = &pll_layout_divpmc,
 		  .t = PLL_TYPE_DIV,
-		  .c = 1, },
+		  .c = 1,
+		  .eid = PMC_CPUPLL, },
 	},
 
 	[PLL_ID_SYS] = {
@@ -131,7 +132,8 @@ static const struct {
 		  .p = "syspll_fracck",
 		  .l = &pll_layout_divpmc,
 		  .t = PLL_TYPE_DIV,
-		  .c = 1, },
+		  .c = 1,
+		  .eid = PMC_SYSPLL, },
 	},
 
 	[PLL_ID_DDR] = {
-- 
2.7.4

