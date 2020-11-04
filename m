Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1403C2A60B5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 10:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgKDJkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 04:40:33 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:50122 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbgKDJk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 04:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604482828; x=1636018828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=5kPPY8aoeoIt3eWzwt2rrqZVySb3GOzC6e0UsowoKcY=;
  b=0yU/wuH2JWTikYjVjFdOZoGH8AIUeimn0ACi5z0pmCd6ZbWX39ViEYAo
   5i7Le3zLe8Y33GK6dNnrp2JXs6KS/9nNxBTgEpSauKuMKaqmzklvZz40b
   eSWKLP/4dYZJp7f7RJp38Tb7vSqLaOR9X3nN9tgRGlDykDDqFYLZAzxZq
   8eDgANcmSb9MkjImer0syBD05YEvcLr19hmyL+82OTtqI/G3XVzcH8CUD
   lzFxLGz6RfUBcdyBbUd43s+A2/hEbfcpr7DwYVsc+D9e0/gtCC9GW4JBT
   FDNTC39uDVGmFrAdZU0kE/PdVJOE+1t+NGxpNwIe25l8tB9lRm3FHUkr/
   A==;
IronPort-SDR: 5CJdxmzde2U9ZpOWghYmAcBvYOUxJPrhmbBtdpREsK7rEDpO2gafgLLIFpqDjCXEo7zR12h8Mr
 rv16GMPBfaN0YBhM38jJBZsb/HrMgTaQpNzfx6ffEJPBwAW8gqH3a3Klcmh07fRC6KLy0s1YzQ
 VX7s3sxH1WmQpOXe28Ed351gZIDCz/hMGoxLXed0qtgbScBenxWJtrWiOeJjIrhEH3v8BUaoC0
 9Dl7YEcxA5cbO1RxmJ+dHQZAbo7j7EyjW1u7RUkjmNZVbXsUFBNUEUmhO5dii2TNuqICOLWY6g
 s3c=
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="32375260"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Nov 2020 02:40:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 4 Nov 2020 02:40:27 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 4 Nov 2020 02:40:22 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/8] clk: at91: sama7g5: allow SYS and CPU PLLs to be exported and referenced in DT
Date:   Wed, 4 Nov 2020 11:39:57 +0200
Message-ID: <1604482802-1647-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604482802-1647-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604482802-1647-1-git-send-email-claudiu.beznea@microchip.com>
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

