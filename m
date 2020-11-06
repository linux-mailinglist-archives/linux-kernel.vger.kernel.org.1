Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BD22A932D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgKFJrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:47:24 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:41941 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgKFJrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604656042; x=1636192042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=jjMRv7q9dqqrQGmbGnrRipfXGN0KNE4iUh7ba8SylbQ=;
  b=tgAijdMIOeBzE+LyO9AC6PZwqu3SU/NwVVppnh6SlO1f18BMhmyx4mk7
   42rljKfOqW4SMbe7H4AozkWp4MYzQyZnixbGsTRM2tj9mgDin480liRy9
   UPh+Klfx+vz7dNVwnFKSLBnP9MTZtOfl3+2gFBGOGSTDJB539oPq9SWhj
   N/Xqv0q1fxWrCl0XxOUiBFNFRjWHzOW9rTrIyj3hm/s0tOxZ2URxfjLtx
   hiFGxB5PsLcuN5W/7rbyh1at6RE6AoYyw7YVV9W/WqbtUV0uiMVnGida0
   dEmSmukbddud6d0nT3XNPSNP7dy+IiUTFFSizb/jXB5bT+1WcxEe1X/+P
   w==;
IronPort-SDR: lOfTDp0/6VNRN3gTjOXYK6weBYd+30xG4fVvmLzcDtUSZvw7o07Z0hpKA/ul5/jmqCJYvob5u4
 nTazIVT1+kdULJC7ti41OuAzcEsEeX5xhCCg49rtMwBhAZAcaYgItm29iRyafQy9qeh26i6PxC
 qa+2+YtdN2tZ6U7OY+uQvJWDwVIli2m5iZJWccnO1mrzp3+QBPZ9MvWnPE8KQn/168y3pNBoaE
 0S5ae439uPLYMi7j+wLbvidhPi+RvWEPWsocZUudEAeqWCy20ndoqszvHVPZhMWWyyi0/aydob
 4P0=
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="97428428"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2020 02:47:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 02:47:21 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 6 Nov 2020 02:47:16 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <eugen.hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 08/11] clk: at91: sama7g5: decrease lower limit for MCK0 rate
Date:   Fri, 6 Nov 2020 11:46:25 +0200
Message-ID: <1604655988-353-9-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604655988-353-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604655988-353-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SAMA7G5 CPU clock is changed at run-time by DVFS. Since MCK0 and
CPU clock shares the same parent clock (CPUPLL clock) the MCK0 is
also changed by DVFS to avoid over/under clocking of MCK0 consumers.
The lower limit is changed to be able to set MCK0 accordingly by
DVFS.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sama7g5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 88ad0c70ca98..662e667d1098 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -788,7 +788,7 @@ static const struct clk_pll_characteristics pll_characteristics = {
 
 /* MCK0 characteristics. */
 static const struct clk_master_characteristics mck0_characteristics = {
-	.output = { .min = 140000000, .max = 200000000 },
+	.output = { .min = 50000000, .max = 200000000 },
 	.divisors = { 1, 2, 4, 3, 5 },
 	.have_div3_pres = 1,
 };
-- 
2.7.4

