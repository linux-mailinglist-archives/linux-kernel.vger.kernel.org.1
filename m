Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D57C28E240
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 16:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgJNOel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 10:34:41 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:64356 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgJNOel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 10:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1602686080; x=1634222080;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=PWqIIrgYFnlBZctTK57JTENN4Cegf3RdR2kXRVWi9H8=;
  b=h7msTRw81JNw7sIa4evXzNjbzU/hsKh6s8WqTfhPv9Ku1CJ8XhamwjwN
   xNVxpz4DRenYINty7aG+z84u4oNVrBoDRWfvdocoEsU2jSMqi3cEEirxw
   mto+9r7Gk+s9Vf+tSL0SFAc7SuLC8PBalQKjJ/mdQsJfbukiFfMO9cgiQ
   RqH2qCwQ7IXnF4daPdW4cKwMMdh5sjoMxbx0VpOCf8f6LRgmKhe8rWrPx
   ADHnJq/h7UNlfFvbRRl27+SyJY7vxu/AzjAsRsRN9Inh3bDp3sIIB87An
   knMzirT23u04DsqlsGAY4PiSkkEI5Zy6sg7BTBxebZYaSKmsiofg6EYOq
   A==;
IronPort-SDR: 9XJCK90DN503PC9Csqo8pNA1KBLf4tzOcntSIB46oetYQ+BPXAqKySbeV9K89Xobxux98fcxqJ
 GLvZ4IaiBsyOx4JwGazqyFZb6Lan4eJNPd5yAg/n1D/jT/1Ej/17MbppjEhyVhKzBdYPkiHKoa
 p8oLApZMMYb6bb1l3ht+Jtde2Xq2GSQGXvV4JUsHoN3oPeAi2XDcaqqc5LWS83/U3R5ShJX9ik
 Yr27k1dHMnj54SjvJNvJRf3pbPpAhCElwCr8iwb8NzgKxgmqbPmF/LDMyqmdEoDGS3knbKEzDA
 XNo=
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="99491709"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Oct 2020 07:34:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 14 Oct 2020 07:34:39 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 14 Oct 2020 07:34:35 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] clk: at91: sam9x60: support only two programmable clocks
Date:   Wed, 14 Oct 2020 17:34:32 +0300
Message-ID: <1602686072-28296-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to datasheet (Chapter 29.16.13, PMC Programmable Clock Register)
there are only two programmable clocks on SAM9X60.

Fixes: 01e2113de9a5 ("clk: at91: add sam9x60 pmc driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sam9x60.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index ab6318c0589e..3c4c95603595 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -279,7 +279,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	parent_names[3] = "masterck";
 	parent_names[4] = "pllack_divck";
 	parent_names[5] = "upllck_divck";
-	for (i = 0; i < 8; i++) {
+	for (i = 0; i < 2; i++) {
 		char name[6];
 
 		snprintf(name, sizeof(name), "prog%d", i);
-- 
2.7.4

