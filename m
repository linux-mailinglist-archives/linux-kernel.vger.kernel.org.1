Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0E32B9694
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgKSPoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:44:08 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:51634 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbgKSPoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605800646; x=1637336646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=4ZwxjUQBBXtTsmCLYSQXtv2JDFLE5N+4iQm2djDoMQE=;
  b=lWtkFFbUgr+Rccr+vtGPL+TquXgaIPFONEHZrAzUqkpiah8PlVTvs5dx
   T/ulTOXHq4dLRWg/AauHqQwd5rXm427ViLHP92CZXbsuhTrZXE62U4hGQ
   EAH/7redUuZ4EMvoHFzcUGqrfII61UMB+X3BnYF+Jd7dU/sGo4aqMou/q
   9URVW+UMtnzNvDgOpNvMLvBUDKzos+VKMy9qK5FItT0QSe0jLRuZ43t1P
   qzbRBOVtaGpC1Bmxu8lOP7qr+uLeJWEwykVO/vs333gmb6omZXrYoUvk1
   blno2sHUgUe6eHPWanLwyImWvKWmIfvPF09PctG96p9BMerTKargB3bwS
   w==;
IronPort-SDR: 9Kb9OVrlMwEovzgS4ZucYQysyNRBjDDRBGj2vs8gPru2YfcyO59lHgBsvDFL+Kq/4bKMR1+oCw
 jnoAoG6qBwNKciW7SwWJinMcnZrQpZbhj3GFShasO2qgG9ZTmP1A0mKzXjrxvdpUc5FtePNKd9
 U2h/4kAG1lpkNGutZ1qt9tQoiHkkD5dfhjChQWABrccOG/d89HFhdDLsgAtGUrBqANPZvKZZSL
 P0BrM8Dnar23eRpjSMWG+65DR+cjUrJAvVjLwMqMyJlvs1r+aBDF5huZ0mUQJz8fX9MjlcBFzv
 8Us=
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="96942080"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2020 08:44:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 19 Nov 2020 08:44:05 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 19 Nov 2020 08:44:01 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v6 08/11] clk: at91: sama7g5: decrease lower limit for MCK0 rate
Date:   Thu, 19 Nov 2020 17:43:14 +0200
Message-ID: <1605800597-16720-9-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com>
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
index 335e9c943c65..29d9781e6712 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -807,7 +807,7 @@ static const struct clk_pll_characteristics pll_characteristics = {
 
 /* MCK0 characteristics. */
 static const struct clk_master_characteristics mck0_characteristics = {
-	.output = { .min = 140000000, .max = 200000000 },
+	.output = { .min = 50000000, .max = 200000000 },
 	.divisors = { 1, 2, 4, 3, 5 },
 	.have_div3_pres = 1,
 };
-- 
2.7.4

