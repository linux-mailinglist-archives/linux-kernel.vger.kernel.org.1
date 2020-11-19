Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091D52B968D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgKSPn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:43:56 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:44855 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgKSPnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605800634; x=1637336634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=jpoo8lswkA0HTqIME8fJoefP6IOmvgmdgVpF/Ams+UA=;
  b=E7++HFO4jmM/AiKNs99eENlGFSGeSprnFNbBKPOBkAh8QjwisrfCbcUr
   +97vZIT1wben008hbgriJR0FabkvwIoQExo/8wfh9GY52KX6Z2DQ6yTfv
   pAG8ach5OMbPyJeLcnSVX6iWZqhykt36acbkLOuZpqELmize+iTmO5cHE
   oJ07PkYw8TiijbJJCB4aW/bYHI+h0wFmLXySpSCuGPT3PynyfJ4/NonRX
   As4Lyk3fhWzPpaf00yu15EwonTfgjum4zOzsllCE/hhxZV6dxg1izdKwD
   3NqFpfrg6lJQhH1mTi/bJPh0azmAl3aYt6rP97J1O3EIwuDMtmId/DZOc
   w==;
IronPort-SDR: O1GoZsAEU4+p1BkuuJI1vyyT/sPgKcjV6Dv+ETueMJmqJjfeMjeUaGPRZVb2j4/8V/TV9ayKO4
 Jf/by7I+n6enz+UaMye7IuFupExRkFWNvfbrlvsAmbgF4HIE2Gc/s04POV+w65orcPj1LynasK
 8wuwKMMRQbD8hFZtMQa/TlVn1FMHEoMatdSOLItoJNrfir3vV9Fu20xb14CqlrSMR/tVe86AVW
 +C6yqI8e0s3yy5n6O3SQoDP9NhsqgoOJLzGEbhfH+mxrylrZ1f5F7Ekfmg4aHsdBlfANJXZuwH
 VNg=
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="34306283"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2020 08:43:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 19 Nov 2020 08:43:53 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 19 Nov 2020 08:43:49 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v6 05/11] clk: at91: sama7g5: add 5th divisor for mck0 layout and characteristics
Date:   Thu, 19 Nov 2020 17:43:11 +0200
Message-ID: <1605800597-16720-6-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com>
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

