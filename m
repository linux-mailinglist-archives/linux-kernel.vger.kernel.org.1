Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CBE220BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 13:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbgGOLY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 07:24:56 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:62426 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729938AbgGOLYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594812294; x=1626348294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Zj8y6PhZEdQjJEh+6pVcK105guGzemj0ylKCAe8Ysco=;
  b=TrllTA33oR89kpATk8Jo51oguyd9LeORHW64Fd2vLZSVdtKSyUZ4E3WK
   We+xCH9ySeXFTOweoF3wRqxCWEeqgexLkMfZC9hz/8y2FhISx12PsaOp2
   PYQSVI2YhjNuXx05mJUyaNr1+Q/q760KkXqLGKFNCv8Ym5GtUBGPpYiR8
   wJWja3A1OGy5d0x47CWmfuQcIH0sRZwrABqG/WuCEkYF/yLixoF3sHWgn
   bM8AluP1k+9mM0SDcpTqWY75B98+Q9pTMV9ruZ59CPf0UAqvPHnEDwd1G
   aL/XBVbTAexK8nb0p8oOk8sZ4bbCS70dgBDuMBLOhTwJJinIfOCYb65H9
   A==;
IronPort-SDR: bWiHJ2HU/50IaNHpFnA5JKHNpjvKB1JTRViO+douwV1WcHubhVIk+7xHstLhqaKG9RdjZp1cya
 UJ//y4IfgAbg4xKnTqTnxS/n115Fk2EijHQUiWw0YAOFJttH9E1Rc4n1mieNpFnQ+7V+xS2L9w
 1QD4WHCwllLp4SyecIeIKpxVVaptOPrVndawPfadiCQd+18T3bt+VtN3fy3vORBUepGfxWCjlV
 e5/L4DMvf+UIspcKRXKB3ZSWXaeRHGRS8mGf3Zge1PTC0BGX21HIKkKc20BuWuvGEBnu9cEGBv
 ZNw=
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="83962806"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2020 04:24:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 15 Jul 2020 04:24:53 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 15 Jul 2020 04:24:17 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH 05/19] clk: at91: sam9x60-pll: use logical or for range check
Date:   Wed, 15 Jul 2020 14:24:13 +0300
Message-ID: <1594812267-6697-6-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use logical or for range check. In case bestrate is not in
characteristics->output[0].min..characteristics->output[0].max
range we should return -ERANGE.

Fixes: a436c2a447e59 ("clk: at91: add sam9x60 PLL driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index d3152c0afcbf..dfb91c190bd1 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -232,7 +232,7 @@ static long sam9x60_pll_get_best_div_mul(struct sam9x60_pll *pll,
 	}
 
 	/* Check if bestrate is a valid output rate  */
-	if (bestrate < characteristics->output[0].min &&
+	if (bestrate < characteristics->output[0].min ||
 	    bestrate > characteristics->output[0].max)
 		return -ERANGE;
 
-- 
2.7.4

