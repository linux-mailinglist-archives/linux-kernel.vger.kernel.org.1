Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E772B94D7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgKSOjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:39:03 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:41627 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbgKSOjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605796741; x=1637332741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=jpoo8lswkA0HTqIME8fJoefP6IOmvgmdgVpF/Ams+UA=;
  b=bTpRUNcl+tPPCHw3t+OqjxDwGlHGl9i+y6wfrEEUP2ZDwbWtk1UIuR+S
   j/rXBCBkuzGWAPxiCzME9N8SSh1WOJrKMH/bqCraH3K1bO6Wv1+dAnQH1
   XfS5AXWame+HX/1SNr+yJi0fPV9Bi4R0ikoSZOkCp8qqB3ujDOnSZRArE
   A/XFMk4I5IrqNjeaP67v5mFzKTh+QtEfLDH4yndY3PZJk7FrGYiNCHeKo
   JAo+Bmqb+fUW1grIjMxOynzRPBTVx1Z0oGcb0Fr6CRu+0yAPV38tbl01w
   KKPqE6FGg3TB1ThPc2ogRWIyO8WaKoTH9RIBrX7/GIKnK/Z6r21knsimu
   A==;
IronPort-SDR: C0YYKXZ+OiTJGCzpbVhGiXgNdPFO2Aa/pjE/iwkko1MEqHp9Uv3cbPhd6aMNqpGcFyZ9FdSssO
 wvyifB1lMJ7MnIJeL5Zv9tFk4WnlN96dnPWeksYnMDzBQTqUHI2zw/AteT3O2T+8dZL1OuWOeZ
 qw3pYLqg4W9Zb+sTUMFZwJUE3LP/EIaoQCV3IhZgxn3IxEQ63jkvjQmekV97uNgdxNZSXAbH2h
 phbvfhy/ljnuJSFAuIfATugBxrcCPJVjWbfosHQaodztuEeJQf2ycVnwSSXHKsk/39A+PeY3i+
 MzU=
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="94237994"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2020 07:39:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 19 Nov 2020 07:38:59 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 19 Nov 2020 07:38:56 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 05/11] clk: at91: sama7g5: add 5th divisor for mck0 layout and characteristics
Date:   Thu, 19 Nov 2020 16:38:21 +0200
Message-ID: <1605796707-8378-6-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605796707-8378-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605796707-8378-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

This SoC has the 5th divisor for the mck0 master clock.
Adapt the characteristics accordingly.

Reported-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sama7g5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index d3c3469d47d9..d685e22b2014 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -775,13 +775,13 @@ static const struct clk_pll_characteristics pll_characteristics = {
 /* MCK0 characteristics. */
 static const struct clk_master_characteristics mck0_characteristics = {
 	.output = { .min = 140000000, .max = 200000000 },
-	.divisors = { 1, 2, 4, 3 },
+	.divisors = { 1, 2, 4, 3, 5 },
 	.have_div3_pres = 1,
 };
 
 /* MCK0 layout. */
 static const struct clk_master_layout mck0_layout = {
-	.mask = 0x373,
+	.mask = 0x773,
 	.pres_shift = 4,
 	.offset = 0x28,
 };
-- 
2.7.4

