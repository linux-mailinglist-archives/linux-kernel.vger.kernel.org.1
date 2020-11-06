Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DC72A92A9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgKFJ26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:28:58 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:42751 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgKFJ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604654935; x=1636190935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=jjMRv7q9dqqrQGmbGnrRipfXGN0KNE4iUh7ba8SylbQ=;
  b=UpplPGLHt7b4Y9RgOWpUa+/UsD3w5iPu9DTOk1ATEwKDLtyadjDztMan
   whEbm7BJK/71GGdQKrJ2xl0x2PbWl6lRcfQaNZlQQ54fUMEe5SwOUDx90
   3Lc7bNfZG2T+WqI+j6G3aoRc/vlHQDOaP8B3ZMNR/wtyubKa+YpjcgzzZ
   l0oZ+1xYPrV3vAju6J8wdWkf1E37GGuLu0kP86D0c5gVNZ3SHFPA90Wtv
   rZD5IO56o+3gD3bvB6tXR9CTU20Uso0/v5N0pVctYOVdzRV+XzFckOPPG
   SIVMXBB391JyUngwO4KMSeBypQMQxMQgFQTyrKaEC9DOOD6Sqle/eKnS8
   Q==;
IronPort-SDR: tj1sQpRLPM1bEAO0MNm5WiMkq93uhUV9qLzGiQ4hn+/yRpjFKeQnj/cuHd9T0DjM1fd5Jt6ShE
 2yEbjmmsX1sRtxZfDfScL8/C0G7eE8Se/MiYiDddC3s8N7WXaSXJ35hi0mMmk4GiqELyEcCGnk
 18/pMdmdh77LLfdtJu7K7z/y9i+/YddxjlCixRpt6kA6gn02yGW7YArqyWru697x/qXBz7qI2H
 Gnqt04JZRsRxHnhAcktGXHwSRfuwATcy66gA9BJPkkBFS5o0udFHwIgW3cghviVx5UuQ7j9mal
 WHU=
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="102448321"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2020 02:28:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 02:28:54 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 6 Nov 2020 02:28:50 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <eugen.hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 08/11] clk: at91: sama7g5: decrease lower limit for MCK0 rate
Date:   Fri, 6 Nov 2020 11:28:01 +0200
Message-ID: <1604654884-30339-9-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604654884-30339-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604654884-30339-1-git-send-email-claudiu.beznea@microchip.com>
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

