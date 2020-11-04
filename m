Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D9E2A6C07
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 18:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbgKDRpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 12:45:55 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:55851 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731956AbgKDRpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 12:45:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604511953; x=1636047953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=5kPPY8aoeoIt3eWzwt2rrqZVySb3GOzC6e0UsowoKcY=;
  b=ImgtepVcj9fAwD1416jx4D2KmyT9i6A8ZCxdMwGO9xqI1gZ9Y0IQbhlh
   vWfLXSSn3GDAOXhCwQe5UCq0f0ZRNANazQhhJPV+H92nzpyUHstTwF8El
   qBZ/2oms0v/LGHORq6kyGrxy9LrGIzyXkmyJC/Af/qNiO5wrNo6HxbegX
   LIs8BOYT/sz/9YfnfNCtUZU82Lg6NeoYvyzwAg8XEr1OiYSTQABK1TJVH
   rIgcstKVZHCt5HFAfL21iRVs9119rVETq93/ywa+wMaErH6Rctz4TsgLD
   CLpeDZMAnd3Uy8D3sf0GUXEd7cxbMYfZfy6GXpZhwP0VjLcAVI99rgYO6
   Q==;
IronPort-SDR: hLKzlnvtInvMFhKCd/7ioCyWziccq/zEHXeeoggQTRI+DbI+JIZM9H1C0z4jDKQ/BFebbq6tkV
 DoJWNwra1U9ADljSdERZvh+RPatdQ9KHZD7SpXUsuvNP6MEDJMrDRhEZ0XRkt5inKyGvnFBXj2
 r3pgXjjb+dP6CRHRISL/c1JsQfwAd3WQ9BHfGWXk2t8BWkJ8wjwEoEU6xpr4EbSCxOlWPqt+Y2
 tKp+AjsXVt1y78fRjUZTyIqfu+olkUYwfQ2mPjNNRwQY+qghmFfnmmB6faLWv25NW8KaCSvzBQ
 6hg=
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="97768149"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Nov 2020 10:45:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 4 Nov 2020 10:45:53 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 4 Nov 2020 10:45:48 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 3/8] clk: at91: sama7g5: allow SYS and CPU PLLs to be exported and referenced in DT
Date:   Wed, 4 Nov 2020 19:45:21 +0200
Message-ID: <1604511926-29516-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604511926-29516-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604511926-29516-1-git-send-email-claudiu.beznea@microchip.com>
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

