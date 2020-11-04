Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90E22A6C14
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 18:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgKDRqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 12:46:20 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:61524 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731989AbgKDRqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 12:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604511976; x=1636047976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=yNe87cwhRVMdWKeHtJGcsT1XWZIF6VhtsmEJEnhlIGY=;
  b=AUTdx4xUyPkKztjGX0tXhbcKKfUPNSKHlqz+KeNsd+S6ZAKIDCU7SSOa
   3XBRI6v0vIiZD6IihH+hnAB3ienAtTubMeYW/GNtHP1873U5MouEG2IWb
   BEZjdc+Wx37Hh9/6M3GTEHKUKOYnuzyhEG7HPNltsCbgfMnv+eXJH2Xuh
   eDZjPSGE1QeLOr95qCfzp4eauDUHxudTWpB3/8IOD2Nxvo3eKSN68cocp
   VmNeY9oBiva2NNdnVWFeJ8lO+LGT4sPf1BEfIguwwWvmDGV1zA3XK8vuv
   j4Z+Fn/8QpFElzsMTw3RZXSKBzN7YjtlzVWO8zAGvFFbvTFHbEEguzKBP
   g==;
IronPort-SDR: a0PifpwTopNkxlUDtA2Fj/NefPhoCw2g6pC5N8JIN/5RZJFtoTtJmSXBu5OiUxCKmjnMaCptN1
 2IlIg3QVxkOUrSzzrFgogikvkGtWFJQkNXsmiD8sgVAYNPAMwI028q/R7lJcvJCKUABtvSP36E
 686+LFwtMWcC8SaGpx72Q723JFmFdxqI+LY8gTZX5xdroTwuaeNwIPFOh30Dx0P/uVoft0IMyK
 KMJW9PGUe1/2VNJpEI2oPN8EnUoRxoCC+g4XRsmWLQZHJ7bcPfZM95rT7ur14eHloOHd7pwGjw
 HO4=
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="32429975"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Nov 2020 10:46:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 4 Nov 2020 10:46:10 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 4 Nov 2020 10:46:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 6/8] clk: at91: sama7g5: decrease lower limit for MCK0 rate
Date:   Wed, 4 Nov 2020 19:45:24 +0200
Message-ID: <1604511926-29516-7-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604511926-29516-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604511926-29516-1-git-send-email-claudiu.beznea@microchip.com>
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
index b8d666f3e431..7d65fd9ceb50 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -788,7 +788,7 @@ static const struct clk_pll_characteristics pll_characteristics = {
 
 /* MCK0 characteristics. */
 static const struct clk_master_characteristics mck0_characteristics = {
-	.output = { .min = 140000000, .max = 200000000 },
+	.output = { .min = 50000000, .max = 200000000 },
 	.divisors = { 1, 2, 4, 3 },
 	.have_div3_pres = 1,
 };
-- 
2.7.4

